import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EsqueceuSenha extends StatefulWidget {
  @override
  _EsqueceuSenhaState createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  final TextEditingController emailController = TextEditingController();

  final emailToUserType = {
    'atleta@gmail.com': 'atleta',
    'treinador@gmail.com': 'treinador',
    'adm@gmail.com': 'administrador',
  };

  void _esqueceuSenha(String email) {
    if (emailToUserType.containsKey(email)) {

      final usuario = emailToUserType[email];
      print('Email de verificação enviado para $email (Tipo de Usuário: $usuario)');
      // Exibir um diálogo informando que o email de verificação foi enviado
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Email de Verificação Enviado'),
            content: Text('Um email de verificação foi enviado para $email (Tipo de Usuário: $usuario).'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // O email não está cadastrado no sistema
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Email Não Encontrado'),
            content: Text('O email $email não está cadastrado no sistema.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
      SliverAppBar(
      backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: SvgPicture.asset('assets/ic_volta.svg'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 20.0), // Espaço superior
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                  child: SvgPicture.asset(
                    'assets/img_esqueceuSenha.svg',
                    width: 320,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Esqueceu\nsua senha?',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C2172),
                  ),
                )
              ),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Text(
                  'Não se preocupe. Por favor, insira abaixo o email associado a sua conta.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    color: Color(0xFF010410),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: emailController,
                    style: TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF354170),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0C2172),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () => _esqueceuSenha(emailController.text),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0C2172),
                      onPrimary: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isKeyboardVisible ? 10.0 : 0.0), // Espaço extra para acomodar o teclado
          ],
        ),
      ),
        ],
    ),

    );
  }
}
