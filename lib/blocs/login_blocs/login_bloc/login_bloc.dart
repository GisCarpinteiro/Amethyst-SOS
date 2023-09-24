import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial$()) {
    on<GetUserAndPassword>((event, emit) {
      String email = event.email;
      String password = event.password;
      print("El correo es ${email}, y la contraseña es ${password}");
      emit(const LoginGetAccount$(email: "ejemlo@gmail.com", password: "ContraseñaSuperSegura"));
    });
  }
}
