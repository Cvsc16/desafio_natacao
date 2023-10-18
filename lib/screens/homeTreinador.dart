import 'package:desafio6etapa/screens/atletas.dart';
import 'package:desafio6etapa/screens/perfilAtleta.dart';
import 'package:desafio6etapa/screens/registroTreino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao2.dart';

class Treino extends StatelessWidget {
  final String id_treino;
  final String tipo_treino;
  final String data_treino;
  final String tempo_treino;

  Treino({
    required this.id_treino,
    required this.tipo_treino,
    required this.data_treino,
    required this.tempo_treino,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              id_treino,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: Text(
                tipo_treino,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                tempo_treino,
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow,
                ),
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Container(
                width: 2.0,
                height: 11.0,
                color: Colors.yellow,
              ),
            ),
            SizedBox(width: 5.0),
            Text(
              data_treino,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: 280.0,
          height: 1.0,
          color: Color(0xFF505050),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class HomeTreinador extends StatefulWidget {
  @override
  _HomeTreinadorState createState() => _HomeTreinadorState();
}

class _HomeTreinadorState extends State<HomeTreinador> {
  int _selectedIndex = 0; // Índice da aba selecionada

  // Método para lidar com a troca de aba
  void _onItemTapped(int index) {
    if (index == 0) {
      // Navegar para a primeira tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeTreinador()), // Substitua 'Tela1' pela tela que deseja exibir
      );
    } else if (index == 1) {
      // Navegar para a segunda tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Atletas()), // Substitua 'Tela2' pela tela que deseja exibir
      );
    } else if (index == 2) {
      // Navegar para a segunda tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilAtleta()), // Substitua 'Tela2' pela tela que deseja exibir
      );
    }
    // Atualize o índice selecionado
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildDropdownItem(String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2060, // Defina a largura desejada
      height: MediaQuery.of(context).size.width * 0.12, // Defina a largura desejada
      decoration: BoxDecoration(
        color: Color(0xFF0F2F7A), // Cor de fundo azul
        borderRadius: BorderRadius.circular(5.0), // Raio da borda de 5
      ),
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.yellow, // Cor da seta amarela
          ),
        ],
      ),
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.0), // Espaço de 20 unidades à direita
                    child: SvgPicture.asset('assets/novo_treino.svg'),
                  ),
                ),
                SizedBox(width: 20.0), // Espaço entre as imagens
                Expanded(
                    child: SvgPicture.asset('assets/novo_atleta.svg'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Melhores da Semana',
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F2F7A),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDropdownItem('Estilo'),
                buildDropdownItem('Sexo'),
                buildDropdownItem('Prova'),
                buildDropdownItem('Período'),
              ],
            ),
            SizedBox(height: 30.0),
            Stack(
              children: [
                Container(
                  width: 320.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C2172),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Treino(
                              id_treino: '1',
                              tipo_treino: 'Carlos Augusto',
                              data_treino: '04/10/2023',
                              tempo_treino: '07:10:65',
                            ),
                            Treino(
                              id_treino: '2',
                              tipo_treino: 'Lucas Santana',
                              data_treino: '05/10/2023',
                              tempo_treino: '08:15:42',
                            ),
                            Treino(
                              id_treino: '3',
                              tipo_treino: 'Thauany Silva',
                              data_treino: '02/10/2023',
                              tempo_treino: '10:15:42',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation2(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeTreinador(),
  ));
}


