import 'package:crud_29/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateDialog extends StatefulWidget {
  final TodoModel todoModel;
  const UpdateDialog(this.todoModel, {super.key});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  var nameController = TextEditingController();
  void initState() {
    super.initState();
    nameController.text = widget.todoModel.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              )),
          OutlinedButton(
              onPressed: () {
                if (nameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter name");
                } else {
                  widget.todoModel.title = nameController.text;
                  Navigator.of(context).pop(widget.todoModel);
                }
              },
              child: Text("ADD")),
        ],
      ),
    );
  }
}
