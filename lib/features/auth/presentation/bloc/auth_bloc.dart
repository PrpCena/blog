import 'dart:async';

import 'package:clean/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/core/common/entities/my_user.dart';
import 'package:clean/features/auth/domain/usecase/current_user.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_in.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_out.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserSignOut _userSignOut;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserSignIn userSignIn,
      required UserSignOut userSignOut,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userSignOut = userSignOut,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthIsUserSignedIn>(_onAuthIsUserSignedIn);
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.error)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.error)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthIsUserSignedIn(
    AuthIsUserSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.error)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    MyUser user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  FutureOr<void> _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignOut(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.error)),
      (r) => emit(AuthInitial()),
    );
  }
}
