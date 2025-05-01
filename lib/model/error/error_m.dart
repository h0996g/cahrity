class ErrorResponse {
  final String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
