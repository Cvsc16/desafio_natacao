import 'package:desafio6etapa/screens/cadastro.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NovoUsuario extends StatefulWidget {
  @override
  _NovoUsuarioState createState() => _NovoUsuarioState();
}

class _NovoUsuarioState extends State<NovoUsuario> {

  void _salvar() {
    // Adicione aqui a lógica para efetuar o login
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
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
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Novo Usuário',
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
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                  },
                  child: Container(
                    height: 180.0,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/fundo_atleta.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 120.0,
                  left: 45.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atleta',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Acompanhe seu desempenho',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Open Sans',
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                  },
                  child: Container(
                    height: 180.0,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/fundo_treinador.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 120.0,
                  left: 45.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Treinador',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Monitore seus atletas',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Open Sans',
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                  },
                  child: Container(
                    height: 180.0,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/fundo_adm.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 120.0,
                  left: 45.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Administrador',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Gerencie o sistema',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Open Sans',
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     SizedBox(height: 20.0),
          //     Container(
          //       margin: EdgeInsets.symmetric(horizontal: 20.0),
          //       child: Align(
          //         alignment: Alignment.centerRight,
          //         child: SizedBox(
          //           width: 150.0,
          //           child: ElevatedButton(
          //             onPressed: _salvar,
          //             style: ElevatedButton.styleFrom(
          //               primary: Color(0xFF0C2172),
          //               onPrimary: Colors.yellow,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(50.0),
          //               ),
          //             ),
          //             child: Padding(
          //               padding: EdgeInsets.all(16.0),
          //               child: Text(
          //                 'Avançar',
          //                 style: TextStyle(
          //                   fontSize: 18 * ffem,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
