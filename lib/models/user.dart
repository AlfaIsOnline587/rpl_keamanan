class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.username,
    this.phone,
    this.website,
  });

  final int id;
  final String name;
  final String email;
  final String? username;
  final String? phone;
  final String? website;

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];

    if (id is! int || name is! String || email is! String) {
      throw const FormatException('Data pengguna tidak memiliki format valid.');
    }

    return User(
      id: id,
      name: name,
      email: email,
      username: _optionalString(json, 'username'),
      phone: _optionalString(json, 'phone'),
      website: _optionalString(json, 'website'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    if (username != null) 'username': username,
    if (phone != null) 'phone': phone,
    if (website != null) 'website': website,
  };

  static String? _optionalString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is String) return value;
    throw FormatException('Field "$key" harus berupa teks.');
  }
}
