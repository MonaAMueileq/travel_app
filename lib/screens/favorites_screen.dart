import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';

import '../widgets/trip_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> favoriteTrips;
  FavoritesScreen(this.favoriteTrips);
  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) {
      return const Center(
        child: Text('There is No Favorite Trips'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TripItem(
            title: favoriteTrips[index].title,
            imageUrl: favoriteTrips[index].imageUrl,
            duration: favoriteTrips[index].duration,
            tripType: favoriteTrips[index].tripType,
            season: favoriteTrips[index].season,
            id: favoriteTrips[index].id,
            //removeItem: _removeTrip,
          );
        },
        itemCount: favoriteTrips.length,
      );
    }
  }
}
