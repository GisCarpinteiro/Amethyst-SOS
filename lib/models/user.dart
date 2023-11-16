class User {
  // We don't add the password ass a property on the model for security reasons
  final String name;
  final String email;
  final String gender;
  final String country;
  final String phone;
  final int? birthyear;
  final List? alerts;
  final List? groups;
  final List? routines;

  User(
      {
      required this.name,
      this.alerts = const [], this.groups = const [], this.routines = const [], 
      required this.email,
      required this.gender,
      required this.country,
      required this.phone,
      this.birthyear});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'gender': gender,
        'country': country,
        'phone': phone,
        'birthyear': birthyear,
      };

  factory User.fromJson(Map<String, dynamic> data) {
    final String name = data['name'];
    final String email = data['email'];
    final String gender = data['gender'];
    final String country = data['country'];
    final String phone = data['phone'];
    final int birthyear = data['birthyear'];
    return User(name: name, email: email, gender: gender, country: country, phone: phone, birthyear: birthyear);
  }
}
