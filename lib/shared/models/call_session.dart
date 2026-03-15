import 'voice_effect.dart';

class CallSession {
  const CallSession({
    required this.targetNumber,
    required this.startedAt,
    required this.effect,
    this.isMuted = false,
    this.isSpeakerOn = false,
  });

  final String targetNumber;
  final DateTime startedAt;
  final VoiceEffect effect;
  final bool isMuted;
  final bool isSpeakerOn;

  Duration get elapsed => DateTime.now().difference(startedAt);

  CallSession copyWith({VoiceEffect? effect, bool? isMuted, bool? isSpeakerOn}) {
    return CallSession(
      targetNumber: targetNumber,
      startedAt: startedAt,
      effect: effect ?? this.effect,
      isMuted: isMuted ?? this.isMuted,
      isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn,
    );
  }
}
