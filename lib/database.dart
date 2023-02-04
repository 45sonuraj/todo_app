
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class tododatabase {

var box=Hive.box('todobox');
  List todoBucket=[ ];

  final _mybox=Hive.box('todobox');

  void makefirst() {
    todoBucket=[
      ["Welcome",false],
      ["Just Do it",false]
  ];
}


void loadData(){
    todoBucket=_mybox.get("TODOLIST");
}

void updateData(){
    _mybox.put("TODOLIST", todoBucket);
}
}