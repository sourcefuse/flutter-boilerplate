import 'package:clean_arch/common/constants/constants.dart';
import 'package:clean_arch/network/client/api_client.dart';
import 'package:clean_arch/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textformfield.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController =
      TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController _passwordController =
      TextEditingController(text: "cityslicka");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (context) => LoginBloc(apiService: ApiClient()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Routes.navigateAndRemoveAll(context, Routes.dashboard);
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Login successful! Token: ${state.token}'),
              // ));
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Login failed: ${state.errorMessage}'),
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Username Field
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    isRequired: true,
                    inputType: TextInputType.emailAddress,
                    validationType: ConstantValues.email,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isRequired: true,
                    isPassword: true,
                    inputType: TextInputType.visiblePassword,
                    validationType: ConstantValues.password,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return customButton(
                        context: context,
                        buttonText: 'Login',
                        onPressed: () {
                          ///-----Check form validations
                          ///-----the add login event to bloc
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginBloc>().add(LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  customButton(
                    context: context,
                    buttonText: 'Signup',
                    buttonType: ButtonType.outlined,
                    onPressed: () {
                      Routes.navigateAndRemoveAll(context, Routes.signup);
                    },
                  )
                  // Login Button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
