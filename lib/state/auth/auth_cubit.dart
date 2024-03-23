import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pechkin_flutter/api.dart';
import 'package:pechkin_flutter/models/index.dart';
import 'package:pechkin_flutter/shared/cache.dart';
import 'package:pechkin_flutter/shared/loadState.dart';

class AuthState {
  final User user;
  final String loadState;
  final String error;

  AuthState({required this.user, required this.loadState, required this.error});

  // empty
  factory AuthState.empty() {
    return AuthState(user: User.empty(), loadState: LoadState.none, error: '');
  }

  //copyWith
  AuthState copyWith({User? user, String? loadState, String? error}) {
    return AuthState(user: user ?? this.user, loadState: loadState ?? this.loadState, error: error ?? this.error);
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {'user': user.toMap(), 'loadState': loadState, 'error': error};
  }

  //fromMap
  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(user: User.fromMap(map['user']), loadState: map['loadState'], error: map['error']);
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.empty());

  auth(String login, String password) async {
    emit(AuthState(user: User.empty(), loadState: LoadState.loading, error: ''));

    try {
      final resToken = await Api.auth(login, password);

      Api.setHeader(resToken.data!['token']);
      Cache.setToken(resToken.data!['token']);
      final resUser = await Api.getMe();
      if (resUser.error != null) {
        emit(AuthState(user: User.empty(), loadState: LoadState.error, error: resUser.error!));
      } else {
        emit(AuthState(user: resUser.data!, loadState: LoadState.success, error: ''));
      }
    } catch (e) {
      if (e is DioException) {
        emit(AuthState(user: User.empty(), loadState: LoadState.error, error: (e).response!.data['ERROR']['message']));
      } else {
        emit(AuthState(user: User.empty(), loadState: LoadState.error, error: e.toString()));
      }
    }
  }

  load() async {
    emit(AuthState(user: User.empty(), loadState: LoadState.loading, error: ''));

    final resUser =  await Api.getMe();
    if (resUser.error != null) {
      emit(AuthState(user: User.empty(), loadState: LoadState.error, error: resUser.error!));
    } else {
      emit(AuthState(user: resUser.data!, loadState: LoadState.success, error: ''));
    }
  }

  logout() {
    Api.setHeader('');
    Cache.clear();
    emit(AuthState(user: User.empty(), loadState: LoadState.none, error: ''));
  }
}

final authCubit = AuthCubit();
