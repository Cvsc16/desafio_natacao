import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/perfil_treinador.dart';
import 'package:desafio6etapa/screens/registro_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/barra_navegacao2.dart';

class Atletas extends StatefulWidget {
  @override
  _AtletasState createState() => _AtletasState();
}

class _AtletasState extends State<Atletas> {
  int _selectedIndex = 1;


  void _onItemTapped(int index) {
    if (index == 0) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeTreinador()),
      );
    } else if (index == 1) {
      // Navegar para a segunda tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Atletas()),
      );
    } else if (index == 2) {
      // Navegar para a segunda tela
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilTreinador()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }


  void _salvar() {

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
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Atletas',
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
                  padding: EdgeInsets.symmetric(horizontal: 20 * ffem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                Icons.search,
                                color: Color(0xFF0C2172),
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
                      SizedBox(height: 20 * ffem),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroAtleta()));
                        },
                        child: Container(
                          height: 90, //
                          decoration: BoxDecoration(
                            color: Color(0xFF0C2172),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Nome do Atleta',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Atleta desde: 08/2020',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(), //
                              SvgPicture.asset(
                                'assets/avancar.svg',
                              ),
                              SizedBox(width: 25),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40 * ffem),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationTreinador(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
