import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Call State Model
class CallState {
  final bool isCalling;
  final String? phoneNumber;
  final String voiceMode;

  CallState({
    required this.isCalling,
    this.phoneNumber,
    this.voiceMode = 'Male',
  });

  CallState copyWith({
    bool? isCalling,
    String? phoneNumber,
    String? voiceMode,
  }) {
    return CallState(
      isCalling: isCalling ?? this.isCalling,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      voiceMode: voiceMode ?? this.voiceMode,
    );
  }
}

/// Call Controller
class CallController extends StateNotifier<CallState> {
  CallController() : super(CallState(isCalling: false));

  /// Start Call
  void startCall(String number) {
    state = state.copyWith(
      isCalling: true,
      phoneNumber: number,
    );
  }

  /// End Call
  void endCall() {
    state = state.copyWith(
      isCalling: false,
      phoneNumber: null,
    );
  }

  /// Change Voice Mode
  void changeVoice(String mode) {
    state = state.copyWith(
      voiceMode: mode,
    );
  }
}

/// Provider
final callControllerProvider = StateNotifierProvider<CallController, CallState>(
  (ref) => CallController(),
);
