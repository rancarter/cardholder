import 'package:flutter/material.dart';

import '../models/credit_cards_model.dart';
import 'card_item.dart';

class CardList extends StatelessWidget {
  Function onCardLongPress;
  Function selectCard;
  List<CreditCard> cards;
  bool isEditMode;

  CardList({this.cards, this.isEditMode, this.onCardLongPress, this.selectCard});

  @override
  build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
            children: cards
                .map((card) => CardItem(
                      card: card,
                      isEditMode: isEditMode,
                      onLongPress: onCardLongPress,
                      selectCard: selectCard,
                    ))
                .toList()));
  }
}
