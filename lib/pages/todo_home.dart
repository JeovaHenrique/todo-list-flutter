import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? todoDeleted;
  int? todoDeletedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex. Estudar Flutter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14)),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Voc?? possui ${todos.length} tarefas pendentes",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14)),
                      child: Text("Limpar Tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    todoDeleted = todo;
    todoDeletedIndex = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} deletada com Sucesso.",
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "Desfazer",
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              todos.insert(todoDeletedIndex!, todoDeleted!);
            });
          },
        ),
      ),
    );
  }
}
