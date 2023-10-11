import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial$()) {
    on<GetUserAndPassword>((event, emit) {
      String email = event.email;
      String password = event.password;
      print("El correo es $email, y la contraseña es $password");
      signInWithEmailPassword(email, password);
      emit(const LoginGetAccount$(
          email: "ejemlo@gmail.com", password: "ContraseñaSuperSegura"));
    });
  }

  signInWithEmailPassword(email, psw) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          //email: "carpinteiro.gisel@gmail.com", password: "Amatista1234"
          email: email,
          password: psw);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
