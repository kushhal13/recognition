import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nayapp/model/recipeModel.dart';

class RecipeDetailPage extends StatelessWidget {
  final RecipesModel recipe;
  RecipeDetailPage({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 380.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 340.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'http://2481d306.ngrok.io' + recipe.recipeImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      height: 70,
                      //color: Colors.grey.withOpacity(0.4),
                      child: Card(
                        elevation: 32,
                        child: Center(
                          child: Text(recipe.name,
                              style: Theme.of(context).textTheme.title),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ingredients",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4.0,
                      child: Html(
                        data: recipe.ingridientDescription,
                        useRichText: true,
                        defaultTextStyle: TextStyle(
                          height: 1.1,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Html(
                    data: recipe.preparationDescription,
                    useRichText: true,
                    defaultTextStyle: TextStyle(height: 1.1, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Column(
            //       children: recipe.ingridients.map((item) {
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: <Widget>[
            //         Expanded(
            //           child: Text(item.text),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.all(8),
            //         ),
            //         Text(item.quantity.toString()),
            //       ],
            //     );
            //   }).toList()),
            // )
          ],
        ),
      ),
    );
  }
}
