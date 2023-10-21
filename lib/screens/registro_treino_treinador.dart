import 'package:desafio6etapa/screens/cronometro.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistroTreinoTreinador extends StatefulWidget {
  @override
  _RegistroTreinoTreinadorState createState() => _RegistroTreinoTreinadorState();
}

class _RegistroTreinoTreinadorState extends State<RegistroTreinoTreinador> {

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
                  // Navegar para a tela HomeAtleta
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeTreinador(),
                    ),
                  );
                },
              ),
            ),
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Centralizar o título
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
            ), systemOverlayStyle: SystemUiOverlayStyle.light,
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
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Atleta',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0C2172),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Color(0xFF0F2F7A),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.search, // Ícone de lupa
                                color: Color(0xFF0C2172), // Cor do ícone
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  color: Color(0xFF010410),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Pesquisar',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF0C2172),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
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
                                labelText: 'Data Treino',
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
                          SizedBox(width: 20 * ffem),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Color(0xFF010410),
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Estilo',
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
                      SizedBox(height: 20 * ffem),

                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Cronometro()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0C2172),
                            onPrimary: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
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
