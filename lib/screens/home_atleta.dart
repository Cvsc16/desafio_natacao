import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/registro_treino_atleta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                media_treino,
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

  Future<void> _getTreinosUsuario() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var treinosData = await FirebaseFirestore.instance.collection('treinos')
          .where('idAtleta', isEqualTo: user.uid)
          // .orderBy('dataTreino', descending: true)
          .limit(3)
          .get();

      setState(() {
        listaTreinos = treinosData.docs.map((doc) => Treino(
          id_treino: doc.id,
          tipo_treino: doc.data()['estiloTreino'] ?? '',
          data_treino: doc.data()['dataTreino'] ?? '',
          media_treino: doc.data()['mediaTempo'] ?? '',
        )).toList();
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeAtleta()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistroTreinoAtleta()),
      );
    }

    else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilAtleta()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double alturaContainer = 68.0 * 3;
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
                  '$nomeUsuario,',
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
            Container(
              height: alturaContainer, // Altura fixa do container
              decoration: BoxDecoration(
                color: Color(0xFF0C2172),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListView.builder(
                itemCount: listaTreinos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 20.0), // Adiciona espaço à esquerda
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
                    Spacer(),
                    Container(
                      width: 140.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFFE3E3E3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Valor "50m"
                          Container(
                            width: 36.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color(0xFF0C2172),
                            ),
                            child: Center(
                              child: Text(
                                '50m',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                              color: Color(0xFF0F2F7A),
                            ),
                          ),

                          // Valor "500m"
                          Text(
                            '500m',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F2F7A),
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