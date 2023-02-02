import 'package:api_app_firebase/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxis App',
      initialRoute: 'home',
      theme: ThemeData.dark(),
      routes:{
        'home': (context) => const HomeScreen(),
        'taxi_d': (context) => const TaxiDisponibleScreen(),
        'conductores': (context) => const ConductoresScreen(),
        'taxi_s': (context) => const SolicitarScreen(), 
      }
    );
  }
}