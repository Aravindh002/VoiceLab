// ignore_for_file: use_build_context_synchronously

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
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📱 Phone Input
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number (+123...)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // 🔐 OTP Input
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // 🚀 Button
            GradientButton(
              label: authState.isLoading ? 'Verifying...' : 'Continue',
              icon: Icons.lock_open_rounded,
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      // 1. Check validation BEFORE the async gap
                      if (!Validators.isValidPhone(_phoneController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid phone number')),
                        );
                        return;
                      }

                      // 2. Perform the async operation
                      await ref.read(authProvider.notifier).loginWithOtp(
                            _phoneController.text.trim(),
                            _otpController.text.trim(),
                          );

                      // 3. THE FIX: Check mounted right after the await
                      // This tells Flutter: "Only proceed if this widget is still on screen"
                      if (!mounted) return;

                      // 4. Use the context directly, not via a saved 'ctx' variable
                      context.go('/dialpad');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
