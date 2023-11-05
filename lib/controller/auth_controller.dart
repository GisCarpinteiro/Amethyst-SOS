import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vistas_amatista/models/user.dart';

class AuthController {
  static Future createAccount({required User user}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc();

    final json = user.toJson();

    await docUser.set(json);
  }
}
