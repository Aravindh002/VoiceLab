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
  final StringBuffer _number = StringBuffer();

  @override
  Widget build(BuildContext context) {
    final effect = ref.watch(selectedVoiceEffectProvider);
    final digits = _number.toString();

    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dial Pad'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 📞 Display
            GlassCard(
              child: Column(
                children: [
                  Text(
                    digits.isEmpty ? 'Enter number' : digits,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Voice: ${effect.name}'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔢 Dialpad
            Expanded(
              child: GridView.builder(
                itemCount: keys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (_, index) {
                  final key = keys[index];

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        setState(() {
                          _number.write(key);
                        });
                      },
                      child: Text(
                        key,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// 📲 Call Button
            GradientButton(
              label: 'Call Now',
              icon: Icons.call,
              onPressed: digits.isEmpty
                  ? null
                  : () {
                      ref
                          .read(callControllerProvider.notifier)
                          .startCall(digits); // ✅ FIXED

                      if (context.mounted) {
                        context.push('/call');
                      }
                    },
            ),

            const SizedBox(height: 10),

            /// ❌ Clear Button
            if (digits.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _number.clear();
                  });
                },
                child: const Text('Clear'),
              ),
          ],
        ),
      ),
    );
  }
}
