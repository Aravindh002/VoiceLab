import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../shared/models/voice_effect.dart';
import '../../../shared/providers/voice_effect_provider.dart';

class VoiceEffectsScreen extends ConsumerWidget {
  const VoiceEffectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedVoiceEffectProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Effects')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final effect = VoiceEffect.presets[index];
          final isSelected = effect.id == selected.id;
          return InkWell(
            onTap: () => ref.read(selectedVoiceEffectProvider.notifier).state = effect,
            borderRadius: BorderRadius.circular(20),
            child: GlassCard(
              child: Row(
                children: [
                  Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off),
                  const SizedBox(width: 12),
                  Expanded(child: Text(effect.name, style: Theme.of(context).textTheme.titleMedium)),
                  Text('P ${effect.pitch.toStringAsFixed(2)}  F ${effect.formant.toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: VoiceEffect.presets.length,
      ),
    );
  }
}
