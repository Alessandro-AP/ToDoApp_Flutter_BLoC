import 'package:flutter/material.dart';
import 'package:todo_list/ui/home_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toto List',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Colors.transparent
      ),
      // our single page
      home: HomePage(),
    );
  }

}