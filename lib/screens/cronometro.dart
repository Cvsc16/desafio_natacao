import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              padding: EdgeInsets.only(top: 0.0),
              child: Text(
                tempo_volta,
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

class Cronometro extends StatefulWidget {
  @override
  _CronometroState createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {

  void _salvar() {
    // Adicione aqui a lógica para efetuar o login
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
            floating: false, // Define se o app bar deve aparecer ao rolar para cima
            pinned: true, // Define se o app bar deve ser fixo no topo quando rolar para baixo
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Centralizar o título
              titlePadding: EdgeInsets.only(top: 8.0), // Adicione o padding no topo do texto
              title: Text(
                'Cronômetro',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF06113C),
                ),
              ),
            ), systemOverlayStyle: SystemUiOverlayStyle.light, // Defina o brilho como light para o texto ficar branco
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50 * ffem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * ffem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          '20:10:23',
                        style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40 * ffem,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C2172),
                          ),
                        textAlign: TextAlign.center, // Centraliza o texto horizontalmente
                      ),
                      SizedBox(height: 30.0),
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
                                SizedBox(height: 20.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Volta(
                                        id_volta: '1',
                                        tempo_volta: '07:10:65',
                                      ),
                                      Volta(
                                        id_volta: '2',
                                        tempo_volta: '07:10:65',
                                      ),
                                      Volta(
                                        id_volta: '3',
                                        tempo_volta: '07:10:65',
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

                      SizedBox(height: 30.0),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Frequência Cardiaca',
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
                              style: TextStyle(
                                color: Color(0xFF010410),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Inicial',
                                labelStyle: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 17 * ffem,
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
                            ),
                          ),
                          SizedBox(width: 20 * ffem), // Espaço entre os campos
                          Expanded(
                            child: TextField(
                              style: TextStyle(

                                color: Color(0xFF010410),
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Final',
                                labelStyle: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 17 * ffem,
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
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _salvar,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0C2172) ,
                            onPrimary: Colors.yellow ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Registrar Volta',
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
                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              fixedSize: Size(150, 50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Parar',
                                style: TextStyle(
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20 * ffem),
                          ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              fixedSize: Size(150, 50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Retomar',
                                style: TextStyle(
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _salvar, // Chama a função ao clicar no botão
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow , // Cor de fundo amarela
                            onPrimary: Color(0xFF0C2172) , // Cor do texto "#0C2172"
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0), // Raio da borda de 50
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Registrar Treino',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
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
