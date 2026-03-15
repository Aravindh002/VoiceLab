import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../shared/providers/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone Number (+123...)')),
            const SizedBox(height: 12),
            TextField(controller: _otpController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'OTP')),
            const SizedBox(height: 24),
            GradientButton(
              label: authState.isLoading ? 'Verifying...' : 'Continue',
              icon: Icons.lock_open_rounded,
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      if (!Validators.isValidPhone(_phoneController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid phone number')));
                        return;
                      }
                      await ref.read(authProvider.notifier).loginWithOtp(_phoneController.text, _otpController.text);
                      if (mounted) context.go('/dialpad');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
