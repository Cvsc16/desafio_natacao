import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/esqueceuSenha.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EsqueceuSenha(), // Use a tela de login como página inicial
    );
  }
}