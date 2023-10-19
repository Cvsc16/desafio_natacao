import 'package:desafio6etapa/screens/consultarUsuarios.dart';
import 'package:desafio6etapa/screens/novoUsuario.dart';
import 'package:desafio6etapa/screens/perfilAtleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao3.dart';



class HomeADM extends StatefulWidget {
  @override
  _HomeADMState createState() => _HomeADMState();
}

class _HomeADMState extends State<HomeADM> {
  int _selectedIndex = 0;

  // Método para lidar com a troca de aba
  void _onItemTapped(int index) {
    // Aqui você pode adicionar a lógica para lidar com a troca de aba
    // Por exemplo, você pode usar um Navigator para navegar para diferentes telas com base na aba selecionada.
    // Exemplo:
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
        backgroundColor: Color(0xFF0C2172),
        toolbarHeight: 4.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
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
                      padding: EdgeInsets.only(right: 0.0), // Espaço de 20 unidades à direita
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


