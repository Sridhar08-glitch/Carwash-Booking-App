import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session_controller.dart';
import '../auth/session_state.dart';

export '../auth/session_state.dart';

/// Alias so the router and other consumers can watch session state cleanly.
final sessionStateProvider = sessionControllerProvider;
