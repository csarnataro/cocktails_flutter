import 'package:flutter/material.dart';
import '../models/cocktail.dart';

class CocktailScreen extends StatefulWidget {
  final Cocktail cocktail;

  CocktailScreen(this.cocktail);

  @override
  _CocktailScreenState createState() => _CocktailScreenState();
}

class _CocktailScreenState extends State<CocktailScreen> {
  @override
  Widget build(BuildContext context) {
    Cocktail currentCocktail = widget.cocktail;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Material(
                  child: new IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  shape: new CircleBorder(),
                ),
              ),
              expandedHeight: 350.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(currentCocktail.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      )),
                  background: Image.network(
                    currentCocktail.thumbUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Text('See details of ${currentCocktail.name}'),
        ),
      ),
    );
  }
}
