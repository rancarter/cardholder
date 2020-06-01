import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/credit_cards_model.dart';
import '../../widgets/card_form.dart';

class CreateCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardsModel>(builder: (context, cardlistModel, child) {
      final selectedCard = cardlistModel.getSelectedCard();

      void handleSubmit({String name, String number}) {
        if (selectedCard != null) {
          cardlistModel.updateCard(selectedCard.id, name, number);
        } else {
          cardlistModel.add(name, number);
        }

        Navigator.pushNamed(context, '/');
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Добавить карточку'),
        ),
        body: CardForm(
            name: selectedCard != null ? selectedCard.name : '',
            number: selectedCard != null ? selectedCard.number : '',
            onSubmit: (name, number) {
              handleSubmit(name: name, number: number);
            }),
      );
    });
  }
}
