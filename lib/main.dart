import 'package:bubble/config/themes/palette.dart';
import 'package:bubble/core/injections/injection_setup.dart';
import 'package:bubble/domain/app_db/app_db_repository.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeAppDependancies();
  runApp(const MyApp());
}

Future<void> initializeAppDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await getIt<AppDbRepository>().initializeDB();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 900),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Palette.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Palette.white,
              ),
              fontFamily: "WorkSans",
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.SPLASH_SCREEN,
            onGenerateRoute: AppRouter.onGeneratedRoute,
          );
        });
  }
}
