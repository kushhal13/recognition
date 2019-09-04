import 'package:nayapp/AppState/appState.dart';
import 'package:nayapp/actions/action.dart';

AppState reducer(AppState state, Object action) {
  if (action is RecipeFetched) {
    return state.copyWith(
        predictionList: action.predictionList, recipeList: action.recipeList);
  }
  if (action == CleanFetchData.Cleandata) {
    return state.copyWith(
      predictionList: [],
      recipeList: [],
    );
  }
  return state;
}
