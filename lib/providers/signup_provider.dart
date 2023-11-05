import 'package:flutter/foundation.dart';
import 'package:vistas_amatista/controller/auth_controller.dart';
import 'package:vistas_amatista/models/user.dart';

class SignUpProvider with ChangeNotifier {
  String name = "";
  String email = "";
  String gender = "";
  String country = "";
  String password = "";
  String phone = "";
  int birthyear = 0;

  // This method is used to reset the values of this provider. PASSWORD NEEDS TO BE ERRASED AS SON AS POSSIBLE
  void cleanProvider() {
    name = "";
    email = "";
    gender = "";
    country = "";
    password = "";
    phone = "";
    birthyear = 0;
  }

  void valuesFromFirstForm({required String name, required String email, required String password}) {
    this.name = name;
    this.email = email;
    this.password = password;
  }

  void valuesFromSecondForm({required String country, required String phone, required int birthyear}) {
    this.country = country;
    this.phone = phone;
    this.birthyear = birthyear;
  }

  createAccount() {
    AuthController.createAccount(
        user: User(
            name: name,
            email: email,
            phone: phone,
            country: country,
            birthyear: birthyear,
            gender: "not_implemented_yet"));
  }
}
