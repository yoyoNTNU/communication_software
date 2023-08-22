part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String account;
  final String password;

  const LoginButtonPressed({
    required this.account,
    required this.password,
  });

  @override
  List<Object> get props => [account, password];
}

class LoginTextFieldChanged extends LoginEvent {
  @override
  List<Object> get props => [];
}
