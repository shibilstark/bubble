import 'package:bubble/config/themes/custom_themes.dart';
import 'package:bubble/core/injections/injection_setup.dart';
import 'package:bubble/domain/app_db/app_db_repository.dart';
import 'package:bubble/presentation/bloc/auth/auth_bloc.dart';
import 'package:bubble/presentation/bloc/theme/theme_bloc.dart';
import 'package:bubble/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await initializeAppDependancies();
  runApp(const Bubble());
}

Future<void> initializeAppDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await configureInjection();
  await getIt<AppDbRepository>().initializeDB();
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class Bubble extends StatelessWidget {
  const Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 900),
          splitScreenMode: true,
          minTextAdapt: true,
          builder: (context, child) {
            context.read<ThemeBloc>().add(const LoadTheme());
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  scaffoldMessengerKey: snackbarKey,
                  theme:
                      state.isDarkMode ? CustomThemes.dark : CustomThemes.light,
                  debugShowCheckedModeBanner: false,
                  initialRoute: AppRouter.SPLASH_SCREEN,
                  onGenerateRoute: AppRouter.onGeneratedRoute,
                );
              },
            );
          }),
    );
  }
}
