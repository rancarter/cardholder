import 'package:flutter/material.dart';

class CardForm extends StatefulWidget {
  Function onSubmit;
  String name = '';
  String number = '';

  CardForm({this.onSubmit, this.name, this.number});

  @override
  _CardFormState createState() => _CardFormState(name, number);
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String number = '';

  @override
  initState() {
    print(name);
  }

  _CardFormState(this.name, this.number);

  void handleSubmit() {
    final form = _formKey.currentState;

    if (!form.validate()) {
      return;
    }

    widget.onSubmit(name, number);
    resetForm();
  }

  void resetForm() {
    setState(() {
      name = '';
      number = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Имя карты'),
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Обязательное поле';
                  }

                  return null;
                },
              ),
              Container(height: 16.0),
              TextFormField(
                maxLength: 16,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Номер карты'),
                initialValue: number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Обязательное поле';
                  }

                  if (value.length < 16) {
                    return 'Неправильный номер карты';
                  }

                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    number = value;
                  });
                },
              ),
              Container(
                  padding: EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: handleSubmit,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Submit'),
                  )),
            ])));
  }
}
