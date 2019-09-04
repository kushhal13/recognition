import 'package:nayapp/model/recipeModel.dart';

class AppState {
  // PredictionModel predictionModel;
  List<PredictionModel> predictionList;
  List<RecipesModel> recipeList;
  AppState({this.predictionList, this.recipeList});

  AppState copyWith(
          {List<PredictionModel> predictionList,
          List<RecipesModel> recipeList}) =>
      AppState(
        recipeList: recipeList ?? this.recipeList,
        predictionList: predictionList ?? this.predictionList,
      );
}
