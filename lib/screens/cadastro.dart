import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cadastro extends StatefulWidget {
  final String tipoUsuario;

  Cadastro({required this.tipoUsuario});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _cadastrar(String nome, String email, String senha) async {
    try {
      if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
        _exibirToast('Por favor, preencha todos os campos.');
        return;
      }

      if (senha.length < 6) {
        _exibirToast('Escolha uma senha com pelo menos 6 caracteres.');
        return;
      }

      if (!_validarEmail(email)) {
        _exibirToast('Insira um e-mail válido.');
        return;
      }

      // Verificar se o e-mail já está cadastrado
      bool emailExiste = await _verificarEmailExistente(email);
      if (emailExiste) {
        _exibirToast('Este e-mail já está cadastrado. Por favor, use outro e-mail.');
        return;
      }

      String tipoUsuario = widget.tipoUsuario;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      DocumentReference userDocRef = FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid);

      await userDocRef.set({
        'tipoUsuario': tipoUsuario,
        'nome': nome,
        'email': email,
      });

      if (tipoUsuario == 'atleta') {
        await FirebaseFirestore.instance.collection('atletas').doc(userDocRef.id).set({
          'situacao_atleta': "não habilitado",
          'status': "ativa",
          'id_usuario': userDocRef,
          'nom_atleta': nome,
          'dtn_atleta': '',
          'nat_atleta': '',
          'nac_atleta': '',
          'rg_atleta': '',
          'cpf_atleta': '',
          'num_telefone_atleta': '',
          'num_telefone_emergencia': '',
          'sex_atleta': '',
          'end_atleta': '',
          'bai_atleta': '',
          'cep_atleta': '',
          'cid_atleta': '',
          'uf_atleta': '',
          'mae_atleta': '',
          'pai_atleta': '',
          'clb_origem_atleta': '',
          'emp_trabalha_atleta': '',
          'cvm_atleta': '',
          'alg_atleta': '',
          'est_atleta': '',
          'prv_atleta': '',
          'img_atestado_atleta': '',
          'img_rg_atleta': '',
          'img_cpf_atleta': '',
          'img_foto_atleta': '',
          'img_comp_resid_atleta': '',
          'img_regulamento_atleta': '',
        });
      }

      await _enviarEmailConfirmacao(email);

      _exibirToast('Cadastro realizado com sucesso! Um e-mail de confirmação foi enviado para $email.');

      // Navegar para a próxima tela após o cadastro bem-sucedido
      // Aqui você pode decidir para onde redirecionar o usuário
    } catch (e, stackTrace) {
      print('Erro durante o cadastro: $e');
      print('Stack trace: $stackTrace');
    }
  }

// Função para verificar se o e-mail já está cadastrado
  Future<bool> _verificarEmailExistente(String email) async {
    try {
      var result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> _enviarEmailConfirmacao(String email) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      _exibirToast('Erro ao enviar e-mail de confirmação: $e');
    }
  }

  bool _validarEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  void _exibirToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFF0b2d78),
      textColor: Colors.yellow,
      fontSize: 16.0,
    );
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

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
              padding: const EdgeInsets.only(left: 20.0),
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
                  decoration: const BoxDecoration(
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
                    controller: nomeController,
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0C2172),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF2C2C2E),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0C2172),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0C2172),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF2C2C2E),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF0C2172),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    controller: senhaController,
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17*ffem,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0C2172),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2C2C2E), width: 2.0),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C2172), width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF0C2172),
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 40 * ffem),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _cadastrar(
                          nomeController.text,
                          emailController.text,
                          senhaController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0C2172),
                        onPrimary: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
