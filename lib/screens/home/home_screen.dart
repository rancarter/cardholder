import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/card_list.dart';
import '../../models/credit_cards_model.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEditMode = false;

  void setEditMode() {
    setState(() {
      isEditMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardsModel>(
      builder: (context, creditCardList, child) {
        List<Widget> buildActions() {
          final List<Widget> actions = [];

          if (isEditMode && creditCardList.selectedItemsCount == 1) {
            actions.add(
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/create-card');
                },
              ),
            );
          }

          if (isEditMode && creditCardList.selectedItemsCount > 0) {
            actions.add(
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  creditCardList.deleteSelected();
                },
              ),
            );
          }

          return actions;
        }

        return Scaffold(
          appBar: AppBar(title: Text('Кредитные карты'), actions: buildActions()),
          body: CardList(
            cards: creditCardList.cards,
            isEditMode: isEditMode,
            onCardLongPress: setEditMode,
            selectCard: creditCardList.selectCard,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create-card');
            },
            tooltip: 'Добавить карту',
            child: Icon(Icons.add, size: 30.0),
          ),
        );
      },
    );
  }
}
