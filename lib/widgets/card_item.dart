import 'package:flutter/material.dart';

import '../models/credit_cards_model.dart';
import 'copy_button.dart';

class CardItem extends StatelessWidget {
  bool isEditMode;
  final CreditCard card;
  final Function onLongPress;
  final Function selectCard;

  CardItem({this.card, this.isEditMode, this.onLongPress, this.selectCard});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          onLongPress();
          selectCard(true, card.id);
        },
        child: Card(
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (isEditMode)
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Checkbox(
                              value: card.isSelected,
                              onChanged: (value) {
                                selectCard(value, card.id);
                              },
                            ),
                          ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(card.name),
                              Container(height: 10.0),
                              Text(card.formattedNumber),
                            ]),
                      ],
                    ),
                    CopyButton(
                        text: card.number,
                        onCopy: () {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Card number copied :)')));
                        }),
                  ],
                ))));
  }
}
