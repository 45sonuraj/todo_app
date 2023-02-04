import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class todolist extends StatelessWidget {
  final String todoname;
  final bool iscompleated;
  Function(bool?)? onChanged;
  Function(BuildContext)? delete;
  todolist({super.key,required this.todoname,required this.iscompleated,required this.onChanged,required this.delete});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:25,top: 25,right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion:StretchMotion(),
          children: [
            SlidableAction(onPressed: delete,backgroundColor: Colors.red,icon: Icons.delete,
            borderRadius: BorderRadius.circular(25),),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Checkbox(value: iscompleated, onChanged: onChanged,activeColor: Colors.black,),
              Text(todoname,style: TextStyle(decoration: iscompleated ? TextDecoration.lineThrough: TextDecoration.none),overflow: TextOverflow.ellipsis,),
            ],
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
          color: Colors.orange),
        ),
      ),

    );
  }
}
