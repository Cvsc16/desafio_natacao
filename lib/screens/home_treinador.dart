import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/atletas.dart';
import 'package:desafio6etapa/screens/cadastro.dart';
import 'package:desafio6etapa/screens/cadastro_atleta.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/perfil_treinador.dart';
import 'package:desafio6etapa/screens/registro_treino_atleta.dart';
import 'package:desafio6etapa/screens/registro_treino_treinador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/barra_navegacao_treinador.dart';

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

class HomeTreinador extends StatefulWidget {
  @override
  _HomeTreinadorState createState() => _HomeTreinadorState();
}

class _HomeTreinadorState extends State<HomeTreinador> {
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
      var userData = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();
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
      var treinosData = await FirebaseFirestore.instance.collection('treinos').get();

      setState(() {
        listaTreinos = treinosData.docs.map((doc) => Treino(
          id_treino: doc.id,
          tipo_treino: doc.data()['estiloTreino'] ?? '',
          data_treino: doc.data()['dataTreino'] ?? '',
          media_treino: doc.data()['tempoTotal'] ?? '',
        )).toList();
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navegar para a primeira tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeTreinador()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Atletas()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilTreinador()),
      );
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildDropdownItem(String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2060,
      // Defina a largura desejada
      height: MediaQuery.of(context).size.width * 0.12,
      // Defina a largura desejada
      decoration: BoxDecoration(
        color: const Color(0xFF0F2F7A), // Cor de fundo azul
        borderRadius: BorderRadius.circular(5.0), // Raio da borda de 5
      ),
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.yellow, // Cor da seta amarela
          ),
        ],
      ),
    );
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
      body: SingleChildScrollView(
        // Adiciona rolagem à tela
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'Olá',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF06113C),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '$nomeUsuario,',
                    style: const TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF06113C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              const Text(
                'Bons treinos!',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF06113C),
                ),
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistroTreinoAtleta()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 00.0),
                        child: SvgPicture.asset('assets/novo_treino.svg'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0), // Espaço entre as imagens
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CadastroAtleta(tipoUsuario: 'atleta')));
                      },
                      child: SvgPicture.asset('assets/novo_atleta.svg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Melhores da Semana',
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F2F7A),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     buildDropdownItem('Estilo'),
              //     buildDropdownItem('Sexo'),
              //     buildDropdownItem('Prova'),
              //     buildDropdownItem('Período'),
              //   ],
              // ),
              const SizedBox(height: 30.0),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C2172),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
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
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationTreinador(
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
