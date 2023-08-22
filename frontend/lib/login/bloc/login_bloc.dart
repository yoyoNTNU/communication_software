import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:express_message/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());

        final response = await http.post(
          Uri(host: host, path: '/api/login'),
          body: {
            'account': event.account,
            'password': event.password,
          },
        );
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: data['message']));
        }
      }

      if (event is LoginTextFieldChanged) {
        emit(LoginInitial());
      }
    });
  }
}
