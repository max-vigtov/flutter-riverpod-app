import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      body: const _TodosView(),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read( todosChangeNotifierProvider.notifier).addTodo();
        }
      
      ),
    );
  }
}

class _TodosView extends ConsumerWidget {
  const _TodosView();

  @override
  Widget build(BuildContext context, ref) {

    final todosChangeNotifier = ref.watch(todosChangeNotifierProvider);
    final todos = todosChangeNotifier.todos;

    return Column(
      children: [
       
        // SegmentedButton(
        //   segments: const[
        //     ButtonSegment(value: TodoFilterOptions.all, icon: Text('Todos')),
        //     ButtonSegment(value: TodoFilterOptions.completed, icon: Text('Invitados')),
        //     ButtonSegment(value: TodoFilterOptions.pending, icon: Text('No invitados')),
        //   ], 
        //   selected: <TodoFilterOptions>{ currentFilter },
        //   onSelectionChanged: (value) {
        //     ref.read(filterProvider.notifier).state = value.first;
        //   },
        // ),
        // const SizedBox( height: 5 ),

       // Listado de personas a invitar
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return SwitchListTile(
                title: Text(todo.description),
                value: todo.done, 
                onChanged: ( value ) {
                  ref.read( todosChangeNotifierProvider.notifier).toggleTodo( todo.id );
                }
              );
            },
          ),
        )
      ],
    );
  }
}