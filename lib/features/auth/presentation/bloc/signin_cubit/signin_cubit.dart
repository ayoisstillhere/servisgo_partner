import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/set_service_class_usecase.dart';
import '../../../domain/usecases/signout_usecase.dart';

import '../../../domain/usecases/create_current_user_usecase.dart';
import '../../../domain/usecases/google_signin_usecase.dart';
import '../../../domain/usecases/google_signup_usecase.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import '../../../domain/usecases/set_phone_usecase.dart';
import '../../../domain/usecases/signin_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SignupUsecase signupUsecase;
  final SigninUsecase signinUsecase;
  final CreateCurrentUserUsecase createCurrentUserUsecase;
  final SignoutUsecase signoutUsecase;
  final GoogleSigninUsecase googleSigninUsecase;
  final GoogleSignupUsecase googleSignupUsecase;
  final SetPhoneUsecase setPhoneUsecase;
  final SetServiceClassUsecase setServiceClassUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  SigninCubit({
    required this.signupUsecase,
    required this.signinUsecase,
    required this.createCurrentUserUsecase,
    required this.signoutUsecase,
    required this.googleSigninUsecase,
    required this.googleSignupUsecase,
    required this.setPhoneUsecase,
    required this.setServiceClassUsecase,
    required this.resetPasswordUsecase,
  }) : super(SigninInitial());

  Future<void> submitSignin({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    try {
      await signinUsecase.call(email, password);
      emit(SigninSuccess());
    } on SocketException catch (e) {
      emit(SigninFailure(e.message));
    } catch (_) {
      emit(const SigninFailure("Firebase Exception"));
    }
  }

  Future<void> submitRegisteration({
    required String partnerEmail,
    required String password,
    required String partnerName,
    required String partnerPhone,
    required String status,
    required String serviceClass,
    required String partnerPfpURL,
  }) async {
    emit(SigninLoading());
    try {
      await signupUsecase.call(partnerEmail, password);
      await createCurrentUserUsecase.call(
        partnerName,
        partnerEmail,
        partnerPhone,
        status,
        serviceClass,
        partnerPfpURL,
      );
      emit(SigninSuccess());
    } on SocketException catch (e) {
      emit(SigninFailure(e.message));
    } catch (_) {
      emit(const SigninFailure("Firebase Exception"));
    }
  }

  Future<void> submitSignOut() async {
    try {
      await signoutUsecase.call();
    } on SocketException catch (_) {}
  }

  Future<void> googleSignIn() async {
    try {
      await googleSigninUsecase.call();
      emit(SigninSuccess());
    } on SocketException catch (e) {
      emit(SigninFailure(e.message));
    } catch (_) {
      emit(const SigninFailure("Firebase Exception"));
    }
  }

  Future<void> googleSignUp() async {
    try {
      await googleSignupUsecase.call();
      emit(SigninSuccess());
    } on SocketException catch (e) {
      emit(SigninFailure(e.message));
    } catch (_) {
      emit(const SigninFailure("Firebase Exception"));
    }
  }

  Future<void> submitPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      await setPhoneUsecase.call(
        phoneNumber,
      );
    } on SocketException catch (_) {}
  }

  Future<void> submitServiceClass({
    required String serviceClass,
  }) async {
    try {
      await setServiceClassUsecase.call(
        serviceClass,
      );
    } on SocketException catch (_) {}
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await resetPasswordUsecase.call(
        email,
      );
    } on SocketException catch (_) {}
  }
}
