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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

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
      appBar: AppBar(title: const Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 📱 Phone Field
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number (+123...)',
              ),
            ),

            const SizedBox(height: 12),

            /// 🔐 OTP Field
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
              ),
            ),

            const SizedBox(height: 24),

            /// 🚀 Button
            GradientButton(
              label: authState.isLoading ? 'Verifying...' : 'Continue',
              icon: Icons.lock_open_rounded,
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      final phone = _phoneController.text.trim();
                      final otp = _otpController.text.trim();

                      /// Validate
                      if (!Validators.isValidPhone(phone)) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid phone number')),
                        );
                        return;
                      }

                      /// Login
                      await ref
                          .read(authProvider.notifier)
                          .loginWithOtp(phone, otp);

                      /// IMPORTANT FIX
                      if (!mounted) return;

                      /// Navigation (safe)
                      // ignore: use_build_context_synchronously
                      context.go('/dialpad');
                    },
            ),
          ],
        ),
      ),
    );
  }
}
