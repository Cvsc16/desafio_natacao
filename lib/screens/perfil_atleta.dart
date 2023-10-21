import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/informacoes_complementares.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/barra_navegacao_atleta.dart';

class PerfilAtleta extends StatefulWidget {
  @override
  _PerfilAtletaState createState() => _PerfilAtletaState();
}

class _PerfilAtletaState extends State<PerfilAtleta> {
  TextEditingController _rgController = TextEditingController(text: '432525234');


  void _salvar() {

  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeAtleta()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilAtleta()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Logout'),
          content: Text('Tem certeza de que deseja sair?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
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
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.red, // Defina a cor do ícone como vermelho
                ),
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Meu Perfil',
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
                SizedBox(height: 40 * ffem),
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
                          labelText: 'Nome',
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
                      SizedBox(height: 20 * ffem),
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410),
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                      SizedBox(height: 20 * ffem),
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410),
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Data de Nascimento',
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
                      SizedBox(height: 20 * ffem),
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Naturalidade',
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Adicione a lógica para alternar a visibilidade da senha aqui
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      TextField(
                        controller: _rgController,
                        style: TextStyle(
                          color: Color(0xFF010410), // Define a cor do texto digitado
                        ),
                        decoration: InputDecoration(
                          labelText: 'RG',
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
                      SizedBox(height: 20 * ffem),
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410), // Define a cor do texto digitado
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'CPF',
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
                      SizedBox(height: 20 * ffem),
                      GestureDetector(
                        onTap: () {
                          // Navegar para a tela de Informações Complementares
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InformacoesComplementares(),
                            ),
                          );
                        },
                        child: Text(
                          '+ Informações Complementares',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C2172),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _salvar,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0C2172) ,
                            onPrimary: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Salvar Informações',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationAtleta(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
