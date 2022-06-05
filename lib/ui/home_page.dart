import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/models/todo.dart';

import '../generated/l10n.dart';
import 'components/bottom_bar/bottom_bar.dart';
import 'components/list/todo_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // We load our Todo BLoC that is used to get
  // the stream of Todo for StreamBuilder
  final TodoBloc todoBloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                    // we start loading
                    child: getTodosWidget()))),
        bottomNavigationBar: bottomAppBar(context, todoBloc),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddTodoSheet(context);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        ));
  }


  Widget getTodosWidget() {
    /*
      The StreamBuilder widget,
      basically this widget will take stream of data (todos)
      and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return TodoList(todoBloc,snapshot);
      },
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final delegate = S.of(context);
    final todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 0),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: delegate.addsheet_hint,
                                  labelText: delegate.addsheet_label,
                                  labelStyle: const TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return delegate.addsheet_validator;
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newTodo = Todo(description: todoDescriptionFormController.value.text);
                                  if (newTodo.description.isNotEmpty) {
                                    /*
                                      Create new Todo object and make sure
                                      the Todo description is not empty,
                                      because what's the point of saving empty
                                      Todo
                                    */
                                    todoBloc.addTodo(newTodo);

                                    // dismisses the bottomsheet
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  dispose() {
    // close the stream in order to avoid memory leaks
    todoBloc.dispose();
  }
}
