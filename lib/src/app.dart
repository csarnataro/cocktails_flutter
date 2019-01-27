import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import './home/home_provider.dart';
import './home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: MaterialApp(
        home: new HomeScreen(),
        title: 'Cocktails',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          
        ),
      ),
    );
  }
}
