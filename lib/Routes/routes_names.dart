import 'package:covid_tracker/Routes/routes.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/View/country_detail_screen.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash_screen:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case RoutesNames.world_stats:
        return MaterialPageRoute(
            builder: ((context) => const WorldStatsScreen()));
      case RoutesNames.countries_list:
        return MaterialPageRoute(
            builder: ((context) => const CountriesListScreen()));
      case RoutesNames.country_detail_screen:
        return MaterialPageRoute(
            builder: ((context) =>
                DetailScreen(data: settings.arguments as Map)));
      default:
        return MaterialPageRoute(builder: ((context) {
          return const Scaffold(
            body: Center(child: Text('No Route Defined')),
          );
        }));
    }
  }
}
