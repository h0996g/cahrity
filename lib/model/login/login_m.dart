class LoginResponse {
  final String? message;
  final String? token;
  final User? user;

  LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'user': user?.toJson()};
  }
}

class User {
  final String? id;
  final String? email;
  final String? phone;

  User({this.id, this.email, this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], email: json['email'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'phone': phone};
  }
}
