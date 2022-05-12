import 'dart:math';

import 'package:todolist/components/TarefaForm.dart';
import 'package:todolist/components/TarefaLista.dart';
import 'package:todolist/models/tarefa.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.deepPurple.shade300,
                secondary: Colors.amber,
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _novaTarefa(String titulo, DateTime data, String prioridade, String comentario) {
    Tarefa novaTarefa = Tarefa(id: Random().nextInt(9999).toString(), titulo: titulo, data: data, dataCria: DateTime.now(), prioridade: prioridade, comentario: comentario);

    setState(() {
      _tarefas.add(novaTarefa);
    });

    print(titulo);
  }

  List<Tarefa> _tarefas = [
    Tarefa(id: 't0', titulo: 'Estudar', data: DateTime.now(), prioridade: 'Alta', comentario: 'teste', dataCria: DateTime.now()),
    Tarefa(id: 't1', titulo: 'Jogar', data: DateTime.now(), prioridade: 'Alta', comentario: 'teste', dataCria: DateTime.now()),
    Tarefa(id: 't2', titulo: 'Assistir', data: DateTime.now().subtract(Duration(days: 2)), prioridade: 'Alta', comentario: 'teste', dataCria: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Adicionar Tarefa'),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 400,
                        //color: Colors.indigo.shade50,
                        child: Column(
                          children: <Widget>[
                            TarefaForm(_novaTarefa),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              child: const Text('Fechar', style: TextStyle(fontSize: 17)),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                TarefaLista(_tarefas)
              ],
            )
          ],
        ),
      ),
    );
  }
}
