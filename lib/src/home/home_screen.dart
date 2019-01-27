import 'package:flutter/material.dart';
import './home_bloc.dart';
import './home_provider.dart';
import '../models/cocktail.dart';
import '../cocktail/cocktail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void didChangeDependencies() {
    _bloc = HomeProvider.of(context);
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0, // this will be set when a tab is tapped
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shuffle),
      //       title: Text('Random'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.category),
      //       title: Text('Categories'),
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.sort_by_alpha), title: Text('Alphabetic'))
      //   ],
      // ),
      appBar: AppBar(
        // elevation: 0.1,
        
        title: const Text('Cocktails'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              // Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Center(
          child: StreamBuilder(
              stream: _bloc.randomCocktails,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return _CocktailsListView(snapshot.data,
                          "Pictures and info: TheCocktailDB.com");
                    }
                }
              }),
        ),
      ),
    );
  }

  Future<void> _refresh() {
    _bloc.reloadRandomCocktails.add(1);
    return Future<void>.value();
  }
}

class _CocktailsListView extends StatelessWidget {
  final List<Cocktail> cocktails;
  final String text;
  const _CocktailsListView(this.cocktails, [this.text]);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = List();
    list.addAll(cocktails.map((cocktail) => _CocktailCard(cocktail)));
    if (this.text != null) {
      list.add(_CocktailsListViewBottomText(text));
    }
    return ListView(children: list);
  }
}

class _CocktailsListViewBottomText extends StatelessWidget {
  final String text;
  const _CocktailsListViewBottomText(this.text);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          this.text,
        ),
      ),
    );
  }
}

class _CocktailCard extends StatelessWidget {
  final Cocktail cocktail;

  const _CocktailCard(this.cocktail);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //You need to make my child interactive
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CocktailScreen(cocktail),
          ),
        );
      },
      child: Card(
        // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          fadeInDuration: Duration(milliseconds: 450),
                          fadeInCurve: Curves.ease,
                          fadeOutCurve: Curves.ease,
                          fadeOutDuration: Duration(milliseconds: 151),
                          fit: BoxFit.cover,
                          placeholder: 'assets/bg_${cocktail.id % 5}.jpg',
                          image: cocktail.thumbUrl,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          cocktail.name,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
