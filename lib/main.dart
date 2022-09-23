import 'package:flutter/material.dart';
import 'tarefa.dart';

main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'TodoList App', home: ListaScreen());
  }
}

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaScreenState();
  }
}

class ListaScreenState extends State<ListaScreen> {
  List<Tarefa> tarefas = <Tarefa>[];
  TextEditingController controller = TextEditingController();
  


  void adicionaTarefa(String nome) {
    setState(
      () {
        tarefas.add(
          Tarefa(
            nome: nome,
            concluida: false,
            data: DateTime.now(),
          ),
        );
      },
    );
    controller.clear();
  }

  Widget getItem(Tarefa tarefa) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(
              () {
                tarefa.concluida = true;
              },
            );
          },
          icon: Icon(
            tarefa.concluida ? Icons.check_box : Icons.check_box_outline_blank,
            size: 42.0,
            color: Colors.green,
          ),
          padding: const EdgeInsets.only(left: 10.0, right: 30.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tarefa.nome,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(tarefa.data.toIso8601String()) // Intl
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("To Do List")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: controller, onSubmitted: adicionaTarefa)),
          Expanded(
              child: ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (_, indice) {
              return getItem(tarefas[indice]);
            },
          ))
        ],
      ),
    );
  }
}
