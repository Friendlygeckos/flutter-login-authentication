import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login_authentication/repository/repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthRepository authRepository;
  final FacebookAuthRepository facebookAuthRepository;
  final TwitterAuthRepository twitterAuthRepository;
  final GitHubAuthRepository gitHubAuthRepository;

  AuthBloc(
      {required this.authRepository,
      required this.facebookAuthRepository,
      required this.gitHubAuthRepository,
      required this.twitterAuthRepository})
      : super(UnAuthenticated()) {
    on<SignInRequested>(_signInRequested);
    on<SignUpRequested>(_signUpRequested);
    on<GoogleSignInRequested>(_googleSignInRequested);
    on<FacebookSignInRequested>(_facebookSignInRequested);
    on<TwitterSignInRequested>(_twitterSignInRequested);
    on<GitHubSignInRequested>(_githubSignInRequested);
    on<SignOutRequested>(_signOutRequested);
  }

  Future<void> _signInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await authRepository.signIn(email: event.email, password: event.password);
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _signUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await authRepository.signUp(email: event.email, password: event.password);
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _googleSignInRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await authRepository.signInWithGoogle();
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _facebookSignInRequested(
      FacebookSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await facebookAuthRepository.signInWithFacebook();
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _twitterSignInRequested(
      TwitterSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await twitterAuthRepository.loginWithTwitter();
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _githubSignInRequested(
      GitHubSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      await gitHubAuthRepository.signInWithGitHub();
      emit(Authenticaed());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> _signOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    await authRepository.signOut();
    emit(UnAuthenticated());
  }
}
