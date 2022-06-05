import 'dart:async';

import 'package:todo_list/database/database.dart';
import 'package:todo_list/models/todo.dart';

class TodoDao {

  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    return db.insert(TODO_TABLE, todo.toMap());
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Todo>> getTodos({String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = List.empty();

    if (query != null && query.isNotEmpty) {
      result = await db.query(TODO_TABLE,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]);
    } else {
      result = await db.query(TODO_TABLE);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromMap(item)).toList()
        : [];

    return todos;
  }

  //Update Todo record
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    return await db.update(TODO_TABLE, todo.toMap(),
        where: "id = ?", whereArgs: [todo.id]);
  }

  //Delete Todo records
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    return await db.delete(TODO_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  //We are not going to use this in the demo
  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    return await db.delete(TODO_TABLE,);
  }

}