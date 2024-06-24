import 'package:coffee_house_admin_version/shared/login_bloc/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  bool hidePassword = true;
  void changePasswordVisibility() {
    hidePassword = !hidePassword;
    emit(ChangeVisibility());
  }


  Future<void> loginMethod({
    required String email,
    required String password,
  }) async {
    emit(LoadingLogin());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        emit(SuccessLogin());
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(ErrorLogin());
      },
    );
  }

  Future<void> forgotPasswordMethod({
    required String email,
  }) async {
    emit(LoadingForgotPassword());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
      (value) {
        emit(SuccessForgotPassword());
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(ErrorForgotPassword());
      },
    );
  }

}
