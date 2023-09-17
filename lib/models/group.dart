// Model for Group Properties
import 'package:vistas_amatista/models/contact.dart';

class Group {
  final int id;
  final String name;
  List<dynamic> contacts;

  Group({
    required this.id,
    required this.name,
    required this.contacts,
  });

  Map toJson() => {'id': id, 'name': name, 'contatcs': contacts};

  factory Group.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final List<dynamic> contacts = data['contacts'];
    return Group(id: id, name: name, contacts: contacts);
  }
}
