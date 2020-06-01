import 'dart:async';
import 'package:flutter/material.dart';

import '../credit_card_db.dart';

class CreditCard {
  int id;
  String name;
  String number;
  bool isSelected = false;

  CreditCard(this.id, this.name, this.number);

  String get formattedNumber {
    List<String> chunks = [];
    final int chunkSize = 4;

    for (var i = 0; i < number.length; i += chunkSize) {
      chunks.add(number.substring(i, i + chunkSize));
    }

    return chunks.join('-');
  }
}

class CreditCardsModel extends ChangeNotifier {
  final CreditCardsDB creditCardDB = new CreditCardsDB();

  List<CreditCard> cards = [];

  int get selectedItemsCount {
    return cards.where((card) => card.isSelected).toList().length;
  }

  Future<void> initCardsDB() {
    return creditCardDB.openDB();
  }

  Future<void> getCardsFromDB() async {
    final creditCards = await creditCardDB.getCreditCards();

    cards = List.generate(creditCards.length, (i) {
      return CreditCard(
        creditCards[i]['id'],
        creditCards[i]['name'],
        creditCards[i]['number'],
      );
    });

    notifyListeners();
  }

  Future<void> add(String name, String number) async {
    final id = await creditCardDB.insertCard({
      'name': name,
      'number': number,
    });

    cards.add(CreditCard(id, name, number));

    notifyListeners();
  }

  Future<void> updateCard(num id, String name, String number) async {
    try {
      await creditCardDB.updateCard(id, {
        'name': name,
        'number': number,
      });

      final card = cards.firstWhere((card) => card.id == id);

      card.name = name;
      card.number = number;
    } finally {
      notifyListeners();
    }
  }

  Future<void> delete(num id) async {
    await creditCardDB.deleteCards([id]);

    cards.removeWhere((card) => card.id == id);

    notifyListeners();
  }

  Future<void> deleteSelected() async {
    final List<num> ids =
        cards.where((card) => card.isSelected).map((card) => card.id).toList();

    await creditCardDB.deleteCards(ids);

    cards.removeWhere((card) => card.isSelected);

    notifyListeners();
  }

  void selectCard(bool value, num id) {
    try {
      final card = cards.firstWhere((card) => card.id == id);
      card.isSelected = value;
    } catch (error) {}
    notifyListeners();
  }

  void unselectAll() {
    cards.forEach((card) {
      card.isSelected = false;
    });
    notifyListeners();
  }

  CreditCard getSelectedCard() {
    try {
      final card = cards.firstWhere((card) => card.isSelected);
      return card;
    } catch (error) {
      return null;
    }
  }
}
