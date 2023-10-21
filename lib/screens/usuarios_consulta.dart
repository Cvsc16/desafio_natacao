import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/perfil_atleta.dart';
import 'package:desafio6etapa/screens/perfil_treinador.dart';
import 'package:desafio6etapa/screens/perfil_usuarios.dart';
import 'package:desafio6etapa/screens/registro_atleta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsuariosConsulta extends StatefulWidget {
  @override
  _UsuariosConsultaState createState() => _UsuariosConsultaState();
}

class _UsuariosConsultaState extends State<UsuariosConsulta> {


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
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Tipo de Usuário',
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
                            color: Color(0xFF0F2F7A), // Cor da borda
                            width: 1.0, // Tamanho da borda
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
                                  border: InputBorder.none, // Remove a borda padrão do TextField
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilUsuarios()));
                        },
                        child:
                        Container(
                          height: 90, // Altura do retângulo externo
                          decoration: BoxDecoration(
                            color: Color(0xFF0C2172), // Cor de fundo do retângulo externo
                            borderRadius: BorderRadius.circular(10), // Border radius de 10
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60, // Largura da imagem
                                height: 60, // Altura da imagem
                                margin: EdgeInsets.only(left: 15), // Espaço de 15px do início do retângulo e 20px do topo
                                decoration: BoxDecoration(
                                  color: Colors.yellow, // Cor de fundo da imagem
                                  // Aqui você pode adicionar a imagem em vez de uma cor
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20), // Espaço de 20px do topo do retângulo azul
                                  Text(
                                    'Nome do Usuario', // Nome do Atleta
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15 * ffem, // Tamanho da fonte para o nome
                                      fontWeight: FontWeight.bold, // Fonte em negrito para o nome
                                      color: Colors.yellow, // Cor do nome do atleta
                                    ),
                                  ),
                                  SizedBox(height: 15), // Espaço de 15px entre o nome do atleta e o texto "Atleta desde"
                                  Text(
                                    'Cadastrado desde: 2020',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red, // Cor do ícone definida como vermelho
                                ),
                                onPressed: () {
                                  // Adicione a lógica para excluir o item aqui
                                },
                              ),// Isso cria um espaço flexível que empurra o ícone para a direita

                              SizedBox(width: 10), // Espaço adicional entre o ícone de avançar e o botão de excluir
                              SvgPicture.asset(
                                'assets/avancar.svg', // Caminho para o arquivo SVG
                              ),
                              SizedBox(width: 25), // Espaço adicional entre o botão de excluir e a borda direita
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: 40 * ffem), // Espaço adicional para o botão "Login"
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
