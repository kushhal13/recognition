import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nayapp/AppState/appState.dart';
import 'package:nayapp/actions/action.dart';
import 'package:nayapp/recipePage.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:nayapp/AppReducer/AppReducer.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(
      predictionList: [],
      recipeList: [],
    ),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        title: " Recognition app",
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  File _image;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future getImage(bool isCamera) async {
      File image;
      if (isCamera) {
        image = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
      }
      _image = image;
      setState(() {});
      // _upload(_image);
      if (_image == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      } else {
        StoreProvider.of<AppState>(context)
            .dispatch(GetRecipe().getRecipeDetails(_image, scaffoldKey));
        StoreProvider.of<AppState>(context).dispatch(CleanFetchData.Cleandata);
      }
    }

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onDispose: (store) => store.dispatch(CleanFetchData.Cleandata),
      // onInit: (store) => store.dispatch(GetRecipe().getRecipeDetails()),
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: AppBar(
              backgroundColor: Colors.redAccent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text(
                      " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
              elevation: 10.0,
              leading: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 35.0,
                  ),
                  onPressed: () {
                    getImage(false);
                  },
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      getImage(true);
                    },
                    icon: Icon(
                      Icons.camera_enhance,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 64.0),
                    child: _image == null
                        ? Container(
                            child: Center(
                                child: Text(
                              "no image to show",
                              style: TextStyle(color: Colors.white),
                            )),
                            width: 350.0,
                            height: 350.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          )
                        : Container(
                            width: 350.0,
                            height: 350.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(_image),
                                ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _image == null
                        ? Text("capture/import a image")
                        : state.predictionList.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RecipePage())),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    width: 300.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      border: Border.all(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        // "banana",
                                        state.predictionList.isEmpty
                                            ? " "
                                            : state
                                                .predictionList[0].prediction,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
