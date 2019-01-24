import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/cocktail.dart';
import '../services/cocktail_service.dart';

class HomeBloc {
    BehaviorSubject<List<Cocktail>> _randomCocktailsSubject =
      BehaviorSubject<List<Cocktail>>();

  StreamController<int> _refreshController =
      StreamController<int>();

  CocktailService service = CocktailService();

  HomeBloc() {
    _init();
    _refreshController.stream.listen(_reloadRandomCocktails);
  }

  void _init() async {
    List<Cocktail> randomCocktails = await service.fetchRandomCocktails();
    _randomCocktailsSubject.sink.add(randomCocktails);
  }

  void _reloadRandomCocktails(int) async {
    List<Cocktail> randomCocktails = await service.fetchRandomCocktails();
    _randomCocktailsSubject.sink.add(randomCocktails);
  }

  Stream<List<Cocktail>> get randomCocktails => _randomCocktailsSubject.stream;
  
  Sink<int> get reloadRandomCocktails => _refreshController.sink;

}