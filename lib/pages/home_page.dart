import 'package:flutter/material.dart';
import 'package:to_do_list_app/util/dialog_box.dart';
import '../data/database.dart';
import '../util/task_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  final _textController = TextEditingController();
  //list of todo tasks

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
 void cancel(){
    setState(() {
     _textController.clear();
    });
    Navigator.of(context).pop();
 }
  @override
  void initState() {
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }
  //save new task
   void saveNewTask(){
    setState(() {
      db.toDoList.add([ _textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
   }
  void createNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogBox(
          controller: _textController,
        onCancel: cancel,
        onSave: saveNewTask,
      );
    },);
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title:Text("TO DO") ,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
          onPressed: createNewTask,
      child: Icon(Icons.add),),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
           return ToDoTile(
             taskName: db.toDoList[index][0],
             taskCompleted: db.toDoList[index][1],
             onChanged: (value) => checkBoxChanged(value,index),
             deleteFunction: (context) => deleteTask(index),
           );
          })
    );
  }
}