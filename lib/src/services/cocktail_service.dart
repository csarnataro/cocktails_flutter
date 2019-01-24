import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cocktail.dart';

class CocktailService {
  //https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink
  // https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11844

  Future<List<Cocktail>> fetchRandomCocktails() async {
    print('Making a real network call here!');
    final response = await http.get(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink');

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      try {
        List<dynamic> cocktails = result['drinks'];
        cocktails.shuffle();
        cocktails = cocktails.sublist(0, 10).toList();
        for (var i = 0; i < cocktails.length; i++) {
          print(cocktails[i]);
          print(Cocktail.fromJson(cocktails[i]));
        }
        return Future.value(cocktails
            .map((c) => Cocktail.fromJson(c))
            .toList()); // .map((cocktail) => Cocktail.fromJson(cocktail));
      } catch (e) {
        print(e);
        throw Exception('Failed to fetch random cocktails');
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load cocktails');
    }
  }
}
