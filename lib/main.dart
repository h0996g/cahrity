import 'package:charity/api/dio.dart';
import 'package:charity/const/const.dart';
import 'package:charity/cubit/main_cubit.dart';
import 'package:charity/helper/cach.dart';
import 'package:charity/helper/environment.dart';
import 'package:charity/helper/observer.dart';
import 'package:charity/home/cubit/home_cubit.dart';
import 'package:charity/l10n/l10n.dart';
import 'package:charity/route.dart';
import 'package:charity/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await dotenv.load(fileName: Enviroment.fileName);
  // CachHelper.removdata(key: tokenCache);
  TOKEN = CachHelper.getData(key: tokenCache) ?? '';
  print('TOKEN: $TOKEN');
  VPSDio.init();

  lng = CachHelper.getData(key: langCache) ?? 'en';
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MainCubit()..startConnectivity()),
          BlocProvider(create: (context) => HomeCubit()..getFamilies()),
        ],
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              supportedLocales: L10n.all,

              locale: MainCubit.get(context).locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: 'Flutter Demo',
              theme: AppThemes.lightTheme,
              themeMode: ThemeMode.light,
              darkTheme: AppThemes.darkTheme,
            );
          },
        ),
      ),
    );
  }
}
