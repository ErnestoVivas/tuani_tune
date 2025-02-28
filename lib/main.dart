import 'package:flutter/material.dart';


import './home.dart';

void main() {
  runApp(MaterialApp(
    title: 'TuaniTune',
    initialRoute: '/',
    routes: {
      '/': (context) => const Home()
    },
  ));
}