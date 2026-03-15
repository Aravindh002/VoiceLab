import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/call_manager.dart';
import '../../services/signaling_service.dart';
import '../../services/webrtc_service.dart';
import '../models/call_session.dart';
import '../models/voice_effect.dart';

final callManagerProvider = Provider<CallManager>((ref) {
  throw UnimplementedError('Provide Firebase dependencies in production setup.');
});

final activeCallProvider = StateNotifierProvider<CallController, CallSession?>((ref) {
  return CallController();
});

class CallController extends StateNotifier<CallSession?> {
  CallController() : super(null);

  Future<void> start(String number, VoiceEffect effect) async {
    state = CallSession(targetNumber: number, startedAt: DateTime.now(), effect: effect);
  }

  void toggleMute() => state = state?.copyWith(isMuted: !(state?.isMuted ?? false));

  void toggleSpeaker() => state = state?.copyWith(isSpeakerOn: !(state?.isSpeakerOn ?? false));

  void changeEffect(VoiceEffect effect) => state = state?.copyWith(effect: effect);

  void end() => state = null;
}
