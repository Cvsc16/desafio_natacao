import 'package:desafio6etapa/screens/home_adm.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/usuarios_consulta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/barra_navegacao_adm.dart';

class ConsultarUsuarios extends StatefulWidget {
  @override
  _ConsultarUsuariosState createState() => _ConsultarUsuariosState();
}

class _ConsultarUsuariosState extends State<ConsultarUsuarios> {

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
            leading: IconButton(
              icon: SizedBox(
                width: 24.0,  // Defina a largura desejada
                height: 24.0,  // Defina a altura desejada
                child: SvgPicture.asset('assets/ic_volta.svg'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            floating: false,
            pinned: true,
            centerTitle: true,
            title: const Text(
              'Usuários',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF06113C),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsuariosConsulta(tipoUsuario: "atleta")));
                  },
                  child: Container(
                    height: 180.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
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
                      const Text(
                        'Atleta',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
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
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsuariosConsulta(tipoUsuario: "treinador")));
                  },
                  child: Container(
                    height: 180.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
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
                      const Text(
                        'Treinador',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
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
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsuariosConsulta(tipoUsuario: "administrador")));
                  },
                  child: Container(
                    height: 180.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
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
                      const Text(
                        'Administrador',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/barra.svg',
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
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
