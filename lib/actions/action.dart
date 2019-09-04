import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nayapp/appUtil.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:nayapp/AppState/appState.dart';
import 'package:nayapp/model/recipeModel.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class GetRecipe {
  ThunkAction<AppState> getRecipeDetails(
      File imageFile, GlobalKey<ScaffoldState> scaffoldKey) {
    return (Store<AppState> store) async {
      print("Reached action");
      Dio dio = new Dio();
      bool isConnected = await AppUtil.checkConnection();

      if (isConnected) {
        List<RecipesModel> recipeList = new List();
        List<PredictionModel> predictionList = new List();

        FormData formdata = FormData.from(
            {"file": UploadFileInfo(imageFile, basename(imageFile.path))});

        try {
          await dio
              .post('http://22e025c8.ngrok.io/api/uploads',
                  data: formdata,
                  options: Options(
                    method: 'POST',
                    responseType: ResponseType.json,
                  ))
              .then((response) {
            var responseBody = response.data;

            var prediction = responseBody['prediction'];
            var ingredientsData = responseBody["recipes"];

            if (ingredientsData.length > 0) {
              ingredientsData.forEach((item) => recipeList.add(RecipesModel(
                    id: item['id'].toString(),
                    ingridientDescription: item['ingredientDescription'],
                    name: item['name'],
                    preparationDescription: item['preparationDescription'],
                    recipeImage: item['recipeImage'],
                  )));
              print("ingredientsData:$ingredientsData");
            }

            predictionList.add(PredictionModel(
              prediction: prediction,
            ));

            store.dispatch(RecipeFetched(
                predictionList: predictionList, recipeList: recipeList));
          });
        } on SocketException catch (e) {
          print("the error is:$e");
          return null;
        }
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No server found"),
        ));
      }
    };
  }
}

class RecipeFetched {
  List<PredictionModel> predictionList;
  List<RecipesModel> recipeList;
  RecipeFetched({this.predictionList, this.recipeList});
}

enum CleanFetchData {
  Cleandata,
}
