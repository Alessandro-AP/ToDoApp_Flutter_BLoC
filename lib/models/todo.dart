class Todo {
  int? id;
  String description;
  bool isDone;

  Todo({this.id, this.description = "", this.isDone = false});

  factory Todo.fromMap(Map<String, dynamic> data) => Todo(
    //This will be used to convert Maps objects that
    //are coming from querying the database into Todo objects
    id: data['id'],
    description: data['description'],
    isDone: data['is_done'] == 0 ? false : true, // int <-> boolean
  );

  Map<String, dynamic> toMap() => {
    //This will be used to convert a Todo object into a Map
    "id": id,
    "description": description,
    "is_done": isDone == false ? 0 : 1, // boolean <-> int
  };

}