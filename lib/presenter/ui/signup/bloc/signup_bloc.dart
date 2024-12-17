import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/client/api_client.dart';
import '../../login/login_req_model.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final ApiClient apiService; // Your Retrofit service class
  SignupBloc({required this.apiService}) : super(SignupInitialState()) {
    on<SignupSubmitted>((event, emit) {
      emit(SignupLoadingState());
      handleSignupButtonClick(event.email, event.password, emit);
    });
  }

  void handleSignupButtonClick(
      String email, String password, Emitter<SignupState> emit) async {
    try {
      final loginRequest = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await apiService.registerUser(loginRequest);
      if (response.token != null && response.token!.isNotEmpty) {
        emit(SignupSuccessState(token: response.token!));
      } else {
        emit(SignupFailureState(errorMessage: "Invalid username or password"));
      }
    } catch (e) {
      emit(SignupFailureState(errorMessage: e.toString()));
    }
  }
}
