import 'package:charity/const/const.dart';
import 'package:charity/helper/cach.dart';
import 'package:charity/route.dart';
import 'package:charity/widget/no_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);

  final Connectivity _connectivity = Connectivity();
  bool _isDialogOpen = false;
  bool isUpdateExist = false;

  void startConnectivity() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      emit(NoConnection());
      if (!_isDialogOpen) {
        _isDialogOpen = true;
        showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentState!.context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: NoInternetWidget(),
              ),
            );
          },
        );
      }
    } else {
      emit(Connection());
      if (_isDialogOpen) {
        _isDialogOpen = false;
        Navigator.of(
          navigatorKey.currentState!.context,
        ).pop(); // Close the dialog
      }
    }
  }

  Locale locale = Locale(
    CachHelper.getData(key: langCache) != null
        ? CachHelper.getData(key: langCache).toString().toLowerCase()
        : 'en',
  );
  changeLanguage(Locale locale) {
    this.locale = locale;
    emit(MainChangeLanguage());
  }

  bool isDarkMode =
      CachHelper.getData(key: isDarkModeCache) != null
          ? CachHelper.getData(key: isDarkModeCache) as bool
          : false;
  void changeTheme() {
    isDarkMode = !isDarkMode;
    CachHelper.putcache(key: isDarkModeCache, value: isDarkMode).then((value) {
      emit(ChangeThemeStates());
    });
  }
}
