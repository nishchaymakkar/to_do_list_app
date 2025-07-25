import 'package:flutter/material.dart';
import 'package:to_do_list_app/util/my_button.dart';


class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

 DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a new task"
              ),
            ),


            // buttons (save + cancel)

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "save",
                    onPressed: onSave
                ),
                const SizedBox(width: 8,),
                MyButton(text: "cancel",
                    onPressed: onCancel )
              ],
            )
          ],
        ),
      ),
    );//
  }
}