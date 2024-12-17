import 'package:clean_arch/common/widgets/custom_textformfield.dart';
import 'package:clean_arch/network/client/api_client.dart';
import 'package:clean_arch/presenter/ui/signup/bloc/signup_bloc.dart';
import 'package:clean_arch/presenter/ui/signup/bloc/signup_event.dart';
import 'package:clean_arch/presenter/ui/signup/bloc/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/constants.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../routes.dart';

class SignupScreen extends StatelessWidget {
  // Form key to validate the form
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _emailController =
      TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(text: "pistol");
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocProvider(
        create: (context) => SignupBloc(apiService: ApiClient()),
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              Routes.navigateAndRemoveAll(context, Routes.dashboard);
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Signup successful! Token: ${state.token}'),
              // ));
            } else if (state is SignupFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Signup failed: ${state.errorMessage}'),
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: _fullNameController,
                    isRequired: true,
                    hintText: 'Full Name',
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  // Full Name Field

                  // Email Field
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
                  const SizedBox(height: 16.0),

                  // Confirm Password Field
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    isRequired: true,
                    isPassword: true,
                    inputType: TextInputType.visiblePassword,
                    validation: (str) {
                      return str == _passwordController.text
                          ? null
                          : "Passwords do not match. Please try again.";
                    },
                  ),
                  const SizedBox(height: 24.0),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      if (state is SignupLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return customButton(
                        context: context,
                        buttonText: 'Signup',
                        onPressed: () {
                          ///-----Check form validations
                          ///-----the add login event to bloc
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<SignupBloc>().add(SignupSubmitted(
                                email: _emailController.text,
                                password: _passwordController.text,
                                fullName: _fullNameController.text,
                                confirmPassword:
                                    _confirmPasswordController.text));
                          }
                        },
                      );
                    },
                  ),
                  // Sign Up Button
                  const SizedBox(height: 24.0),
                  customButton(
                    context: context,
                    buttonText: 'Login',
                    buttonType: ButtonType.outlined,
                    onPressed: () {
                      Routes.navigateAndRemoveAll(context, Routes.login);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
