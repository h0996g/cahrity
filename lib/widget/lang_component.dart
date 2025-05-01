import 'package:charity/const/colors.dart';
import 'package:charity/const/const.dart';
import 'package:charity/cubit/main_cubit.dart';
import 'package:charity/helper/cach.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  final String initialSelectedValue;

  const LanguageSelector({super.key, required this.initialSelectedValue});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late String valueSelected;

  // Map language codes to their corresponding Locale objects
  final Map<String, Locale> languageMap = {
    'EN': const Locale('en'),
    'FR': const Locale('fr'),
    'AR': const Locale('ar'),
  };

  @override
  void initState() {
    super.initState();
    // Initialize the selected value with the initial selected value from the parent
    valueSelected = widget.initialSelectedValue;
  }

  PopupMenuItem<String> buildPopupMenuItem(
    String value,
    String text,
    String selectedValue,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            selectedValue == value ? Icons.check : null,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  _changeLanguage(BuildContext context, String newValue) {
    setState(() {
      valueSelected = newValue;
      CachHelper.putcache(key: langCache, value: newValue);
      lng = newValue;
      print(lng);
    });

    final selectedLocale = languageMap[newValue];
    if (selectedLocale != null) {
      MainCubit.get(context).changeLanguage(selectedLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      initialValue: valueSelected,
      onSelected: (String newValue) {
        _changeLanguage(context, newValue);
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<String>>[
            buildPopupMenuItem('EN', 'English', valueSelected),
            buildPopupMenuItem('FR', 'Français', valueSelected),
            buildPopupMenuItem('AR', 'العربية', valueSelected),
          ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, color: primaryColor),
          const SizedBox(width: 4),
          Text(
            valueSelected,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.keyboard_arrow_down_sharp, color: primaryColor),
        ],
      ),
    );
  }
}
