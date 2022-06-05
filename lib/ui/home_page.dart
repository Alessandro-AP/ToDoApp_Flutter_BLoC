import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/models/todo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // We load our Todo BLoC that is used to get
  // the stream of Todo for StreamBuilder
  final TodoBloc todoBloc = TodoBloc();

  // Allows Todo card to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.startToEnd;

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
        bottomNavigationBar: BottomAppBar(
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
                      _showTodoSearchSheet(context);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ])
              ],
            ),
          ),
        ),
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

  void _showAddTodoSheet(BuildContext context) {
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
                              decoration: const InputDecoration(
                                  hintText: "Je dois faire...",
                                  labelText: "Veuillez introduire le descriptif de la tâche",
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Veuillez entrer un descriptif";
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

  void _showTodoSearchSheet(BuildContext context) {
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

  Widget getTodosWidget() {
    /*
      The StreamBuilder widget,
      basically this widget will take stream of data (todos)
      and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Todo>> snapshot) {
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
          ? ListView.builder (
              itemCount: snapshot.data!.length,
              itemBuilder: (context, itemPosition) {
                Todo todo = snapshot.data![itemPosition];
                final Widget dismissibleCard = Dismissible(
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
                    /*
                      we delete the todo
                    */
                    todoBloc.deleteTodoById(todo.id!);
                  },
                  direction: _dismissDirection,
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
                              ]
                          )
                        ),
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
                return dismissibleCard;
              },
            )
          : Center(
              // this is used whenever there 0 Todo
              // in the data base
              child: noTodoMessageWidget(),
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
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
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

  Widget noTodoMessageWidget() {
    return Builder(builder: (context) {
      return const Text("Aucune tâche",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      );
    });
  }

  dispose() {
    // close the stream in order to avoid memory leaks
    todoBloc.dispose();
  }
}
