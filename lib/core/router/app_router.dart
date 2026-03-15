import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/call/presentation/call_screen.dart';
import '../../features/dialpad/presentation/dialpad_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/voice_effects/presentation/voice_effects_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeScreen(shell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/dialpad', builder: (_, __) => const DialpadScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/effects', builder: (_, __) => const VoiceEffectsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/wallet', builder: (_, __) => const WalletScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/history', builder: (_, __) => const HistoryScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen())]),
        ],
      ),
      GoRoute(path: '/call', builder: (_, __) => const CallScreen()),
    ],
  );
});

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(label)));
}
