import 'package:desafio6etapa/screens/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';
import 'screens/esqueceuSenha.dart';
import 'screens/homeAtleta.dart';
import 'screens/perfilAtleta.dart';
import 'screens/cadastro.dart';
import 'screens/homeTreinador.dart';
import 'screens/registroTreino.dart';
import 'screens/cronometro.dart';
import 'screens/atletas.dart';
import 'screens/registroAtleta.dart';
import 'screens/homeADM.dart';
import 'screens/novoUsuario.dart';
import 'screens/informacoes_complementares.dart';

import 'widgets/barra_navegacao.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0b2d78), // Defina a cor da barra de status aqui
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Define a cor de fundo da aplicação
      ),
      home: HomeADM(), // Use a tela de login como página inicial
    );
  }
}