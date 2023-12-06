import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

class Volta extends StatelessWidget {
  final String id_volta;
  final String tempo_volta;

  Volta({
    required this.id_volta,
    required this.tempo_volta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              id_volta,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(width: 5.0),
            const Expanded(
              child: Text(
                'Volta',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                tempo_volta,
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

class Treino extends StatelessWidget {
  final List<String> voltas;
  final int tempoTotal;

  Treino({
    required this.voltas,
    required this.tempoTotal,
  });

  @override
  Widget build(BuildContext context) {
    double containerHeight = 33.0 * 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Text(
          'Tempo Total: ${_formatarTempo(tempoTotal)}',
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            color: Colors.yellow,
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          height: containerHeight,
          child: ListView.builder(
            itemCount: voltas.length,
            reverse: true,
            itemBuilder: (context, index) {
              int adjustedIndex = voltas.length - 1 - index;
              return Volta(
                id_volta: (adjustedIndex + 1).toString(),
                tempo_volta: voltas[adjustedIndex],
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  String _formatarTempo(int milissegundos) {
    int milesimos = (milissegundos / 10).truncate();
    int segundos = (milesimos ~/ 100).truncate();
    int minutos = (segundos ~/ 60).truncate();

    String minutosStr = (minutos % 60).toString().padLeft(2, '0');
    String segundosStr = (segundos % 60).toString().padLeft(2, '0');
    String milesimosStr = (milesimos % 100).toString().padLeft(2, '0');

    return '$minutosStr:$segundosStr.$milesimosStr';
  }
}

class Cronometro extends StatefulWidget {
  final String idAtleta;
  final String estiloTreino;
  final String dataTreino;

  Cronometro({
    required this.idAtleta,
    required this.estiloTreino,
    required this.dataTreino,
  });

  @override
  _CronometroState createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  late Stopwatch cronometro;
  late Stopwatch cronometroGeral;
  late Timer timer;
  bool iniciado = false;
  bool parado = false;
  List<String> voltas = [];
  int tempoTotal = 0;

  final TextEditingController frequenciaInicialController = TextEditingController();
  final TextEditingController frequenciaFinalController = TextEditingController();


  @override
  void initState() {
    super.initState();
    cronometro = Stopwatch();
    cronometroGeral = Stopwatch();
    timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      if (cronometroGeral.elapsed.inMinutes >= 30 && iniciado) {
        _pararCronometro();
      }
      if (iniciado) {
        setState(() {
          tempoTotal = cronometroGeral.elapsedMilliseconds;
        });
      }
    });
  }

  void _iniciarCronometro() {
    setState(() {
      iniciado = true;
      cronometro.start();
      cronometroGeral.start();
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {});
      });
    });
  }

  void _pararCronometro() {
    setState(() {
      timer.cancel();
      cronometro.stop();
      cronometroGeral.stop();
      parado = true;
    });
  }

  void _resetarCronometro() {
    setState(() {
      voltas.clear();
      tempoTotal = 0;
      cronometro.reset();
      cronometroGeral.reset();
      iniciado = false;
      parado = false;
    });
  }

  void _retomarCronometro() {
    setState(() {
      cronometro.start();
      cronometroGeral.start();
      parado = false;
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {});
      });
    });
  }

  void _registrarVolta() {
    setState(() {
      voltas.add(_formatarTempo(cronometro.elapsedMilliseconds));
      cronometro.reset();
    });
  }

  Future<int> _getNumeroTotalTreinos() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('treinos').get();
    return querySnapshot.docs.length;
  }



  void _salvar() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      int numeroTotalTreinos = await _getNumeroTotalTreinos();
      int numeroNovoTreino = numeroTotalTreinos + 1;

      if (frequenciaInicialController.text.isEmpty || frequenciaFinalController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, preencha as frequências cardíacas inicial e final.')),
        );
        return; // Sai do método se algum campo estiver vazio
      }

      if (tempoTotal >= 1) {
        FirebaseFirestore.instance.collection('treinos').add({
          'estiloTreino': widget.estiloTreino,
          'numeroTreino': numeroNovoTreino,
          'idAtleta': widget.idAtleta,
          'dataTreino': widget.dataTreino,
          'frequenciaCardiacaInicio': frequenciaInicialController.text,
          'frequenciaCardiacaFinal': frequenciaFinalController.text,
          'tempoVoltas': voltas,
          'tempoTotal': _formatarTempo(tempoTotal),
          'mediaTempo': _formatarTempo(tempoTotal ~/ voltas.length),
          'metrosUltimaVolta': "",
          'responsavel': userId,
        }).then((docRef) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Treino registrado com sucesso!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeAtleta()),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ocorreu um erro ao registrar o treino: $error')),
          );
        });
      }
    } else {
      _exibirToast("Usuário não logado");
    }
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

  String _formatarTempo(int milissegundos) {
    int milesimos = (milissegundos / 10).truncate();
    int segundos = (milesimos ~/ 100).truncate();
    int minutos = (segundos ~/ 60).truncate();

    String minutosStr = (minutos % 60).toString().padLeft(2, '0');
    String segundosStr = (segundos % 60).toString().padLeft(2, '0');
    String milesimosStr = (milesimos % 100).toString().padLeft(2, '0');

    return '$minutosStr:$segundosStr.$milesimosStr';
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
                  Navigator.pop(context);
                },
              ),
            ),
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Cronômetro',
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
                SizedBox(height: 20 * ffem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * ffem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _formatarTempo(cronometro.elapsedMilliseconds),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 40 * ffem,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0C2172),
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Treino(
                                    voltas: voltas,
                                    tempoTotal: tempoTotal,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30.0),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Frequência Cardíaca',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F2F7A),
                          ),
                        ),
                      ),

                      SizedBox(height: 10 * ffem),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: frequenciaInicialController,
                              style: const TextStyle(
                                color: Color(0xFF010410),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Inicial',
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
                          SizedBox(width: 20 * ffem),
                          Expanded(
                            child: TextField(
                              controller: frequenciaFinalController,
                              style: const TextStyle(
                                color: Color(0xFF010410),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Final',
                                labelStyle: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 17 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0C2172),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: (cronometro.elapsed.inMinutes >= 30 && frequenciaFinalController.text.isEmpty)
                                        ? Colors.red
                                        : const Color(0xFF2C2C2E),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: (cronometro.elapsed.inMinutes >= 30 && frequenciaFinalController.text.isEmpty)
                                        ? Colors.red
                                        : const Color(0xFF0C2172),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: iniciado ? _registrarVolta : _iniciarCronometro,
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
                              iniciado ? 'Registrar Volta' : 'Iniciar',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20 * ffem),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (iniciado)
                            ElevatedButton(
                              onPressed: iniciado ? (parado ? _retomarCronometro : _pararCronometro) : _iniciarCronometro,
                              style: ElevatedButton.styleFrom(
                                primary: parado ? Colors.green : Colors.red,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                fixedSize: const Size(150, 50),
                              ),
                              child: Text(parado ? 'Retomar' : 'Parar'),
                            ),
                          if (parado) SizedBox(width: 20 * ffem),
                          if (parado)
                            ElevatedButton(
                              onPressed: _resetarCronometro,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                fixedSize: const Size(150, 50),
                              ),
                              child: const Text('Resetar'),
                            ),
                        ],
                      ),

                      SizedBox(height: 20 * ffem),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: parado && tempoTotal >= 1 && frequenciaInicialController.text.isNotEmpty && frequenciaFinalController.text.isNotEmpty
                            ? ElevatedButton(
                          onPressed: _salvar,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow,
                            onPrimary: const Color(0xFF0C2172),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Registrar Treino',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            : const SizedBox.shrink(), // Retorna um widget vazio se a condição não for satisfeita
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
