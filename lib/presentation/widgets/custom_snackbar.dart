import 'package:bubble/main.dart';
import 'package:bubble/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bubble/presentation/widgets/rounded_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/themes.dart';

enum SnackBarType {
  success,
  error,
}

void showCustomSnackBar(
    {required String message, SnackBarType type = SnackBarType.success}) {
  snackbarKey.currentState!.showSnackBar(SnackBar(
      padding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.themeLight,
                width: 1,
              ),
              color: state.isDarkMode ? AppColors.lightBlack : AppColors.white,
            ),
            child: Row(
              children: [
                RoundedContainerWidget(
                  borderRadius: BorderRadius.circular(5),
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: type == SnackBarType.error
                        ? AppColors.error
                        : AppColors.green,
                  ),
                ),
                WhiteSpace.gapW15,
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                ),
              ],
            ),
          );
        },
      )));
}
