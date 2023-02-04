import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database.dart';
import 'package:todo/mybutton.dart';
import 'package:todo/todotile.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _StateMyHomePage();
}

class _StateMyHomePage extends State<MyHomePage> {
  bool hiscompleated = false;


  tododatabase db = tododatabase();
  final _mybox = Hive.box('todobox');


  @override
  void initState() {

    if (_mybox.get("TODOLIST") == null) {
      db.makefirst();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoBucket.removeAt(index);
    });
    db.updateData();
  }

  final TextEditingController controller = TextEditingController();

  void checkboxchanged(int index, bool? value) {
    setState(() {
      db.todoBucket[index][1] = !db.todoBucket[index][1];
    });
  }

  void onsaved() {
    setState(() {
      db.todoBucket.add([controller.text, false]);
      controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add a New Task"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    mybutton(
                      text: 'Save',
                      onpressed: onsaved,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    mybutton(
                      text: 'cancel',
                      onpressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            "Just Do It",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          leading: Icon(Icons.check),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.green,
          splashColor: Colors.pink,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todoBucket.length,
            itemBuilder: (context, index) {
              return todolist(
                todoname: db.todoBucket[index][0],
                iscompleated: db.todoBucket[index][1],
                onChanged: (value) => checkboxchanged(index, value),
                delete: (value) => deleteTask(index),
              );
            }));
  }
}
