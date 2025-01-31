import 'package:flutter/material.dart';
import 'package:wheather_app/weatherapp.dart';

void main(){
  runApp(const MyApp());
 }
class MyApp extends StatelessWidget{
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const WeatherApp(),
    );
  } 
}