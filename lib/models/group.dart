// Model for Group Properties
class Group {
  final int? id; // EL id es nulo en el modelo por que quien lo define es la BD. Así podemos crear uno de forma local sin definir esa propiedad
  final String name;
  List<dynamic> contacts;

  Group({
    this.id,
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
