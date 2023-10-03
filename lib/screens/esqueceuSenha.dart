import 'package:flutter/material.dart';

class EsqueceuSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C2172),
        toolbarHeight: 4.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 40.0, top: 40.0),
          child: IconButton(
            icon: Image.asset('assets/ic_volta.svg'), // Substitua 'assets/ic_volta.png' pelo caminho correto do seu SVG
            onPressed: () {
              Navigator.pop(context); // Navegue de volta para a tela anterior
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img_esqueceuSenha.svg', // Substitua 'assets/img_esqueceuSenha.png' pelo caminho correto do seu SVG
              width: 200.0, // Ajuste o tamanho da imagem conforme necessário
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Esqueceu Sua Senha',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Adicione outros elementos da tela aqui, como campos de entrada de email e botões.
          ],
        ),
      ),
    );
  }
}
