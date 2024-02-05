import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
            title: Strings.log,
            message: Strings.surelyLogginOut,
            buttons: const {
              Strings.cancel: false,
              Strings.logOut: true,
            });
}
