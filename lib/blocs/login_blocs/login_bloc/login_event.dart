part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GetUserAndPassword extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;
  const GetUserAndPassword({required this.email, required this.password, required this.context});

}
