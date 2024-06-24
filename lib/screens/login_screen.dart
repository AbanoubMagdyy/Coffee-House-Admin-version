import 'package:coffee_house_admin_version/shared/login_bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../layout/layout_screen.dart';
import '../shared/login_bloc/states.dart';
import '../shared/shared_preferences.dart';
import '../style/colors.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          /// login
          if (state is SuccessLogin) {
            email = emailController.text;
            Shared.saveDate(key: 'Email', value: emailController.text)?.then((value) =>  navigateAndFinish(context, const LayoutScreen()));
          } else if (state is ErrorLogin) {
            defMaterialBanner(context,
                'Something went wrong. Please re-type the data correctly and try again');
          }

          /// forgot password
          if (state is SuccessForgotPassword) {
            defMaterialBanner(
                context, 'The code has been sent, Check your email');
          } else if (state is ErrorForgotPassword) {
            defMaterialBanner(context, 'Something went wrong. Please try again');
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: secColor,

            /// background
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/loginBackground.jfif'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      /// app name and bio
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                          child: Column(
                            children: [
                              Text(
                                appName.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 3,
                                  color: secColor,
                                ),
                              ),
                              defText(
                                  text:
                                      'A way to enjoy bitter and sweet of life',
                                  fontSize: 18)
                            ],
                          ),
                        ),
                      ),

                      /// body
                      Container(
                          margin: const EdgeInsetsDirectional.all(30),
                          padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20,
                            horizontal: 50,
                          ),
                          height: screenHeight / 1.5,
                          width: 500,
                          decoration: BoxDecoration(
                            color: defColor,
                            border: Border.all(color: secColor),
                            borderRadius: BorderRadiusDirectional.circular(35),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (state is LoadingForgotPassword ||
                                    state is LoadingLogin)
                                  defLinearProgressIndicator(),

                                /// email
                                defTextFormField(
                                  text: 'Email',
                                  controller: emailController,
                                  keyboard: TextInputType.emailAddress,
                                ),

                                /// password
                                defTextFormField(
                                    text: 'Password',
                                    controller: passwordController,
                                    forPassword: true,
                                    icon: cubit.hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    isPassword: cubit.hidePassword,
                                    onPressed: () =>
                                        cubit.changePasswordVisibility()),

                                /// Forgot password?
                                TextButton(
                                  onPressed: () {
                                    if (emailController.text.isNotEmpty) {
                                      cubit.forgotPasswordMethod(
                                          email: emailController.text);
                                    } else {
                                      defMaterialBanner(
                                          context, 'Please enter your email');
                                    }
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                  ),
                                ),

                                /// login or sign up button
                                defButton(
                                    onTap: () {
                                      if (isFormValidForLogin(context)) {
                                        cubit.loginMethod(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: defText(
                                        text: 'Login', textColor: defColor)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isFormValidForLogin(context) {
    if (!areAllFieldsFilledForLogin()) {
      showErrorMessage('Please enter all required information.', context);
      return false;
    }

    if (!isEmailValidForLogin()) {
      showErrorMessage('Please enter a valid email address.', context);
      return false;
    }
    return true;
  }

  bool areAllFieldsFilledForLogin() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool isEmailValidForLogin() {
    return emailRegExp.hasMatch(emailController.text);
  }

  void showErrorMessage(String message, context) {
    defMaterialBanner(context, message);
  }
}
