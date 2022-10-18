class SignUpData {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignUpData({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phone,
        'password': password,
      };

  static SignUpData fromJson(Map<String, dynamic> json) => SignUpData(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phone: json['phoneNumber'],
      );
}