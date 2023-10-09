import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _forgotPassword() {
    // Adicione aqui a navegação para a tela de recuperação de senha
    // Por exemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  void _login() {
    // Adicione aqui a lógica para efetuar o login
  }



  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Color(0xFF0b2d78),
      body: SingleChildScrollView(
        child: Stack(
          children: [ // Container com a imagem de fundo principal
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fundo_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height, // Defina a altura para ocupar toda a tela
              width: MediaQuery.of(context).size.width, // Defina a largura para ocupar toda a tela
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cima_fundo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 400*fem,
                width: double.infinity,
              ),
            ),
            // Conteúdo no centro da tela
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40*fem, top: 400*fem),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40*ffem,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20*fem),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40*fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        style: TextStyle(
                          color: Colors.white, // Define a cor do texto digitado
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17*ffem,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF354170), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20*fem),
                      TextField(
                        style: TextStyle(
                          color: Colors.white, // Define a cor do texto digitado
                        ),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 17*ffem,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF354170), width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 30*fem), // Espaço adicional para o texto "Esqueci minha senha"
                      GestureDetector(
                        onTap: _forgotPassword, // Chama a função ao clicar no texto
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13*ffem,
                            fontWeight: FontWeight.w500,
                            color: Colors.yellow,
                          ),
                          textAlign: TextAlign.right, // Alinha o texto à direita
                        ),
                      ),
                      SizedBox(height: 40*fem), // Espaço adicional para o botão "Login"
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _login, // Chama a função ao clicar no botão
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow, // Cor de fundo amarela
                            onPrimary: Color(0xFF0C2172), // Cor do texto "#0C2172"
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0), // Raio da borda de 50
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18*ffem,
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
          ],
        ),
      ),
    );
  }
}
