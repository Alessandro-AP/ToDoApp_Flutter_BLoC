import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

Widget noTodoMessageWidget(BuildContext context) {
  final delegate = S.of(context);

  return Builder(builder: (context) {
    return Text(
      delegate.todo_list_empty,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    );
  });
}