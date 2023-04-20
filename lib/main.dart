import 'package:bubble/presentation/router/router.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
              fontFamily: "WorkSans",
            ),
            supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.AUTH_SCREEN,
            onGenerateRoute: AppRouter.onGeneratedRoute,
          );
        });
  }
}
