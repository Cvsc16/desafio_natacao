import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/registro_treino_atleta.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao_atleta.dart';


class Treino extends StatelessWidget {
  final String id_treino;
  final String tipo_treino;
  final String data_treino;
  final String media_treino;

  Treino({
    required this.id_treino,
    required this.tipo_treino,
    required this.data_treino,
    required this.media_treino,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(height: 15.0),
            Text(
              id_treino,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                tipo_treino,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                media_treino,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                width: 2.0,
                height: 11.0,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(width: 5.0),
            Text(
              data_treino,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          width: 280.0,
          height: 1.0,
          color: const Color(0xFF505050),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class TreinoEspecifico extends StatefulWidget {
  final String userId;


  TreinoEspecifico({
    required this.userId,
  });

  @override
  _TreinoEspecificoState createState() => _TreinoEspecificoState();
}

class _TreinoEspecificoState extends State<TreinoEspecifico> {
  String nomeUsuario = '';
  List<Treino> listaTreinos = [];
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _getNomeUsuario();
    _getTreinosUsuario();
  }

  Future<void> _getNomeUsuario() async {
      var userData = await FirebaseFirestore.instance.collection('usuarios').doc(widget.userId).get();
      setState(() {
        String nomeCompleto = userData.data()?['nome'] ?? '';
        List<String> partesNome = nomeCompleto.split(' ');
        nomeUsuario = partesNome.isNotEmpty ? partesNome[0] : '';
      });
  }

  Future<void> _getTreinosUsuario() async {
      var treinosData = await FirebaseFirestore.instance.collection('treinos')
          .where('idAtleta', isEqualTo: widget.userId)
      // .orderBy('dataTreino', descending: true)
          .get();

      setState(() {
        listaTreinos = treinosData.docs.map((doc) => Treino(
          id_treino: doc.id,
          tipo_treino: doc.data()['estiloTreino'] ?? '',
          data_treino: doc.data()['dataTreino'] ?? '',
          media_treino: doc.data()['tempoTotal'] ?? '',
        )).toList();
      });
  }


  @override
  Widget build(BuildContext context) {
    double alturaContainer = 68.0 * 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C2172),
        toolbarHeight: 4.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(  // Adiciona rolagem à tela
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: SizedBox(
                  width: 24.0,  // Defina a largura desejada
                  height: 24.0,  // Defina a altura desejada
                  child: SvgPicture.asset('assets/ic_volta.svg'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'Registros de',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF06113C),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '$nomeUsuario',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF06113C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Treinos',
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F2F7A),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: alturaContainer, // Altura fixa do container
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2172),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListView.builder(
                  itemCount: listaTreinos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0), // Adiciona espaço à esquerda
                      child: Treino(
                        id_treino: (index + 1).toString(),
                        tipo_treino: listaTreinos[index].tipo_treino,
                        data_treino: listaTreinos[index].data_treino,
                        media_treino: listaTreinos[index].media_treino,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Gráfico de Registros',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F2F7A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0), // Espaço entre os elementos
                  MeuGraficoTreino(userId: widget.userId),
                  const SizedBox(height: 30.0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MeuGraficoTreino extends StatefulWidget {
  final String userId;

  MeuGraficoTreino({Key? key, required this.userId}) : super(key: key);

  @override
  _MeuGraficoTreinoState createState() => _MeuGraficoTreinoState();
}

class _MeuGraficoTreinoState extends State<MeuGraficoTreino> {
  List<FlSpot> todosSpots = [];
  List<FlSpot> spotsAbaixoMedia = [];
  List<FlSpot> spotsAcimaMedia = [];
  double media = 0.0;
  double maxX = 0;
  double maxY = 0;
  double qtdVoltas = 0;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    _fetchDataForLoggedUser();
  }

  void _fetchDataForLoggedUser() {
      _fetchData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        mainData(), // Aqui estamos chamando o método mainData para obter os dados do gráfico
      ),
    );
  }

  void _fetchData(String userId) async {
    FirebaseFirestore.instance
        .collection('treinos')
        .where('idAtleta', isEqualTo: userId)
    // .orderBy('numeroTreino', descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print("Nenhum treino encontrado.");
        return;
      }

      var treinoData = querySnapshot.docs.first.data();
      List<dynamic> tempoVoltas = List.from(treinoData['tempoVoltas']);
      media = _convertToSeconds(treinoData['mediaTempo']);

      todosSpots.clear();
      spotsAbaixoMedia.clear();
      spotsAcimaMedia.clear();

      for (int i = 0; i < tempoVoltas.length; i++) {
        double tempoVolta = _convertToSeconds(tempoVoltas[i]);
        todosSpots.add(FlSpot((i + 1).toDouble(), tempoVolta)); // Adicione 1 ao índice

        if (tempoVolta < media * 0.8) {
          spotsAbaixoMedia.add(FlSpot((i + 1).toDouble(), tempoVolta));
        } else if (tempoVolta > media * 1.2) {
          spotsAcimaMedia.add(FlSpot((i + 1).toDouble(), tempoVolta));
        }
      }

      maxX = todosSpots.isNotEmpty ? todosSpots.map((spot) => spot.x).reduce(math.max) : 10;
      maxY = todosSpots.isNotEmpty ? todosSpots.map((spot) => spot.y).reduce(math.max) : 10;

      qtdVoltas = tempoVoltas.length.toDouble();

      setState(() {});
    }).catchError((error) {
      print("Erro ao buscar dados do treino: $error");
    });
  }

  double _convertToSeconds(String time) {
    List<String> parts = time.split(':');
    double minutes = double.parse(parts[0]);
    double seconds = double.parse(parts[1]);
    return minutes * 60 + seconds;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,

        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Sem títulos no lado direito
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // Sem títulos no topo
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 3),
      ),
      minX: 1,
      maxX: maxX, // Use maxX aqui
      minY: 0,
      maxY: maxY, // Use maxY aqui

      lineBarsData: [
        LineChartBarData(
          spots: todosSpots,
          // Seus pontos de dados
          isCurved: true,
          color: const Color(0xFF0F2F7A),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true, // Mostrar os pontos por padrão
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.amberAccent,
                strokeWidth: 1.5,
                strokeColor: Colors.black,
              );
            },
            checkToShowDot: (spot, barData) {
              return true; // Sempre mostrar os pontos
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF0F2F7A).withOpacity(0.3),
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(1, media),
            FlSpot(qtdVoltas , media),
          ],
          isCurved: false,
          color: Colors.red,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}