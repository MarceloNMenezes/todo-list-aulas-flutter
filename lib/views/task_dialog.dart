import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _controledetexto = TextEditingController();
  final _descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Task _listatarefa = Task();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _listatarefa = Task.fromMap(widget.task.toMap());
    }

    _controledetexto.text = _listatarefa.title;
    _descricaoController.text = _listatarefa.descricao;
  }

  @override
  void dispose() {
    super.dispose();
    _controledetexto.clear();
    _descricaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Nova tarefa' : 'Editar tarefas'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextFormField(
                controller: _controledetexto,
                decoration: InputDecoration(labelText: 'Título'),
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Entre com o Título';
                  }
                  return null;
                }),
            TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Entre com a Descrição';
                  }
                  return null;
                }),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _listatarefa.title = _controledetexto.value.text;
              _listatarefa.descricao = _descricaoController.text;
              Navigator.of(context).pop(_listatarefa);
            }
          },
        ),
      ],
    );
  }
}
