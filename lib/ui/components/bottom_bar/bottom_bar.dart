import 'package:flutter/material.dart';
import 'package:todo_list/bloc/bloc.dart';

BottomAppBar bottomAppBar(BuildContext context, TodoBloc todoBloc) {
  return BottomAppBar(
    color: Colors.white,
    child: Container(
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.indigoAccent,
                size: 28,
              ),
              onPressed: () {
                // just re-pull UI for testing purposes
                todoBloc.refreshTodos();
              }),
          const Expanded(
            child: Text("TODO",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'RobotoMono',
                  fontStyle: FontStyle.normal,
                  fontSize: 19),
            ),
          ),
          Wrap(children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 28,
                color: Colors.indigoAccent,
              ),
              onPressed: () {
                _showTodoSearchSheet(context, todoBloc);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(right: 5),
            )
          ])
        ],
      ),
    ),
  );
}


void _showTodoSearchSheet(BuildContext context, TodoBloc todoBloc) {
  final todoSearchDescriptionFormController = TextEditingController();
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
                padding: const EdgeInsets.only(
                    left: 15, top: 0, right: 15, bottom: 0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: todoSearchDescriptionFormController,
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Recherche",
                              labelText: "Veuillez saisir un texte à rechercher",
                              labelStyle: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Veuillez entrer un critère de recherche";
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
                                Icons.search,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                /*
                                    This will get all todos
                                    that contains similar string
                                    in the textform
                                  */
                                todoBloc.refreshTodos(
                                    query:
                                    todoSearchDescriptionFormController
                                        .value.text);
                                // dismisses the bottomsheet
                                Navigator.pop(context);
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
