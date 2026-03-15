import '../shared/models/voice_effect.dart';
import 'audio_pipeline.dart';

class VoiceEffectEngine {
  VoiceEffectEngine(this._pipeline);

  final AudioPipeline _pipeline;

  List<double> process(List<double> inputFrame, VoiceEffect effect) {
    final normalized = _pipeline.normalize(inputFrame);
    return normalized.map((sample) {
      final pitched = sample * effect.pitch;
      return pitched * effect.formant;
    }).toList(growable: false);
  }
}
