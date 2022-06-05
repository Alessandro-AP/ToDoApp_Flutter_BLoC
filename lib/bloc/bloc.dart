import 'dart:async';

import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repository/repository.dart';

class TodoBloc {
  //Get instance of the Repository
  final _todoRepository = TodoRepository();

  /*
    Stream controller is the 'Admin' that manages
    the state of our stream of data like adding
    new data, change the state of the stream
    and broadcast it to observers/subscribers
   */
  final _todoController = StreamController<List<Todo>>();

  get todos => _todoController.stream;

  TodoBloc() {
    refreshTodos();
  }

  refreshTodos({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    refreshTodos();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    refreshTodos();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    refreshTodos();
  }

  dispose() {
    _todoController.close();
  }

}