part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final String? email;
  final String password;

  const LoginState({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

final class LoginInitial$ extends LoginState {
  const LoginInitial$({super.email = "", super.password = ""});
}

final class LoginGetAccount$ extends LoginState {
  const LoginGetAccount$({required super.email, required super.password});
}
