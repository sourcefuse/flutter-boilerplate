abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String email, fullName, password, confirmPassword;

  SignupSubmitted(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword});
}
