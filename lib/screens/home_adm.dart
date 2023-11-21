import 'package:desafio6etapa/screens/consultar_usuarios.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:desafio6etapa/screens/novo_usuario.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao_adm.dart';



class HomeADM extends StatefulWidget {
  @override
  _HomeADMState createState() => _HomeADMState();
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
        title: Text('Sair da Conta'),
        content: Text('Tem certeza de que deseja sair da conta?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _signOut(context); // Chama o método para fazer logout
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text('Sair'),
          ),
        ],
      );
    },
  );
}

class _HomeADMState extends State<HomeADM> {
  int _selectedIndex = 0;

  // Método para lidar com a troca de aba
  void _onItemTapped(int index) {
    if (index == 0) {
      // Navegar para a primeira tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeADM()), // Substitua 'Tela1' pela tela que deseja exibir
      );
    } else if (index == 1) {
      // Navegar para a segunda tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConsultarUsuarios()), // Substitua 'Tela2' pela tela que deseja exibir
      );
    }
    // Atualize o índice selecionado
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        toolbarHeight: 40.0,
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
                Text(
                  'Olá',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF06113C),
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  'Sarah,',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF06113C),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              'Bons treinos!',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                color: Color(0xFF06113C),
              ),
            ),
            SizedBox(height: 25.0),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NovoUsuario()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 0.0),
                      child: SvgPicture.asset('assets/novo_registro.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationADM(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeADM(),
  ));
}


