import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/models/voice_effect.dart';
import '../../../shared/providers/call_provider.dart';
import '../../../shared/providers/voice_effect_provider.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final call = ref.watch(activeCallProvider);
    if (call == null) {
      return const Scaffold(body: Center(child: Text('No active call')));
    }

    final elapsed = DateTime.now().difference(call.startedAt);
    return Scaffold(
      appBar: AppBar(title: const Text('Calling...')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(call.targetNumber, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text('${elapsed.inMinutes.toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}'),
            const SizedBox(height: 8),
            Text('Effect: ${call.effect.name}'),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _circleButton(icon: call.isMuted ? Icons.mic_off : Icons.mic, onTap: () => ref.read(activeCallProvider.notifier).toggleMute()),
                _circleButton(icon: call.isSpeakerOn ? Icons.volume_up : Icons.hearing, onTap: () => ref.read(activeCallProvider.notifier).toggleSpeaker()),
                _circleButton(
                  icon: Icons.graphic_eq,
                  onTap: () {
                    final current = ref.read(selectedVoiceEffectProvider);
                    final presets = VoiceEffect.presets;
                    final currentIndex = presets.indexWhere((e) => e.id == current.id);
                    final next = presets[(currentIndex + 1) % presets.length];
                    ref.read(selectedVoiceEffectProvider.notifier).state = next;
                    ref.read(activeCallProvider.notifier).changeEffect(next);
                  },
                ),
                _circleButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onTap: () {
                    ref.read(activeCallProvider.notifier).end();
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap, Color? color}) {
    return FloatingActionButton(onPressed: onTap, backgroundColor: color, child: Icon(icon));
  }
}
