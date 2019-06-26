import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class Item {
  String title;
  bool done;

  Item(this.title, this.done);
}

class Todo {
  static List<Item> items = [];
}

class HomePage extends StatefulWidget {
  HomePage() {
    Todo.items.add(Item("Item 1", false));
    Todo.items.add(Item("Item 2", true));
    Todo.items.add(Item("Item 3", false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newTaskCtrl = TextEditingController();

  void add() {
    setState(() {
      Todo.items.add(Item(newTaskCtrl.text, false));
      newTaskCtrl.text = "";
    });
  }

  void remove(index) {
    setState(() {
      Todo.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          controller: newTaskCtrl,
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "*";
            }
          },
        ),
      ),
      body: ListView.builder(
        itemCount: Todo.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = Todo.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title ?? ""),
              onChanged: (bool value) {
                setState(() {
                  item.done = value;
                });
              },
              value: item.done,
            ),
            key: Key(item.title),
            onDismissed: (direction) {
              remove(index);
            },
            background: Container(
              color: Theme.of(context).primaryColorLight,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
