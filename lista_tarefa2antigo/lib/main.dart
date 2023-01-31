import 'package:flutter/material.dart';
import 'package:lista_tarefa2antigo/models/todo.dart';
import 'package:lista_tarefa2antigo/repositories/todo_repository.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> _todoList = [];
  Todo? _lastRemove;
  int? _lastRemovedPos;

  final controle = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  void _addTodo() {
    setState(() {
      Todo newTodo = Todo(
        title: controle.text,
        ok: false,
      );
      _todoList.add(newTodo);
    });
    todoRepository.saveTodoList(_todoList);
    controle.text = "";
  }

  Future<Null> _refresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {
      _todoList.sort((a, b) {
        if (a.ok && !b.ok) {
          return 1;
        } else if (!a.ok && b.ok) {
          return -1;
        } else {
          return 0;
        }
      });
      todoRepository.saveTodoList(_todoList);
    });
    return null;
  }

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) => {
          setState(() {
            _todoList = value;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controle,
                    decoration: const InputDecoration(
                      labelText: "Nova tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text("Adicionar"),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: _todoList.length,
                  itemBuilder: buildItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_todoList[index].title),
        value: _todoList[index].ok,
        secondary: CircleAvatar(
          child: Icon(_todoList[index].ok ? Icons.check : Icons.error),
        ),
        onChanged: (value) {
          setState(() {
            _todoList[index].ok = value!;
            todoRepository.saveTodoList(_todoList);
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemove = _todoList.elementAt(index);
          _lastRemovedPos = index;
          _todoList.removeAt(index);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Tarefa ${_lastRemove?.title} removida!"),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _todoList.insert(_lastRemovedPos!, _lastRemove!);
                  });
                  todoRepository.saveTodoList(_todoList);
                },
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        });
      },
    );
  }
}
