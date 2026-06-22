import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'staff_dto.dart';

part 'staff_repository.g.dart';

@riverpod
StaffRepository staffRepository(StaffRepositoryRef ref) =>
    StaffRepository(ref.watch(dioProvider));

class StaffRepository {
  StaffRepository(this._dio);
  final Dio _dio;

  Future<List<StaffJobListItemDto>> getJobs() async {
    try {
      final r = await _dio.get<List<dynamic>>('/staff/jobs');
      return r.data!
          .map((e) => StaffJobListItemDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<StaffJobDto> getJob(int bookingId) async {
    try {
      final r =
          await _dio.get<Map<String, dynamic>>('/staff/jobs/$bookingId');
      return StaffJobDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<StaffJobDto> acceptJob(int bookingId) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
          '/staff/jobs/$bookingId/accept');
      return StaffJobDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<StaffJobDto> updateStatus(int bookingId, String status) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/staff/jobs/$bookingId/status',
        data: {'status': status},
      );
      return StaffJobDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<StaffJobDto> toggleTask(int bookingId, int taskId) async {
    try {
      // Backend contract: POST /staff/jobs/{id}/tasks with {"task_id": ...}
      // returns the toggled task only — refetch the job for the full state.
      await _dio.post<Map<String, dynamic>>(
        '/staff/jobs/$bookingId/tasks',
        data: {'task_id': taskId},
      );
      return getJob(bookingId);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  /// Upload a photo: presign → PUT to S3 → record on backend
  Future<void> uploadPhoto(int bookingId, String kind, File file) async {
    try {
      // 1. Presign
      final presignRes = await _dio.post<Map<String, dynamic>>(
        '/staff/jobs/$bookingId/photos/presign',
        data: {'kind': kind},
      );
      final presign = PresignResponseDto.fromJson(presignRes.data!);

      // 2. Upload to S3 (plain HTTP PUT, no auth header)
      final uploadDio = Dio();
      await uploadDio.put(
        presign.uploadUrl,
        data: file.openRead(),
        options: Options(
          headers: {
            Headers.contentLengthHeader: await file.length(),
            'Content-Type': 'image/jpeg',
          },
        ),
      );

      // 3. Record
      await _dio.post<void>(
        '/staff/jobs/$bookingId/photos/record',
        data: {'kind': kind, 's3_key': presign.s3Key},
      );
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
