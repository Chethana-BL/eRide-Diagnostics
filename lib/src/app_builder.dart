import 'package:flutter/material.dart';

import 'views/bike_dashboard.dart';

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 14.0,
          ),
          labelSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: const BikeDashboard(),
    );
  }
}
