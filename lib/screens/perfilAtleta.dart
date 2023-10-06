import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerfilAtleta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
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
            expandedHeight: 50.0, // Altura expandida do SliverAppBar
            floating: false, // Define se o app bar deve aparecer ao rolar para cima
            pinned: true, // Define se o app bar deve ser fixo no topo quando rolar para baixo
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Centralizar o título
              titlePadding: EdgeInsets.only(top: 8.0), // Adicione o padding no topo do texto
              title: Text(
                'Meu Perfil',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28.0,
                  color: Color(0xFF06113C),
                ),
              ),
            ),
          ),
          // Outros SliverList, SliverGrid ou SliverToBoxAdapter widgets aqui
        ],
      ),
    );
  }
}
