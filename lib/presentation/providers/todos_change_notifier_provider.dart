
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:uuid/uuid.dart';

import '../../domain/domain.dart';

const _uuid = Uuid();

final todosChangeNotifierProvider = ChangeNotifierProvider<TodosChangeNotifier>((ref) {
  return TodosChangeNotifier();
});


class TodosChangeNotifier extends ChangeNotifier{
  List<Todo> todos = [
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),    
  ];


  void addTodo(){
    todos = [
      ...todos,
      Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    ];
    notifyListeners();
  }

  void toggleTodo( String id ) {
    todos = todos.map((todo) {
      if ( todo.id != id ) return todo;

      if ( todo.done ) return todo.copyWith( completedAt: null);

      return todo.copyWith( completedAt: DateTime.now() );
    }).toList();
    notifyListeners();
  }


}