import 'package:flutter/material.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/ui_kit/snackbar/main_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FailureHandlers {
  static void bottomErrorSnackBar(BuildContext context, Failure failure) => showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
        Overlay.of(context),
        MainSnackbar.error(
          context: context,
          title: failure.message,
        ),
      );
}
