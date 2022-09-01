import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';

class WAirportWeather extends StatefulWidget {
  const WAirportWeather({Key? key, required this.airport}) : super(key: key);
  final Airport airport;

  @override
  State<WAirportWeather> createState() => _WAirportWeatherState();
}

class _WAirportWeatherState extends State<WAirportWeather> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
