import 'package:clean_arch/network/client/api_client.dart';
import 'package:clean_arch/presenter/ui/login/login_req_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiClient apiService; // Your Retrofit service class

  LoginBloc({required this.apiService}) : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) {
      ///----On LoginButtonPressedEvent
      emit(LoginLoadingState());
      handleLoginButtonClick(event.email, event.password, emit);
    });
  }

  ///----------Functions to handle the page state
  void handleLoginButtonClick(
      String email, String password, Emitter<LoginState> emit) async {
    try {
      final loginRequest = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await apiService.loginUser(loginRequest);

      // Check if the response contains a token (successful login)
      if (response.token != null && response.token!.isNotEmpty) {
        emit(LoginSuccessState(token: response.token!));
      } else {
        emit(LoginFailureState(errorMessage: "Invalid username or password"));
      }
    } catch (e) {
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }
}
