import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {

}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
}

final authCubit = AuthCubit();
