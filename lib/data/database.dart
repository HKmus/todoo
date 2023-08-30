import 'package:hive_flutter/hive_flutter.dart';

class TodoDB {
  List tasks = [];

  //reference the hive box
  final Box _myBox = Hive.box('TBox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    tasks = [];
  }

  // load the data from database
  void loadData() {
    tasks = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", tasks);
  }
}
