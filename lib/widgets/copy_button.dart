import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String text;
  Function onCopy;

  CopyButton({this.text, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.all(6.0),
      splashColor: Colors.blueAccent,
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: text));
        onCopy();
      },
      child: Text('Copy'),
    );
  }
}
