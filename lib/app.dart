import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home/home_screen.dart';
import './screens/create-card/create_card_screen.dart';
import './models/credit_cards_model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final CreditCardsModel creditCardsModel = CreditCardsModel();

  @override 
  void initState() {
    super.initState();
    iniCards();
  }

  Future<void> iniCards() async {
    await creditCardsModel.initCardsDB();
    await creditCardsModel.getCardsFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => creditCardsModel,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return HomeScreen();
          },
          '/create-card': (BuildContext context) {
            return CreateCardScreen();
          }
        },
      ),
    );
  }
}
