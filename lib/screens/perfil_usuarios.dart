import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PerfilUsuarios extends StatefulWidget {
  final String idUsuario;

  PerfilUsuarios({required this.idUsuario});

  @override
  _PerfilUsuariosState createState() => _PerfilUsuariosState();
}

class _PerfilUsuariosState extends State<PerfilUsuarios> {
  String _nomeOriginal = '';
  String _emailOriginal = '';

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obterInfoUsuario();


  }

  void _atualizarEstado() {
    setState(() {
      if (_nomeOriginal.isEmpty) {
        _nomeOriginal = _nomeController.text;
      }

      if (_emailOriginal.isEmpty) {
        _emailOriginal = _emailController.text;
      }
    });
  }

  Future<void> _obterInfoUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;

      // Obter a referência do documento do usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(widget.idUsuario).get();

      // Verificar se o documento existe antes de acessar os dados
      if (userDoc.exists) {
        // Obter os dados do documento do usuário
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Atualizar os controladores dos campos com os dados do usuário
        _nomeController.text = userData['nome'] ?? '';
        _emailController.text = userData['email'] ?? '';

        _atualizarEstado();
      }
  }

  Future<void> _atualizarPerfil() async {
    try {
        await FirebaseFirestore.instance.collection('usuarios').doc(widget.idUsuario).update({
          'nome': _nomeController.text,
          'email': _emailController.text,
        });

        // Atualizar o estado após a atualização
        _atualizarEstado();

        _exibirToast('Perfil atualizado com sucesso');

        // Desativar o botão novamente após a confirmação
        setState(() {
          _nomeOriginal = _nomeController.text;
          _emailOriginal = _emailController.text;
        });

    } catch (e) {
      // Lidar com erros, se houver algum problema durante a atualização
      _exibirToast('Erro durante a atualização do perfil: $e');
    }
  }

  bool _dadosForamAlterados() {
    return _nomeController.text.trim() != _nomeOriginal.trim() ||
        _emailController.text.trim() != _emailOriginal.trim();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navegue para a tela de login ou qualquer outra tela desejada após o logout
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print('Erro durante o logout: $e');
      // Lidar com erros, se necessário
    }
  }

// ...

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Tem certeza de que deseja sair da conta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(context); // Chama o método para fazer logout
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  void _exibirToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFF0b2d78),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: SizedBox(
                width: 24.0,  // Defina a largura desejada
                height: 24.0,  // Defina a altura desejada
                child: SvgPicture.asset('assets/ic_volta.svg'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red, // Defina a cor do ícone como vermelho
                ),
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Meu Perfil',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF06113C),
                ),
              ),
            ), systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40 * ffem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40 * ffem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _nomeController,
                        onChanged: (value) {
                          _atualizarEstado();
                          setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                        },
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0C2172),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF2C2C2E),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0C2172),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      TextField(
                        controller: _emailController,
                        onChanged: (value) {
                          _atualizarEstado();
                          setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                        },
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0C2172),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF2C2C2E),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF0C2172),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _dadosForamAlterados() ? _atualizarPerfil : null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: _dadosForamAlterados() ? const Color(0xFF0C2172) : Colors.grey, // Altera a cor de fundo para cinza quando desativado
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Salvar Informações',
                              style: TextStyle(
                                fontSize: 18 * ffem,
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
          ),
        ],
      ),
    );
  }
}
