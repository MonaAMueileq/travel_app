import 'package:flutter/material.dart';
import 'package:travel_app/app_data.dart';

class TripDetailScreen extends StatelessWidget {
  static const screenRoute = '/trip-detail';
  final Function manageFavorite;
  final Function _isFavorite;
  TripDetailScreen(this.manageFavorite, this._isFavorite);
  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topLeft,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListViewContainer(Widget c) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: c);
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedTrip = Trips_data.firstWhere(
      (trip) => trip.id == tripId,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('${selectedTrip.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedTrip.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Activities'),
              buildListViewContainer(
                ListView.builder(
                  itemCount: selectedTrip.activities.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedTrip.activities[index]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildSectionTitle(context, 'Daily Program'),
              buildListViewContainer(
                ListView.builder(
                  itemCount: selectedTrip.program.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 30,
                          child: Text('Day ${index + 1}'),
                        ),
                        title: Text(selectedTrip.program[index]),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          child: Icon(
            _isFavorite(tripId) ? Icons.star : Icons.star_border,
            color: Colors.blue,
          ),
          onPressed: () => manageFavorite(tripId),
        ));
  }
}
