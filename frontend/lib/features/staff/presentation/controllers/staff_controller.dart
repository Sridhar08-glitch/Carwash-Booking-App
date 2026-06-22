import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/staff_dto.dart';
import '../../data/staff_repository.dart';

part 'staff_controller.freezed.dart';
part 'staff_controller.g.dart';

// ── Jobs list ────────────────────────────────────────────────────────────────

@riverpod
class StaffJobsController extends _$StaffJobsController {
  @override
  Future<List<StaffJobListItemDto>> build() =>
      ref.watch(staffRepositoryProvider).getJobs();

  Future<void> refresh() => update(
        (_) => ref.read(staffRepositoryProvider).getJobs(),
        onError: (e, s) => <StaffJobListItemDto>[],
      );
}

// ── Single job ───────────────────────────────────────────────────────────────

@freezed
class StaffJobState with _$StaffJobState {
  const factory StaffJobState({
    required StaffJobDto job,
    @Default(false) bool isUpdating,
    String? error,
  }) = _StaffJobState;
}

@riverpod
class StaffJobController extends _$StaffJobController {
  @override
  Future<StaffJobState> build(int bookingId) async {
    final job = await ref.read(staffRepositoryProvider).getJob(bookingId);
    return StaffJobState(job: job);
  }

  Future<void> accept() => _run(() =>
      ref.read(staffRepositoryProvider).acceptJob(
            state.value!.job.bookingId,
          ));

  Future<void> updateStatus(String status) => _run(() =>
      ref.read(staffRepositoryProvider).updateStatus(
            state.value!.job.bookingId,
            status,
          ));

  Future<void> toggleTask(int taskId) => _run(() =>
      ref.read(staffRepositoryProvider).toggleTask(
            state.value!.job.bookingId,
            taskId,
          ));

  Future<void> uploadPhoto(String kind) async {
    final picker = ImagePicker();
    final picked =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (picked == null) return;

    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isUpdating: true));
    try {
      await ref.read(staffRepositoryProvider).uploadPhoto(
            current.job.bookingId,
            kind,
            File(picked.path),
          );
      // Refresh job to get updated photo list
      final refreshed = await ref
          .read(staffRepositoryProvider)
          .getJob(current.job.bookingId);
      state = AsyncData(StaffJobState(job: refreshed));
    } catch (e) {
      state = AsyncData(current.copyWith(
          isUpdating: false, error: e.toString()));
    }
  }

  Future<void> _run(Future<StaffJobDto> Function() action) async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(isUpdating: true, error: null));
    try {
      final updated = await action();
      state = AsyncData(StaffJobState(job: updated));
    } catch (e) {
      state = AsyncData(
          current.copyWith(isUpdating: false, error: e.toString()));
    }
  }
}
