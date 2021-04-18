import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_app/modules%20TO%20DO%20App/archieved.dart';
import 'package:flutter_app/modules%20TO%20DO%20App/done.dart';
import 'package:flutter_app/modules%20TO%20DO%20App/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class BottomCubit extends Cubit<BottomStates> {
  BottomCubit() : super(BottomInitState());

  int currentIndex = 0;

  bool isDark = false;
  void changeMode() {
    isDark = !isDark;
    emit(DarkModeChangeSuccessState());
  }

  List<Widget> screens = [
    Home(),
    Done(),
    Archieved(),
  ];

  static BottomCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomChangesCurrentIndexState());
  }
  //----------------------------------------

  Database database;
  List<Map> newTasks;
  List<Map> doneTasks;
  List<Map> archievedTasks;

  void openDb() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) async {
        print('data created');
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, state TEXT)');
      },
      onOpen: (Database db) {
        getDb(db);
        print('data opened');
      },
    ).then((value) {
      database = value;
      emit(BottomCreateDataSuccessState());
    }).catchError((error) {
      emit(BottomCreateDataErrorState());
    });
  }

  void getDb(Database db) {
    newTasks = [];
    doneTasks = [];
    archievedTasks = [];
    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['state'] == 'new') newTasks.add(element);
        if (element['state'] == 'done') doneTasks.add(element);
        if (element['state'] == 'archieved') archievedTasks.add(element);
      });

      emit(BottomGetDataSuccessState());
    }).catchError((error) {
      emit(BottomGetDataErrorState());
    });
  }

  void insertDb({String title, String date}) {
    database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks(title, date, state) VALUES("$title","$date","new" )');
    }).then((value) {
      getDb(database);
      emit(BottomInsertDataSuccessState());
    }).catchError((error) {
      emit(BottomInsertDataErrorState());
    });
  }

  void updateDb({
    @required String state,
    @required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET state = ? WHERE id = ?',
        ['$state', '$id']).then((value) {
      getDb(database);
      emit(BottomUpdateDataSuccessState());
    }).catchError((error) {
      emit(BottomUpdateDataErrorState());
    });
  }

  void deleteDb(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getDb(database);
      emit(BottomDeleteDataSuccessState());
    }).catchError((error) {
      emit(BottomDeleteDataErrorState());
    });
  }
}
