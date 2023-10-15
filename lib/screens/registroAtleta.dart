import 'package:desafio6etapa/screens/homeAtleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistroAtleta extends StatefulWidget {
  @override
  _RegistroAtletaState createState() => _RegistroAtletaState();
}

class _RegistroAtletaState extends State<RegistroAtleta> {

  Widget buildDropdownItem(String title) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.28,
      // Defina a largura desejada
      height: MediaQuery
          .of(context)
          .size
          .width * 0.12,
      // Defina a largura desejada
      decoration: BoxDecoration(
        color: Color(0xFF0F2F7A), // Cor de fundo azul
        borderRadius: BorderRadius.circular(5.0), // Raio da borda de 5
      ),
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.yellow, // Cor da seta amarela
          ),
        ],
      ),
    );
  }

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
                'Registro de Atleta',
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
            child: SizedBox(height: 10.0),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDropdownItem('Estilo'),
                  buildDropdownItem('Prova'),
                  buildDropdownItem('Período'),
                ],
              ),
            ),
          ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                Stack(
                  children: [
                    Container(
                      width: 320.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C2172),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Treino(
                                  id_treino: '1',
                                  tipo_treino: 'Nado borboleta - 100m',
                                  data_treino: '04/10/2023',
                                  tempo_treino: '07:10:65',
                                ),
                                Treino(
                                  id_treino: '2',
                                  tipo_treino: 'Nado crawl - 50m',
                                  data_treino: '05/10/2023',
                                  tempo_treino: '08:15:42',
                                ),
                                Treino(
                                  id_treino: '3',
                                  tipo_treino: 'Nado Borboleta - 100m',
                                  data_treino: '02/10/2023',
                                  tempo_treino: '10:15:42',
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
                              Text(
                                '100m',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F2F7A),
                                ),
                              ),
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
                        SizedBox(width: 20.0),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/grafico.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      )
        ],
      ),
    );
  }
}

