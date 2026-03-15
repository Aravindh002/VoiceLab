import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/call_history_item.dart';

final callHistoryProvider = StateProvider<List<CallHistoryItem>>((ref) => []);
