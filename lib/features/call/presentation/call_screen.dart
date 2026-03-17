import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/providers/call_provider.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  Timer? _timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final call = ref.watch(callControllerProvider);

    if (!call.isCalling) {
      return const Scaffold(
        body: Center(child: Text('No active call')),
      );
    }

    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: const Text('Calling...')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              call.phoneNumber ?? 'Unknown',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text('$minutes:$secs'),
            const SizedBox(height: 8),
            Text('Voice Mode: ${call.voiceMode}'),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _circleButton(
                  icon: Icons.record_voice_over,
                  onTap: () {
                    ref
                        .read(callControllerProvider.notifier)
                        .changeVoice('Female');
                  },
                ),
                _circleButton(
                  icon: Icons.graphic_eq,
                  onTap: () {
                    ref
                        .read(callControllerProvider.notifier)
                        .changeVoice('Cartoon');
                  },
                ),
                _circleButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onTap: () {
                    ref.read(callControllerProvider.notifier).endCall();
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

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: color,
      child: Icon(icon),
    );
  }
}
