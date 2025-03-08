import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../../models/user.dart';
import '../auth_provider.dart';
import 'dart:developer' as devtools show log;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = await provider.currentUser;
      devtools.log(user.toString());
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else {
        emit(AuthStateLoggedIn(user: user));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut());
      // await Future.delayed(const Duration(seconds: 3));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedIn(user: user));
      } on Exception {
        emit(const AuthStateLoggedOut());
      }
    });

    // register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      final userName = event.userName;
      devtools.log('O1');
      try {
        await provider.createUser(
          userName: userName,
          email: email,
          password: password,
        );
        devtools.log(provider.currentUser.toString());
        await provider.logOut();
        emit(const AuthStateRegistering());
      } on Exception catch (e) {
        devtools.log(e.toString());
        emit(const AuthStateLoggedOut());
      }
    });

    on<AuthEventShouldRegister>((event, emit) async {
      emit(const AuthStateRegistering());
    });
  }
}
