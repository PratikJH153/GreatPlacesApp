import 'package:flutter/material.dart';
import 'package:greatplacesapp/views/add_place_page.dart';
import 'package:greatplacesapp/views/places_list_page.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Great Places App",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
        ),
        initialRoute: PlacesListPage.routeName,
        routes: {
          PlacesListPage.routeName: (ctx) => const PlacesListPage(),
          AddPlacePage.routeName: (ctx) => const AddPlacePage(),
        },
      ),
    );
  }
}
