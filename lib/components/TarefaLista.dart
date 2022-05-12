import 'package:todolist/models/tarefa.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TarefaLista extends StatelessWidget {
  List<Tarefa> _tarefaLista;

  TarefaLista(this._tarefaLista);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 281,
      child: ListView.builder(
        itemCount: _tarefaLista.length,
        itemBuilder: (context, index) {
          final tarefa = _tarefaLista[index];
          return Card(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 800,
                          //color: Colors.indigo.shade50,
                          child: Column(
                            children: <Widget>[
                              Row(child: Text('titulo')),
                              Expanded(child: Text(tarefa.titulo, style: TextStyle(fontSize: 18))),
                              Expanded(child: Text(tarefa.comentario, style: TextStyle(fontSize: 18))),
                              Expanded(child: Text(tarefa.prioridade, style: TextStyle(fontSize: 18))),
                              SizedBox(
                                height: 10,
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
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: tarefa.data.day >= DateTime.now().day ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(DateFormat('d MMM y').format(tarefa.data), style: TextStyle(color: tarefa.data.day >= DateTime.now().day ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary))),
                ),
                Text(tarefa.titulo),
              ],
            ),
          );
        },
      ),
    );
  }
}
