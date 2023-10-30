import 'package:flutter/foundation.dart';

class SignUpProvider with ChangeNotifier{
  String name = "";
  String email = ""; 
  String gender = "";
  String country = "";
  String password = "";
  String phone = "";
  int birthyear = 0;

  // This method is used to reset the values of this provider. PASSWORD NEEDS TO BE ERRASED AS SON AS POSSIBLE
  void cleanProvider(){
    name = "";
    email = ""; 
    gender = "";
    country = "";
    password = "";
    phone = "";
    birthyear = 0;
  }

  void valuesFromFirstForm({required String name, required String email, required String password}){
    this.name = name;
    this.email = email;
    this.password = password;
  }

  void valuesFromSecondForm({required String country, required String phone, required int birthyear}){
    this.country = country;
    this.phone = phone;
    this.birthyear = birthyear;
  }

  void createAccount(){
    // * Create an account by creating a profile on Fire Auth and also a user doc on FireStore
    // TODO: Firestore new document entry for user collection.
  }

}