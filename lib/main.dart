import 'package:desafio6etapa/screens/SplashScreen.dart';
import 'package:desafio6etapa/screens/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/esqueceu_senha.dart';
import 'screens/home_atleta.dart';
import 'screens/perfil_atleta.dart';
import 'screens/cadastro.dart';
import 'screens/home_treinador.dart';
import 'screens/registro_treino_atleta.dart';
import 'screens/cronometro.dart';
import 'screens/atletas.dart';
import 'screens/registro_atleta.dart';
import 'screens/home_adm.dart';
import 'screens/novo_usuario.dart';
import 'screens/informacoes_complementares.dart';
import 'widgets/barra_navegacao_atleta.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: SplashScreen(), // Use a tela de login como página inicial
    );
  }
}