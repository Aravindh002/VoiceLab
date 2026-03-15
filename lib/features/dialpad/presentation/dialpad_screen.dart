import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../shared/providers/call_provider.dart';
import '../../../shared/providers/voice_effect_provider.dart';

class DialpadScreen extends ConsumerStatefulWidget {
  const DialpadScreen({super.key});

  @override
  ConsumerState<DialpadScreen> createState() => _DialpadScreenState();
}

class _DialpadScreenState extends ConsumerState<DialpadScreen> {
  final _number = StringBuffer();

  @override
  Widget build(BuildContext context) {
    final effect = ref.watch(selectedVoiceEffectProvider);
    final digits = _number.toString();
    const keys = ['1','2','3','4','5','6','7','8','9','*','0','#'];

    return Scaffold(
      appBar: AppBar(title: const Text('Dial Pad')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GlassCard(child: Column(children: [
              Text(digits.isEmpty ? 'Enter number' : digits, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Voice: ${effect.name}'),
            ])),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: keys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.1),
                itemBuilder: (_, index) {
                  final key = keys[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: FilledButton(
                      onPressed: () => setState(() => _number.write(key)),
                      child: Text(key, style: const TextStyle(fontSize: 28)),
                    ),
                  );
                },
              ),
            ),
            GradientButton(
              label: 'Call Now',
              icon: Icons.call,
              onPressed: digits.isEmpty
                  ? null
                  : () async {
                      await ref.read(activeCallProvider.notifier).start(digits, effect);
                      if (context.mounted) context.push('/call');
                    },
            )
          ],
        ),
      ),
    );
  }
}
