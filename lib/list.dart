import 'package:crud_29/add_dialog.dart';
import 'package:crud_29/update_dialog.dart';
import 'package:flutter/material.dart';

class ListViewCrud extends StatefulWidget {
  const ListViewCrud({super.key});

  @override
  State<ListViewCrud> createState() => _ListViewCrudState();
}

class _ListViewCrudState extends State<ListViewCrud> {
  var list = <String>["Black", "Red", "Green"];
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
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(child: Text(list[index])),
                GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () {
                    showDialog(
                            context: context,
                            builder: (context) => UpdateDialog(list[index]))
                        .then((value) {
                      list[index] = value;
                      setState(() {});
                    });
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    list.removeAt(index);
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
            list.add(value);
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
