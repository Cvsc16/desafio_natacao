import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_adm.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _redirected = false;

  @override
  void initState() {
    super.initState();
    _verificarAutenticacao();
  }

  Future<void> _verificarAutenticacao() async {
    if (_redirected) {
      return; // Já redirecionado, não faça nada
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;

    // Verificar se há um usuário autenticado
    User? user = _auth.currentUser;

    if (user != null) {
      // Se o usuário estiver autenticado, obtenha o tipo de usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      String userType = userDoc['tipoUsuario'];

      // Redirecionar para a tela apropriada com base no tipo de usuário
      if (userType == 'atleta') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeAtleta()),
        );
      } else if (userType == 'treinador') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeTreinador()),
        );
      } else if (userType == 'administrador') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeADM()),
        );
      }
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      });
    }

    // Marcando que o redirecionamento foi feito
    setState(() {
      _redirected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF00ADEE),
        child: Center(
          child: Image.asset(
            'assets/loading_gif.gif',
          ),
        ),
      ),
    );
  }
}

