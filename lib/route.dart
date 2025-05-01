import 'package:charity/Screen/Login/cubit/login_cubit.dart';
import 'package:charity/Screen/Login/login.dart';
import 'package:charity/const/const.dart';
import 'package:charity/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteConstants {
  static const String initial = '/';
  // ----------------- Auth -----------------
  static const String signup = '/signup';
  static const String singupThirdParty = '/signup-third-party';
  static const String login = '/login';

  // -----------------Profile -----------------
  static const String resetPassword = '/reset-password';
  static const String changePassword = '/change-password';
  static const String updateProfile = '/profile/update';
  // -----------------Settings -----------------
  static const String settings = '/settings';
  static const String connectedDevices = '/connected-devices';
  // -----------------Home -----------------
  static const String home = '/home';

  // ----------------- currentOrder -----------------
  static const String currentOrder = '/current-order';

  // Profiles :
  static String getProfilePath() => updateProfile;
  static String getSignupPath() => signup;
  static String getSignupThirdPartyPath() => singupThirdParty;
  static String getLoginPath() => initial;
  static String getResetPasswordPath() => resetPassword;
  static String getChangePasswordPath() => changePassword;
  static String getHomePath() => home;
  static String getSettingsPath() => settings;
  static String getConnectedDevicesPath() => connectedDevices;
  static String getCurrentOrderPath() => currentOrder;
}

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: TOKEN.isEmpty ? RouteConstants.login : RouteConstants.home,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(create: (context) => RegisterCubit()),
              BlocProvider(create: (context) => LoginCubit()),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RouteConstants.login,
            builder: (context, state) => const LoginScreen(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return child;
        },
        routes: [
          GoRoute(
            path: RouteConstants.home,
            builder: (context, state) => const StartPage(),
          ),
        ],
      ),
    ],
  );
}
