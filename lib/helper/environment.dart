import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.devlopment';
    }
  }

  static String get baseUrl {
    return dotenv.env['VPSHTTPS'] ?? 'URL_NOT_FOUND';
  }

  static String get baseUrlSocket {
    return dotenv.env['VPSHTTPSSOCKET'] ?? 'URL_NOT_FOUND';
  }
}
