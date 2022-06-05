import 'package:flutter/cupertino.dart';

Widget noTodoMessageWidget() {
  return Builder(builder: (context) {
    return const Text(
      "Aucune tâche",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    );
  });
}