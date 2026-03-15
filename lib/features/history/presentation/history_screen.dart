import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(callHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Call History')),
      body: history.isEmpty
          ? const Center(child: Text('No call records yet.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (_, index) {
                final item = history[index];
                return ListTile(
                  leading: const Icon(Icons.call),
                  title: Text(item.number),
                  subtitle: Text('${item.effectName} • ${item.duration.inSeconds}s'),
                  trailing: Text(DateFormat.Hm().format(item.time)),
                );
              },
            ),
    );
  }
}
