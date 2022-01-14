import 'package:flutter/material.dart';
import 'package:greatplacesapp/providers/great_places.dart';
import 'package:greatplacesapp/views/add_place_page.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  static const routeName = "/";
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlacePage.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return Consumer<GreatPlaces>(
            child: const Center(
              child: Text("Got no places yet, Start adding some!"),
            ),
            builder: (ctx, greatPlace, ch) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : greatPlace.items.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlace.items.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlace.items[index].image,
                                  ),
                                ),
                                title: Text(greatPlace.items[index].title),
                                onTap: () {},
                              );
                            },
                          ),
          );
        },
      ),
    );
  }
}
