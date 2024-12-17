// Signup_state.dart
abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final String token;

  SignupSuccessState({required this.token});
}

class SignupFailureState extends SignupState {
  final String errorMessage;

  SignupFailureState({required this.errorMessage});
}
