import '../shared/models/call_session.dart';
import '../shared/models/voice_effect.dart';
import 'signaling_service.dart';
import 'webrtc_service.dart';

class CallManager {
  CallManager({required this.webrtc, required this.signaling});

  final WebRTCService webrtc;
  final SignalingService signaling;

  Future<CallSession> startCall(String number, VoiceEffect effect) async {
    await webrtc.init();
    return CallSession(targetNumber: number, startedAt: DateTime.now(), effect: effect);
  }

  Future<void> endCall() async {
    await webrtc.dispose();
  }
}
