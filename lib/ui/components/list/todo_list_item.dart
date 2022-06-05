import 'package:flutter/material.dart';
import '../../../bloc/bloc.dart';
import '../../../models/todo.dart';

Widget listItem(TodoBloc todoBloc,Todo todo) {
  return Dismissible(
    background: Container(
      color: Colors.redAccent,
      child: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Supprimer",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    onDismissed: (direction) {
      todoBloc.deleteTodoById(todo.id!); // we delete the todo
    },
    // Allows To.Do card to be dismissable horizontally
    direction: DismissDirection.startToEnd,
    key: ObjectKey(todo),
    child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.white,
        child: ListTile(
          leading: InkWell(
              onTap: () {
                // Reverse the value
                todo.isDone = !todo.isDone;
                // update the Todo in database
                todoBloc.updateTodo(todo);
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    todo.isDone
                        ? const Icon(
                      Icons.done,
                      size: 26.0,
                      color: Colors.green,
                    )
                        : const Icon(
                      Icons.check_box_outline_blank,
                      size: 26.0,
                      color: Colors.blueAccent,
                    ),
                  ])),
          title: Text(
            todo.description,
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'RobotoMono',
              fontWeight: todo.isDone ? FontWeight.w100 : FontWeight.w500,
            ),
          ),
        )),
  );
}