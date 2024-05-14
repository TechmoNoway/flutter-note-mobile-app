import 'package:flutter/material.dart';
import 'package:note_flutter/utils/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You can not share an empty note!',
    optionsBuilder: () => {'Ok': null},
  );
}
