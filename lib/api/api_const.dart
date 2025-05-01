import 'package:charity/helper/environment.dart';

class ApiConst {
  static String baseUrl = Enviroment.baseUrl;
  // Auth
  static const String login = "/api/users/login";
  static const String families = "/api/families"; //?page=1&limit=10
}
