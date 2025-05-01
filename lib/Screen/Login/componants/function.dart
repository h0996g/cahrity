import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhone(String? phone, BuildContext context) async {
  if (phone == null || phone.trim().isEmpty) return;

  final Uri uri = Uri(scheme: 'tel', path: phone.trim());

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cannot launch dialer on this device.")),
    );
  }
}
