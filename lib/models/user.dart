class User {
  // We don't add the password ass a property on the model for security reasons
  final String id;
  final String name;
  final String email;
  final String gender;
  final String country;
  final String phone;
  final int? birthyear;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.country,
      required this.phone,
      this.birthyear});

  Map toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'gender': gender,
        'country': country,
        'phone': phone,
        'birthyear': birthyear,
      };

  factory User.fromJson(Map<String, dynamic> data) {
    final String id = data['id'];
    final String name = data['name'];
    final String email = data['email'];
    final String gender = data['gender'];
    final String country = data['country'];
    final String phone = data['phone'];
    final int birthyear = data['birthyear'];
    return User(id: id, name: name, email: email, gender: gender, country: country, phone: phone, birthyear: birthyear);
  }
}
