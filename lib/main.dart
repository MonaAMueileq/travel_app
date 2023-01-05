import 'package:flutter/material.dart';
import 'package:travel_app/app_data.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/screens/categories_screen.dart';
import 'package:travel_app/screens/category_trips_screen.dart';
import 'package:travel_app/screens/filters_screen.dart';
import 'package:travel_app/screens/tabs_screen.dart';
import 'package:travel_app/screens/trip_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;

  List<Trip> _favoriteTrips = [];
  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Prompt',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: prefer_const_constructors
              headline5: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Prompt',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              // ignore: prefer_const_constructors
              headline6: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Prompt',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteTrips),
        CategoryTripsScreen.screenRoute: (context) =>
            CategoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute: (context) =>
            TripDetailScreen(_manageFavorite, _isFavorite),
        FiltersScreen.screenRoute: (context) =>
            FiltersScreen(_changeFilters, _filters),
      },
    );
  }
}
