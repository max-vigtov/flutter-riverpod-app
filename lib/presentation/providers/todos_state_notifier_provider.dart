import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:uuid/uuid.dart';
import '../../domain/domain.dart';

const _uuid = Uuid();

final todosStateNotifierProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

class TodosNotifier extends StateNotifier<List<Todo>>{
  TodosNotifier(): super([
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
  ]);

  void addTodo(){
    state = [
      ...state,
      Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    ];
  }

  void toggleTodo( String id ) {
    state = state.map((todo) {
      if ( todo.id != id ) return todo;

      if ( todo.done ) return todo.copyWith( completedAt: null);

      return todo.copyWith( completedAt: DateTime.now() );
    }).toList();
  }
}

enum TodoFilterOptions { all, completed, pending }

final filterProvider = StateProvider<TodoFilterOptions>((ref) {
  return TodoFilterOptions.all;
});

final filteredGuestProvider = Provider<List<Todo>>((ref) {

  final selectedFilter = ref.watch(filterProvider);
  final todos = ref.watch(todosStateNotifierProvider);

  switch (selectedFilter) {
    case TodoFilterOptions.all:
      return todos;
    
    case TodoFilterOptions.completed:
      return todos.where((todo) => todo.done).toList();
    
    case TodoFilterOptions.pending:
      return todos.where((todo) => !todo.done).toList();  
  }
});