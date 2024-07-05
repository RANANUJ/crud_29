import 'package:crud_29/add_dialog.dart';
import 'package:crud_29/database_provider.dart';
import 'package:crud_29/todo_model.dart';
import 'package:crud_29/update_dialog.dart';
import 'package:flutter/material.dart';

class ListViewCrud extends StatefulWidget {
  const ListViewCrud({super.key});

  @override
  State<ListViewCrud> createState() => _ListViewCrudState();
}

class _ListViewCrudState extends State<ListViewCrud> {
  // var list = <String>["Black", "Red", "Green"];
  DatabaseProvider databaseProvider = DatabaseProvider();
  var todoList = <TodoModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlist();
  }

  getlist() async {
    print("in list 26");
    todoList.addAll(await databaseProvider.getList());
    print("list ${todoList.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 206, 107),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 77, 23, 87)),
        title: const Text('List CRUD'),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(child: Text(todoList[index].title ?? "")),
                GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () {
                    showDialog(
                            context: context,
                            builder: (context) => UpdateDialog(todoList[index]))
                        .then((value) {
                      todoList[index] = value;
                      databaseProvider.updateTodo(
                          value, todoList[index].id ?? 0);
                      setState(() {});
                    });
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    todoList.removeAt(index);
                    setState(() {});
                  },
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddDialog())
              .then((value) {
            TodoModel todoModel =
                TodoModel(title: value, description: "This is testing");
            databaseProvider.insertTodo(todoModel);
            todoList.add(value);
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
