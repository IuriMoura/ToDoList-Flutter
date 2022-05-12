import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefaForm extends StatefulWidget {
  void Function(String, DateTime, String, String) onSubmit;

  TarefaForm(this.onSubmit);

  @override
  State<TarefaForm> createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefaForm> {
  String dropdownValue = 'Baixa';
  final _tarefaController = TextEditingController();
  final _comentarioController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  _submitForm() {
    final titulo = _tarefaController.text;
    final comentario = _comentarioController.text;
    final prioridade = dropdownValue;

    if (titulo.isEmpty) {
      return;
    }
    if (comentario.isEmpty) {
      return;
    }

    widget.onSubmit(titulo, _dataSelecionada, prioridade, comentario);
  }

  _showDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2023)).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: _tarefaController,
        decoration: InputDecoration(icon: Icon(Icons.add_task), labelText: 'Tarefa'),
      ),
      TextField(
        controller: _comentarioController,
        decoration: InputDecoration(icon: Icon(Icons.note), labelText: 'Comentario'),
      ),
      Container(
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'Prioridade',
              style: TextStyle(fontSize: 17),
            )),
            DropdownButton<String>(
              value: dropdownValue,
              elevation: 24,
              style: const TextStyle(color: Colors.deepPurple, fontSize: 17),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Alta',
                'Normal',
                'Baixa'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada)}', style: TextStyle(fontSize: 17)),
            ),
            TextButton(onPressed: _showDatePicker, style: TextButton.styleFrom(primary: Colors.amber), child: Text('Selecionar data', style: TextStyle(fontSize: 17)))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: _submitForm, child: Text('Confirmar', style: TextStyle(fontSize: 17))),
      ),
    ]);
  }
}
