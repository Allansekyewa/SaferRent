import 'package:flutter/foundation.dart' show immutable;

import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
            // ignore: unnecessary_string_interpolations
            title: "$titleOfObjectToDelete",
            // ignore: unnecessary_string_interpolations
            message: "${Strings.surelyDeleting}",
            buttons: const {
              Strings.cancel: false,
              Strings.delete: true,
            });
}
