import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/consultar_usuarios.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:desafio6etapa/screens/novo_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeADM extends StatefulWidget {
  @override
  _HomeADMState createState() => _HomeADMState();
}

class _HomeADMState extends State<HomeADM> {
  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    _getNomeUsuario();
  }

  Future<void> _getNomeUsuario() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userData = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      setState(() {
        String nomeCompleto = userData.data()?['nome'] ?? '';
        List<String> partesNome = nomeCompleto.split(' ');
        nomeUsuario = partesNome.isNotEmpty ? partesNome[0] : '';
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print('Erro durante o logout: $e');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Tem certeza de que deseja sair da conta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(context);
                Navigator.of(context).pop();
              },
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => _showLogoutConfirmationDialog(context),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text(
                  'Olá',
                  style: TextStyle(fontSize: 36.0, fontFamily: 'Inter', fontWeight: FontWeight.w300, color: Color(0xFF06113C)),
                ),
                const SizedBox(width: 5.0),
                Text(
                  '$nomeUsuario,',
                  style: const TextStyle(fontSize: 36.0, fontFamily: 'Open Sans', fontWeight: FontWeight.w600, color: Color(0xFF06113C)),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Bons treinos!',
              style: TextStyle(fontSize: 15.0, fontFamily: 'Open Sans', fontWeight: FontWeight.w400, color: Color(0xFF06113C)),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NovoUsuario())),
              child: SvgPicture.asset('assets/novo_registro.svg'),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultarUsuarios())),
              child: SvgPicture.asset('assets/consultar_svg.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
