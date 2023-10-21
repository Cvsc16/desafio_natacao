import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cadastro extends StatelessWidget {
  void _cadastrar() {
    // Adicione aqui a lógica para efetuar o cadastro
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: Colors.white,
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
            floating: false,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/fundo_cadastro.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  height: 400 * fem,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40 * fem, top: 360 * fem),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cadastro',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40 * ffem,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40 * ffem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20 * ffem),
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
                    decoration: InputDecoration(
                      labelText: 'Data de nascimento',
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
                    ),
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Senha',
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

                  SizedBox(height: 40 * ffem),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                      onPressed: _cadastrar,
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
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * ffem),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
