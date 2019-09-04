class PredictionModel {
  String prediction;

  PredictionModel({this.prediction, List<RecipesModel> recipes});
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["prediction"] = prediction;

    return map;
  }

  PredictionModel.fromJson(Map<String, dynamic> map)
      : this(
          prediction: map["prediction"],
        );
}

class RecipesModel {
  String id;
  String ingridientDescription;
  String name;
  String preparationDescription;
  String recipeImage;
  RecipesModel(
      {this.id,
      this.ingridientDescription,
      this.name,
      this.preparationDescription,
      this.recipeImage});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['ingridientDescription'] = ingridientDescription;
    map['name'] = name;
    map['preparationDescription'] = preparationDescription;
    map['recipeImage'] = recipeImage;
    return map;
  }

  RecipesModel.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id'],
          ingridientDescription: map['ingridientDescription'],
          name: map['name'],
          preparationDescription: map['preparationDescription'],
          recipeImage: map['recipeImage'],
        );
}

// class RecipeModel {
//   String label;
//   String image;
//   List<IngridientsModel> ingridients;
//   RecipeModel({this.image, this.label, this.ingridients});
//   Map<String, dynamic> toJson() {
//     var map = Map<String, dynamic>();
//     map["label"] = label;
//     map["image"] = image;
//     map["ingeidients"] = ingridients;
//     return map;
//   }

//   RecipeModel.fromJson(Map<String, dynamic> map)
//       : this(
//           label: map["label"],
//           image: map["alias"],
//           ingridients: map["ingridients"],
//         );
// }

// class IngridientsModel {
//   String text;
//   double quantity;
//   String measure;
//   String food;
//   double weight;
//   IngridientsModel(
//       {this.food, this.measure, this.quantity, this.text, this.weight});

//   Map<String, dynamic> toJson() {
//     var map = Map<String, dynamic>();
//     map['text'] = text;
//     map['quantity'] = quantity;
//     map['measure'] = measure;
//     map['weight'] = weight;
//     map['food'] = food;
//     return map;
//   }

//   IngridientsModel.fromJson(Map<String, dynamic> map)
//       : this(
//           text: map['text'],
//           quantity: map['quantity'],
//           weight: map['weight'],
//           measure: map['weight'],
//           food: map['food'],
//         );
// }
