import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/app_user.dart';

final authProvider = StateNotifierProvider<AuthController, AsyncValue<AppUser?>>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<AsyncValue<AppUser?>> {
  AuthController() : super(const AsyncData(null));

  Future<void> loginWithOtp(String phone, String otp) async {
    state = const AsyncLoading();
    await Future<void>.delayed(const Duration(milliseconds: 600));
    state = AsyncData(AppUser(uid: 'uid_$phone', phoneNumber: phone, credits: 5));
  }

  void logout() => state = const AsyncData(null);
}
