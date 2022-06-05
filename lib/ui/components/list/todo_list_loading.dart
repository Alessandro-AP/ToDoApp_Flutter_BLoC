import 'package:flutter/material.dart';
import 'package:todo_list/bloc/bloc.dart';

Widget loadingData(TodoBloc todoBloc) {
  // pull todos again
  todoBloc.refreshTodos();

  return Builder(builder: (context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text("Chargement en cours...",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ],
      ),
    );
  });
}