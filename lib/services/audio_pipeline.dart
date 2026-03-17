class AudioPipeline {
  const AudioPipeline({this.sampleRate = 48000, this.frameSize = 960});

  final int sampleRate;
  final int frameSize;

  List<double> normalize(List<double> frame) {
    final peak = frame.fold<double>(0, (p, s) => s.abs() > p ? s.abs() : p);
    if (peak == 0) return frame;
    final gain = 1 / peak;
    return frame.map((s) => s * gain).toList(growable: false);
  }
}
