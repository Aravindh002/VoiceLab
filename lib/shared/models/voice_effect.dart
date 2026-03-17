class VoiceEffect {
  const VoiceEffect({
    required this.id,
    required this.name,
    required this.pitch,
    required this.formant,
  });

  final String id;
  final String name;
  final double pitch;
  final double formant;

  static const presets = [
    VoiceEffect(id: 'female', name: 'Female', pitch: 1.2, formant: 1.1),
    VoiceEffect(id: 'male', name: 'Male', pitch: 0.9, formant: 0.9),
    VoiceEffect(id: 'kid', name: 'Kid', pitch: 1.5, formant: 1.3),
    VoiceEffect(id: 'robot', name: 'Robot', pitch: 1.0, formant: 0.8),
    VoiceEffect(id: 'alien', name: 'Alien', pitch: 1.35, formant: 0.7),
    VoiceEffect(id: 'deep', name: 'Deep', pitch: 0.75, formant: 0.85),
  ];
}
