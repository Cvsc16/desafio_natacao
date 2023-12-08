import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/perfil_treinador.dart';
import 'package:desafio6etapa/screens/perfil_usuarios.dart';
import 'package:desafio6etapa/screens/perfil_usuarios_atleta.dart';
import 'package:desafio6etapa/screens/registro_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsuariosConsulta extends StatefulWidget {
  final String tipoUsuario;

  UsuariosConsulta({required this.tipoUsuario});

  @override
  _UsuariosConsultaState createState() => _UsuariosConsultaState();
}

class _UsuariosConsultaState extends State<UsuariosConsulta> {
  List<Map<String, dynamic>> usuarios = [];

  @override
  void initState() {
    super.initState();
    _buscarUsuarios();
  }

  Future<void> _buscarUsuarios() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('tipoUsuario', isEqualTo: widget.tipoUsuario)
          .get();

      setState(() {
        usuarios = querySnapshot.docs
            .map((doc) => {
          'userId': doc.id, // Adicionando o ID do usuário
          ...doc.data() as Map<String, dynamic>,
        })
            .toList();
      });
    } catch (e) {
      print("Erro ao buscar usuários: $e");
    }
  }

  Future<void> _marcarComoInativo(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('usuarios')
          .doc(userId)
          .update({'status': 'inativo'});
      // Exibir mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário marcado como inativo.'),
        ),
      );
      // Atualizar a lista de usuários
      _buscarUsuarios();
    } catch (e) {
      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao marcar usuário como inativo: $e'),
        ),
      );
    }
  }

  Future<void> _mostrarDialogoConfirmacao(String userId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário deve tocar em um botão para fechar o diálogo
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Ação'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Você tem certeza que deseja inativar este usuário?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Fecha o diálogo sem fazer nada
              },
            ),
            TextButton(
              child: const Text('Inativar'),
              onPressed: () {
                // Chama a função para inativar o usuário
                _marcarComoInativo(userId);
                Navigator.of(dialogContext).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
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
            backgroundColor: Colors.white,
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
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                widget.tipoUsuario,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * ffem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20 * ffem),
                  for (var usuario in usuarios) // Loop para criar um card para cada usuário
                    GestureDetector(
                      onTap: () {
                        if (usuario['tipoUsuario'] == 'atleta') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilUsuariosAtleta(idAtleta: usuario['userId'])));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilUsuarios(idUsuario: usuario['userId'])));
                        }
                      },
                      child: Container(
                        height: 90,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF0C2172),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center, // Centralizar verticalmente
                              children: [
                                Text(
                                  usuario['nome'], // Nome do usuário
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                  ),
                                ),
                                SizedBox(height: 10.0 * ffem), // Espaço entre o nome e o status
                                Text(
                                  usuario['status'] ?? 'Status desconhecido', // Status do usuário
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _mostrarDialogoConfirmacao(usuario['userId']);
                              },
                            ),
                            SvgPicture.asset('assets/avancar.svg'),
                            SizedBox(width: 25),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

