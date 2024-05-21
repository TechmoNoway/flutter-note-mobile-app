import 'package:flutter/material.dart';
import 'package:note_flutter/extentions/buildcontext/loc.dart';
import 'package:note_flutter/utils/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.sharing,
    content: 'You can not share an empty note!',
    optionsBuilder: () => {context.loc.ok: null},
  );
}
