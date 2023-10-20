import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/registroTreino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao.dart';

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

class HomeAtleta extends StatefulWidget {
  @override
  _HomeAtletaState createState() => _HomeAtletaState();
}

class _HomeAtletaState extends State<HomeAtleta> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeAtleta()), // Substitua 'Tela1' pela tela que deseja exibir
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistroTreino()), // Substitua 'Tela2' pela tela que deseja exibir
      );
    }

    else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilAtleta()), // Substitua 'Tela2' pela tela que deseja exibir
      );
    }
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
            Text(
              'Meus Tempos',
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F2F7A),
              ),
            ),
            SizedBox(height: 20.0),
            Stack(
              children: [
                Container(
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
                              tipo_treino: 'Nado borboleta - 100m',
                              data_treino: '04/10/2023',
                              tempo_treino: '07:10:65',
                            ),
                            Treino(
                              id_treino: '2',
                              tipo_treino: 'Nado crawl - 50m',
                              data_treino: '05/10/2023',
                              tempo_treino: '08:15:42',
                            ),
                            Treino(
                              id_treino: '3',
                              tipo_treino: 'Nado Borboleta - 100m',
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
            SizedBox(height: 20.0),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Média',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F2F7A),
                      ),
                    ),
                    Spacer(), // Isso fará com que o retângulo ocupe o espaço restante à direita
                    Container(
                      width: 140.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFFE3E3E3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround, // Alinhar os textos horizontalmente no espaço disponível
                        children: [
                          // Valor "50m"
                          Container(
                            width: 36.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color(0xFF0C2172), // Cor azul de seleção
                            ),
                            child: Center(
                              child: Text(
                                '50m',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white, // Texto em branco para indicar seleção
                                ),
                              ),
                            ),
                          ),

                          // Valor "100m"
                          Text(
                            '100m',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F2F7A), // Cor padrão
                            ),
                          ),

                          // Valor "500m"
                          Text(
                            '500m',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F2F7A), // Cor padrão
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Center(
                  child: SvgPicture.asset(
                    'assets/grafico.svg',
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationAtleta(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeAtleta(),
  ));
}
