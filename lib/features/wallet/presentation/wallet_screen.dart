import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../shared/providers/wallet_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credits = ref.watch(walletCreditsProvider);
    final packages = ref.watch(walletPackagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Available Minutes', style: Theme.of(context).textTheme.titleMedium),
            Text('$credits min', style: Theme.of(context).textTheme.headlineMedium),
          ])),
          const SizedBox(height: 16),
          ...packages.map((pkg) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${pkg.minutes} minutes'),
                      GradientButton(
                        label: '\$${pkg.price.toStringAsFixed(2)}',
                        icon: Icons.shopping_cart_checkout,
                        onPressed: () {
                          ref.read(walletCreditsProvider.notifier).state += pkg.minutes;
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
