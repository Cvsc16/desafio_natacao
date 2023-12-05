import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/esqueceu_senha.dart';
import 'package:desafio6etapa/screens/home_adm.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _forgotPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EsqueceuSenha()));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
        String userType = userDoc['tipoUsuario'];

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
        _exibirToast('Por favor, verifique seu e-mail antes de fazer login.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _exibirToast('Os dados de login estão incorretos. Por favor, tente novamente.');
      } else {
        _exibirToast('Os dados de login estão incorretos. Por favor, tente novamente.');
      }
    }
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _exibirToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFF0b2d78),
      textColor: Colors.yellow,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Color(0xFF0b2d78),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fundo_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cima_fundo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 400*fem,
                width: double.infinity,
              ),
            ),
            // Conteúdo no centro da tela
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40*fem, top: 400*fem),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40*ffem,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20*fem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40*fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17*ffem,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF354170), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20*fem),
                      TextField(
                        controller: passwordController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17*ffem,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF354170), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 30*fem),
                      GestureDetector(
                        onTap: _forgotPassword,
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13*ffem,
                            fontWeight: FontWeight.w500,
                            color: Colors.yellow,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(height: 40*fem),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: () => _login(emailController.text, passwordController.text),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow,
                            onPrimary: Color(0xFF0C2172),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18*ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
