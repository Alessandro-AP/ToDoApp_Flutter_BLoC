import 'package:flutter/material.dart';
import 'package:todo_list/bloc/bloc.dart';

import '../../../generated/l10n.dart';

Widget loadingData(BuildContext context,TodoBloc todoBloc) {
  final delegate = S.of(context);

  // pull todos again
  todoBloc.refreshTodos();

  return Builder(builder: (context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          const CircularProgressIndicator(),
          Text(delegate.todo_list_loading,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ],
      ),
    );
  });
}