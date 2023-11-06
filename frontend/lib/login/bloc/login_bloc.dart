import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:proj/main.dart';
import 'package:proj/data.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());

        final response = await http.post(
          Uri(scheme: 'https', host: host, path: '/auth/member/sign_in'),
          body: {
            'email': event.account,
            'password': event.password,
          },
        );

        final data = jsonDecode(response.body);
        final Map<String, dynamic> headers = response.headers;

        if (response.statusCode == 200) {
          final bearerToken = headers['authorization'];
          final userID = data['data']['id'];
          final Token token = Token(authorization: bearerToken, userID: userID);
          await DatabaseHelper.instance.setToken(token);
          await DatabaseHelper.instance.clearCache();

          emit(LoginSuccess());
        } else if (data['data'].toString().startsWith("A")) {
          emit(LoginConfirmFail());
        } else {
          emit(LoginFailure(error: data['message']));
        }
      }

      if (event is LoginTextFieldChanged) {
        if (state is LoginFailure) {
          emit(LoginInitial());
        }
      }
    });
  }
}
