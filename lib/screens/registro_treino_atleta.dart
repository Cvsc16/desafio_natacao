import 'package:desafio6etapa/screens/cronometro.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistroTreinoAtleta extends StatefulWidget {
  @override
  _RegistroTreinoAtletaState createState() => _RegistroTreinoAtletaState();
}

class _RegistroTreinoAtletaState extends State<RegistroTreinoAtleta> {
  TextEditingController _dataTreinoController = TextEditingController();
  List<Map<String, dynamic>> atletasList = [];
  String? selectedAtleta;
  String? estiloTreino;

  bool isButtonEnabled() {
    return selectedAtleta != null && selectedAtleta != "" && estiloTreino != null && estiloTreino != "";
  }

  @override
  void initState() {
    super.initState();
    DateTime dataAtual = DateTime.now();
    String dataAtualFormatada =
        '${dataAtual.day}/${dataAtual.month.toString().padLeft(2, '0')}/${dataAtual.year.toString().padLeft(2, '0')}';

    _dataTreinoController.text = dataAtualFormatada;
    _getAtletas(); // Chama a função para obter a lista de atletas
  }

  Future<void> _getAtletas() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('atletas')
        .where('situacao_atleta', isEqualTo: 'habilitado')
        .get();

    setState(() {
      atletasList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return data;
      }).toList();
    });
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
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                icon: SvgPicture.asset('assets/ic_volta.svg'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeAtleta(),
                    ),
                  );
                },
              ),
            ),
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Registrar Treino',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF06113C),
                ),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30 * ffem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40 * ffem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedAtleta,
                        items: atletasList.map<DropdownMenuItem<String>>((atleta) {
                          return DropdownMenuItem<String>(
                            value: atleta['nom_atleta'],
                            child: Text(atleta['nom_atleta']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAtleta = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Atleta',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0C2172),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF0C2172),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF2C2C2E),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF0C2172),
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF0C2172),
                        ),
                        hint: const Text('Selecione'),
                      ),
                      SizedBox(height: 10 * ffem),
                      Row(
                        children: [
                          Expanded(
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Data Treino',
                                labelStyle: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF0C2172),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2C2C2E),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0C2172),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                _dataTreinoController.text,
                                style: const TextStyle(
                                  color: Color(0xFF010410),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20 * ffem),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  estiloTreino = value;
                                });
                              },
                              style: const TextStyle(
                                color: Color(0xFF010410),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Estilo',
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
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * ffem),
                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: isButtonEnabled()
                              ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cronometro(
                                  idAtleta: selectedAtleta!,
                                  estiloTreino: estiloTreino!,
                                  dataTreino: _dataTreinoController.text,
                                ),
                              ),
                            );
                          }
                              : null, // Desabilita o botão se não houver atleta ou estilo selecionado
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF0C2172),
                            onPrimary: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Cronômetro',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
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
