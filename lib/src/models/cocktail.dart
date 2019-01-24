class Cocktail {
  int id;
  String name;
  String category;
  String ibaCategory;
  String alcoholic;
  String glass;
  String instructions;
  String thumbUrl;
  List<Ingredient> ingredients;

  Cocktail() {}

  factory Cocktail.fromJson(Map<String, dynamic> parsedJson) {
    Cocktail c = Cocktail();
    c.id = int.parse(parsedJson['idDrink']);
    c.name = parsedJson['strDrink'];
    c.category = parsedJson['strCategory'];
    c.ibaCategory = parsedJson['strIBA'];
    c.glass = parsedJson['strGlass'];
    c.instructions = parsedJson['strInstructions'];
    c.thumbUrl = parsedJson['strDrinkThumb'];
    return c;
  }
}

class Ingredient {
  String ingredient;
  String measure;
}