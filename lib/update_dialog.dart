import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateDialog extends StatefulWidget {
  final String text;
  const UpdateDialog(this.text, {super.key});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  var nameController = TextEditingController();
  void initState() {
    super.initState();
    nameController.text = widget.text;
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
                  Navigator.of(context).pop(nameController.text);
                }
              },
              child: Text("ADD")),
        ],
      ),
    );
  }
}
