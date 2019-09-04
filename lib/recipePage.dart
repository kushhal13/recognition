import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nayapp/AppState/appState.dart';
import 'package:nayapp/RecipeDetailPage.dart';
import 'package:nayapp/actions/action.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onDispose: (store) => store.dispatch(CleanFetchData.Cleandata),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text('Recipe Lists'),
          ),
          body: state.predictionList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : state.recipeList == null
                  ? Center(
                      child: Text("Null"),
                    )
                  : ListView.builder(
                      itemCount: state.recipeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var recipe = state.recipeList;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RecipeDetailPage(
                                              recipe: recipe[index])));
                            },
                            child: Card(
                              elevation: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      constraints: BoxConstraints.expand(
                                        height: 300.0,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 16.0, bottom: 8.0, right: 16.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'http://2481d306.ngrok.io' +
                                                  recipe[index].recipeImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            right: 0.0,
                                            bottom: 0.0,
                                            child: Icon(Icons.star),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(recipe[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
