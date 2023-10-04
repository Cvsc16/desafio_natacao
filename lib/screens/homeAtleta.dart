import 'package:flutter/material.dart';

class HomeAtleta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C2172), // Cor da borda superior
        toolbarHeight: 4.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 0.0, 0.0), // Espaçamento à esquerda e superior
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Olá',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF06113C),
                  ),
                ),
                SizedBox(width: 5.0), // Espaçamento entre os textos
                Text(
                  'Sarah,',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600, // Use FontWeight.w600 para negrito
                    color: Color(0xFF06113C),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0), // Espaçamento de 10 pixels abaixo
            Text(
              'Bons treinos!',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                color: Color(0xFF06113C),
              ),
            ),
            SizedBox(height: 25.0), // Espaçamento de 25 pixels abaixo
            Text(
              'Meus Tempos',
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F2F7A),
              ),
            ),
            SizedBox(height: 20.0), // Espaçamento de 20 pixels abaixo

            // Usar um Stack para envolver o retângulo azul e cinza
            Stack(
              children: [
                Container(
                  width: 320.0,
                  alignment: Alignment.center, // Alinhe o retângulo azul
                  decoration: BoxDecoration(
                    color: Color(0xFF0C2172), // Cor do retângulo azul
                    borderRadius: BorderRadius.circular(16.0), // Raio da borda
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.0), // Espaçamento de 18 pixels do topo do retângulo azul
                      Padding(
                        padding: EdgeInsets.only(left: 20.0), // Espaçamento de 20 pixels da esquerda do retângulo azul
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 15.0, // Tamanho do número
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600, // Use FontWeight.w600 para negrito
                                    color: Colors.yellow, // Cor do número
                                  ),
                                ),
                                SizedBox(width: 5.0), // Espaçamento entre o número e o texto
                                Expanded(
                                  child: Text(
                                    'Nado borboleta - 100m',
                                    style: TextStyle(
                                      fontSize: 15.0, // Tamanho do texto
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // Cor do texto
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0), // Espaçamento de 4 pixels abaixo do texto
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0), // Define o espaçamento de 8 pixels em todos os lados do Container
                                  child: Container(
                                    width: 2.0,
                                    height: 11.0,
                                    color: Colors.yellow, // Cor do retângulo amarelo
                                  ),
                                ),
                                SizedBox(width: 5.0), // Espaçamento de 5 pixels à direita do retângulo amarelo
                                Text(
                                  '04/10/2023',
                                  style: TextStyle(
                                    fontSize: 12.0, // Tamanho do texto
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white, // Cor do texto
                                  ),
                                ),
                                SizedBox(width: 140.0),
                                Positioned(
                                  right: 20.0, // Distância da direita do retângulo azul
                                  top: 30.0, // Distância do topo do retângulo azul
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '07:10:65',
                                      style: TextStyle(
                                        fontSize: 13.0, // Tamanho do texto
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.yellow, // Cor do texto
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0), // Espaçamento de 10 pixels abaixo do retângulo azul
                            Container(
                              width: 280.0,
                              height: 1.0, // Altura de 1 pixel
                              color: Color(0xFF505050), // Cor do retângulo cinza

                            ),
                            SizedBox(height: 10.0), // Espaçamento de 10 pixels abaixo do retângulo azul
                          ],
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
