import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/ui/components/list/todo_list_item.dart';
import 'package:todo_list/ui/components/list/todo_list_loading.dart';
import '../../../bloc/bloc.dart';
import 'todo_list_empty.dart';

class TodoList extends StatelessWidget {
  const TodoList( // Constructor
    this.todoBloc,
    this.snapshot, {
    Key? key,
  }) : super(key: key);

  final AsyncSnapshot<List<Todo>> snapshot;
  final TodoBloc todoBloc;



  @override
  Widget build(BuildContext context) {
    return getTodoCardWidget(context, snapshot);
  }

  Widget getTodoCardWidget(BuildContext context,AsyncSnapshot<List<Todo>> snapshot) {
    /*
      Since most of our operations are asynchronous
      at initial state of the operation there will be no stream
      so we need to handle it if this was the case
      by showing users a processing/loading indicator
    */
    if (snapshot.hasData) {
      /*
        Also handles whenever there's stream
        but returned returned 0 records of Todo from DB.
        If that the case show user that you have empty Todos
      */
      return snapshot.data != null && snapshot.data!.isNotEmpty
          ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, itemPosition) {
                Todo todo = snapshot.data![itemPosition];
                return listItem(context,todoBloc,todo);
              },
            )
          : Center(
              // this is used whenever there 0 Todo
              // in the data base
              child: noTodoMessageWidget(context),
            );
    } else {
      return Center(
        /*
          since most of our I/O operations are done
          outside the main thread asynchronously
          we may want to display a loading indicator
          to let the use know the app is currently
          processing
        */
        child: loadingData(context,todoBloc),
      );
    }
  }
}
