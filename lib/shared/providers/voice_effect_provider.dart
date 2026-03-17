import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/voice_effect.dart';

final selectedVoiceEffectProvider = StateProvider<VoiceEffect>((ref) => VoiceEffect.presets.first);
