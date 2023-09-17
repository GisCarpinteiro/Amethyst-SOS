// Model for contacts that belong to a group.
class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});

  Map toJson() => {'name': name, 'phone': phone};

  factory Contact.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String phone = data['phone'];
    return Contact(name: name, phone: phone);
  }
}
