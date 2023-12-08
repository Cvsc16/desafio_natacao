import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_adm.dart';
import 'package:desafio6etapa/screens/home_treinador.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroAtleta extends StatefulWidget {
  final String tipoUsuario;

  CadastroAtleta({required this.tipoUsuario});

  @override
  _CadastroAtletaState createState() => _CadastroAtletaState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

String? _userID;

class _CadastroAtletaState extends State<CadastroAtleta> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final List<File?> _tempImages = List.filled(6, null);
  final List<String> _caminhosDasImagens = List.filled(6, '');


  final storageRef = FirebaseStorage.instance.ref();


  Future<void> _selecionarImagem(int index, TextEditingController controller) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() {
        _tempImages[index] = File(image.path);
        _caminhosDasImagens[index] = _tempImages[index]!.path;
        controller.text = _caminhosDasImagens[index];
      });

      // // Salvar a imagem no Firebase Storage
      // await _uploadImageToStorage(_tempImages[index]!, index);

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _uploadImageToStorage(File image, int index) async {
    String userName = _nomeController.text;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userFolderRef = storageRef.child("atletas").child(userId);
      String imageName;

      switch (index) {
        case 0:
          imageName = "imgAtestado";
          break;
        case 1:
          imageName = "imgRG";
          break;
        case 2:
          imageName = "imgCPF";
          break;
        case 3:
          imageName = "imgFoto";
          break;
        case 4:
          imageName = "imgCompResidencia";
          break;
        case 5:
          imageName = "imgRegulamento";
          break;
        default:
          imageName = "imgDefault";
      }

      final imageNameWithTimestamp = "$imageName - $userName.text.jpg";
      final imageRef = userFolderRef.child(imageNameWithTimestamp);

      await imageRef.putFile(image);
      final imageUrl = await imageRef.getDownloadURL();

    } on FirebaseException catch (e) {
      print("Erro ao fazer upload da imagem: $e");
    }
  }

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  /* Atleta */

  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _naturalidadeController = TextEditingController();
  TextEditingController _nacionalidadeController = TextEditingController();
  TextEditingController _rgController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();
  TextEditingController _numTelefoneController = TextEditingController();
  TextEditingController _numTelefoneEmergenciaController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _ufController = TextEditingController();
  TextEditingController _maeAtletaController = TextEditingController();
  TextEditingController _paiAtletaController = TextEditingController();
  TextEditingController _clubeController = TextEditingController();
  TextEditingController _empresaController = TextEditingController();
  TextEditingController _convenioController = TextEditingController();
  TextEditingController _alergiaController = TextEditingController();
  TextEditingController _estilosController = TextEditingController();
  TextEditingController _provasController = TextEditingController();

  TextEditingController _img_atestado_atletaController = TextEditingController();
  TextEditingController _img_rg_atletaController = TextEditingController();
  TextEditingController _img_cpf_atletaController = TextEditingController();
  TextEditingController _img_foto_atletaController = TextEditingController();
  TextEditingController _img_comp_resid_atletaController = TextEditingController();
  TextEditingController _img_regulamento_atletaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _Cadastrar() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {

        if (_dadosVazios()) {
          _exibirToast('Preencha todos os campos obrigatórios.');
          return;
        }

        if (_passwordController.text.length < 6) {
          _exibirToast('Escolha uma senha com pelo menos 6 caracteres.');
          return;
        }

        if (!_validarEmail(_emailController.text)) {
          _exibirToast('Insira um e-mail válido.');
          return;
        }

        // Verificar se o e-mail já está cadastrado
        bool emailExiste = await _verificarEmailExistente(_emailController.text);
        if (emailExiste) {
          _exibirToast('Este e-mail já está cadastrado. Por favor, use outro e-mail.');
          return;
        }

        if (_tempImages[0] != null) await _uploadImageToStorage(_tempImages[0]!, 0);
        if (_tempImages[1] != null) await _uploadImageToStorage(_tempImages[1]!, 1);
        if (_tempImages[2] != null) await _uploadImageToStorage(_tempImages[2]!, 2);
        if (_tempImages[3] != null) await _uploadImageToStorage(_tempImages[3]!, 3);
        if (_tempImages[4] != null) await _uploadImageToStorage(_tempImages[4]!, 4);
        if (_tempImages[5] != null) await _uploadImageToStorage(_tempImages[5]!, 5);

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        DocumentReference userDocRef = FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid);
        await userDocRef.set({
          'tipoUsuario': "atleta",
          'nome': _nomeController.text,
          'email': _emailController.text,
        });

        await FirebaseFirestore.instance.collection('atletas').doc(userDocRef.id).set({
          'nom_atleta': _nomeController.text,
          'dtn_atleta': _dataNascimentoController.text,
          'nat_atleta': _naturalidadeController.text,
          'nac_atleta': _nacionalidadeController.text,
          'rg_atleta': _rgController.text,
          'cpf_atleta': _cpfController.text,
          'num_telefone_atleta': _numTelefoneController.text,
          'num_telefone_emergencia': _numTelefoneEmergenciaController.text,
          'sex_atleta': _sexoController.text,
          'end_atleta': _enderecoController.text,
          'bai_atleta': _bairroController.text,
          'cep_atleta': _cepController.text,
          'cid_atleta': _cidadeController.text,
          'uf_atleta': _ufController.text,
          'mae_atleta': _maeAtletaController.text,
          'pai_atleta': _paiAtletaController.text,
          'clb_origem_atleta': _clubeController.text,
          'emp_trabalha_atleta': _empresaController.text,
          'cvm_atleta': _convenioController.text,
          'alg_atleta': _alergiaController.text,
          'est_atleta': _estilosController.text,
          'prv_atleta': _provasController.text,
          'img_atestado_atleta': _img_atestado_atletaController.text,
          'img_rg_atleta': _img_rg_atletaController.text,
          'img_cpf_atleta': _img_cpf_atletaController.text,
          'img_foto_atleta': _img_foto_atletaController.text,
          'img_comp_resid_atleta': _img_comp_resid_atletaController.text,
          'img_regulamento_atleta': _img_regulamento_atletaController.text,
          'situacao_atleta': "habilitado",
        });

        await _enviarEmailConfirmacao(_emailController.text);

        _exibirToast('Cadastro realizado com sucesso! Um e-mail de confirmação foi enviado para $_emailController.text.');

        _navigateBasedOnUserType();
      }
    } catch (e) {
      // Lidar com erros, se houver algum problema durante a atualização
      _exibirToast('Erro durante o cadastro: $e');
    }
  }

  bool _dadosVazios() {
    return _nomeController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _dataNascimentoController.text.isEmpty ||
        _naturalidadeController.text.isEmpty ||
        _nacionalidadeController.text.isEmpty ||
        _rgController.text.isEmpty ||
        _cpfController.text.isEmpty ||
        _numTelefoneController.text.isEmpty ||
        _numTelefoneEmergenciaController.text.isEmpty ||
        _sexoController.text.isEmpty ||
        _enderecoController.text.isEmpty ||
        _bairroController.text.isEmpty ||
        _cepController.text.isEmpty ||
        _cidadeController.text.isEmpty ||
        _ufController.text.isEmpty ||
        _estilosController.text.isEmpty ||
        _provasController.text.isEmpty;
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

  void _navigateBasedOnUserType() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userData = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      String? tipoUsuario = userData.data()?['tipoUsuario'];

      if (tipoUsuario != null) {
        if (tipoUsuario == 'treinador') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeTreinador()),
          );
        } else if (tipoUsuario == 'administrador') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeADM()),
          );
        } else {
          // Tratar caso o tipo de usuário não seja nem 'atleta' nem 'treinador'
          print("Tipo de usuário desconhecido.");
        }
      } else {
        // Tratar caso o campo 'tipoUsuario' não esteja presente
        print("Campo 'tipoUsuario' não encontrado.");
      }
    } else {
      // Tratar caso não haja usuário logado
      print("Nenhum usuário logado.");
    }
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
                  padding: EdgeInsets.only(left: 40 * fem, top: 400 * fem),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cadastro Atleta',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32 * ffem,
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
                    controller: _nomeController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                  SizedBox(height: 20 * ffem),
                  TextField(
                    controller: _rgController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'RG',
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
                    controller: _cpfController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'CPF',
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
                    controller: _dataNascimentoController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Data de nascimento',
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
                    controller: _naturalidadeController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Naturalidade',
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
                    controller: _nacionalidadeController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nacionalidade',
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
                    controller: _sexoController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Sexo',
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
                    controller: _numTelefoneController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Numero do telefone',
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
                    controller: _numTelefoneEmergenciaController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Telefone Emergencial',
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
                    controller: _enderecoController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410), // Define a cor do texto digitado
                    ),
                    decoration: InputDecoration(
                      labelText: 'Endereço',
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
                    controller: _bairroController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Bairro',
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
                    controller: _cepController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'CEP',
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
                    controller: _cidadeController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Cidade',
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
                    controller: _ufController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'UF',
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
                    controller: _maeAtletaController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nome da mãe',
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
                    controller: _paiAtletaController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nome do pai',
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
                    controller: _clubeController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Clube de Origem',
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
                    controller: _empresaController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Empresa',
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
                    controller: _convenioController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Convênio médico',
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
                    controller: _alergiaController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Alergia à medicamentos',
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
                    controller: _estilosController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Estilos',
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
                    controller: _provasController,
                    onChanged: (value) {
                      setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                    },
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Provas',
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
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem atestado',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(0, _img_atestado_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_atestado_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[0] != null)
                        Image.file(
                          _tempImages[0]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[0] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[0] = null;
                              _img_atestado_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem RG',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(1, _img_rg_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_rg_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[1] != null)
                        Image.file(
                          _tempImages[1]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[1] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[1] = null;
                              _img_rg_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem CPF',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(2, _img_cpf_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_cpf_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[2] != null)
                        Image.file(
                          _tempImages[2]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[2] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[2] = null;
                              _img_cpf_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem Foto Usuário',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(3, _img_foto_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_foto_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[3] != null)
                        Image.file(
                          _tempImages[3]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[4] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[4] = null;
                              _img_foto_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem Comprovante de Residência',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(4, _img_comp_resid_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_comp_resid_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[4] != null)
                        Image.file(
                          _tempImages[4]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[4] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[4] = null;
                              _img_comp_resid_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20 * ffem),
                  TextField(
                    style: const TextStyle(
                      color: Color(0xFF010410),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Imagem Regulamento',
                      labelStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0C2172),
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selecionarImagem(5, _img_regulamento_atletaController),
                        child: const Icon(Icons.upload),
                      ),
                    ),
                    readOnly: true,
                    controller: _img_regulamento_atletaController,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_tempImages[5] != null)
                        Image.file(
                          _tempImages[5]!,
                          width: 400.0,
                          height: 300.0, // Defina a altura desejada
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
                        ),
                      if (_tempImages[5] != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tempImages[5] = null;
                              _img_regulamento_atletaController.text = '';
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 40 * ffem),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                      onPressed: _dadosVazios() ? null : () => _Cadastrar(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.yellow,
                        backgroundColor: !_dadosVazios() ? const Color(0xFF0C2172) : Colors.grey,
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
