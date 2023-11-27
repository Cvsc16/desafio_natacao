import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:desafio6etapa/screens/informacoes_complementares.dart';
import 'package:desafio6etapa/screens/login.dart';
import 'package:desafio6etapa/screens/registro_atleta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/barra_navegacao_atleta.dart';

class PerfilAtleta extends StatefulWidget {
  @override
  _PerfilAtletaState createState() => _PerfilAtletaState();

}
final FirebaseAuth _auth = FirebaseAuth.instance;

String? _userID;

class _PerfilAtletaState extends State<PerfilAtleta> {
  String _nomeOriginal = '';
  String _emailOriginal = '';
  String _dataNascimentoOriginal = '';
  String _naturalidadeOriginal = '';
  String _nacionalidadeOriginal = '';
  String _rgOriginal = '';
  String _cpflOriginal = '';
  String _sexoOriginal = '';
  String _numTelefoneOriginal = '';
  String _numTelefoneEmergenciaOriginal = '';
  String _enderecoOriginal = '';
  String _bairroOriginal = '';
  String _cepOriginal = '';
  String _cidadeOriginal = '';
  String _ufOriginal = '';
  String _maeAtletaOriginal = '';
  String _paiAtletaOriginal = '';
  String _clubeOriginal = '';
  String _empresaOriginal = '';
  String _convenioOriginal = '';
  String _alergiaOriginal = '';
  String _estilosOriginal = '';
  String _provasOriginal = '';


  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();


  /* Atleta */

  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _naturalidadeController = TextEditingController();
  TextEditingController _nacionalidadeController = TextEditingController();
  TextEditingController _rgController = TextEditingController();
  TextEditingController _cpflController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _obterInfoUsuario();


  }

  void _atualizarEstado() {
    setState(() {
      if (_nomeOriginal.isEmpty) {
        _nomeOriginal = _nomeController.text;
      }

      if (_emailOriginal.isEmpty) {
        _emailOriginal = _emailController.text;
      }

      if (_dataNascimentoOriginal.isEmpty) {
        _dataNascimentoOriginal = _dataNascimentoController.text;
      }

      if (_naturalidadeOriginal.isEmpty) {
        _naturalidadeOriginal = _naturalidadeController.text;
      }

      if (_nacionalidadeOriginal.isEmpty) {
        _nacionalidadeOriginal = _nacionalidadeController.text;
      }

      if (_rgOriginal.isEmpty) {
        _rgOriginal = _rgController.text;
      }

      if (_cpflOriginal.isEmpty) {
        _cpflOriginal = _cpflController.text;
      }

      if (_sexoOriginal.isEmpty) {
        _sexoOriginal = _sexoController.text;
      }

      if (_numTelefoneOriginal.isEmpty) {
        _numTelefoneOriginal = _numTelefoneController.text;
      }

      if (_numTelefoneEmergenciaOriginal.isEmpty) {
        _numTelefoneEmergenciaOriginal = _numTelefoneEmergenciaController.text;
      }

      if (_enderecoOriginal.isEmpty) {
        _enderecoOriginal = _enderecoController.text;
      }

      if (_bairroOriginal.isEmpty) {
        _bairroOriginal = _bairroController.text;
      }

      if (_cepOriginal.isEmpty) {
        _cepOriginal = _cepController.text;
      }

      if (_cidadeOriginal.isEmpty) {
        _cidadeOriginal = _cidadeController.text;
      }

      if (_ufOriginal.isEmpty) {
        _ufOriginal = _ufController.text;
      }

      if (_maeAtletaOriginal.isEmpty) {
        _maeAtletaOriginal = _maeAtletaController.text;
      }

      if (_paiAtletaOriginal.isEmpty) {
        _paiAtletaOriginal = _paiAtletaController.text;
      }

      if (_clubeOriginal.isEmpty) {
        _clubeOriginal = _clubeController.text;
      }

      if (_empresaOriginal.isEmpty) {
        _empresaOriginal = _empresaController.text;
      }

      if (_convenioOriginal.isEmpty) {
        _convenioOriginal = _convenioController.text;
      }

      if (_alergiaOriginal.isEmpty) {
        _alergiaOriginal = _alergiaController.text;
      }

      if (_estilosOriginal.isEmpty) {
        _estilosOriginal = _estilosController.text;
      }

      if (_provasOriginal.isEmpty) {
        _provasOriginal = _provasController.text;
      }

    });
  }

  Future<void> _obterInfoUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _userID = user.uid;
      });

      // Obter a referência do documento do usuário no Firestore
      DocumentSnapshot DocUsuario = await FirebaseFirestore.instance.collection('usuarios').doc(_userID).get();
      DocumentSnapshot DocAtleta = await FirebaseFirestore.instance.collection('atletas').doc(_userID).get();


      // Verificar se o documento existe antes de acessar os dados
      if (DocUsuario.exists && DocAtleta.exists) {
        // Obter os dados do documento do usuário
        Map<String, dynamic> userData = DocUsuario.data() as Map<String, dynamic>;

        // Atualizar os controladores dos campos com os dados do usuário
        _nomeController.text = userData['nome'] ?? '';
        _emailController.text = userData['email'] ?? '';

        Map<String, dynamic> atletaData = DocAtleta.data() as Map<String, dynamic>;

        _nomeController.text = atletaData['nom_atleta'] ?? '';
        _dataNascimentoController.text = atletaData['dtn_atleta'] ?? '';
        _naturalidadeController.text = atletaData['nat_atleta'] ?? '';
        _nacionalidadeController.text = atletaData['nac_atleta'] ?? '';
        _rgController.text = atletaData['rg_atleta'] ?? '';
        _cpflController.text = atletaData['cpf_atleta'] ?? '';
        _numTelefoneController.text = atletaData['num_telefone_atleta'] ?? '';
        _numTelefoneEmergenciaController.text = atletaData['num_telefone_emergencia'] ?? '';
        _sexoController.text = atletaData['sex_atleta'] ?? '';
        _enderecoController.text = atletaData['end_atleta'] ?? '';
        _bairroController.text = atletaData['bai_atleta'] ?? '';
        _cepController.text = atletaData['cep_atleta'] ?? '';
        _cidadeController.text = atletaData['cid_atleta'] ?? '';
        _ufController.text = atletaData['uf_atleta'] ?? '';
        _maeAtletaController.text = atletaData['mae_atleta'] ?? '';
        _paiAtletaController.text = atletaData['pai_atleta'] ?? '';
        _clubeController.text = atletaData['clb_origem_atleta'] ?? '';
        _empresaController.text = atletaData['emp_trabalha_atleta'] ?? '';
        _convenioController.text = atletaData['cvm_atleta'] ?? '';
        _alergiaController.text = atletaData['alg_atleta'] ?? '';
        _estilosController.text = atletaData['est_atleta'] ?? '';
        _provasController.text = atletaData['prv_atleta'] ?? '';

        _atualizarEstado();
      }
    }
  }

  Future<void> _atualizarPerfil() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {

        if (_nomeController.text.isEmpty ||
            _emailController.text.isEmpty ||
            _dataNascimentoController.text.isEmpty ||
            _naturalidadeController.text.isEmpty ||
            _nacionalidadeController.text.isEmpty ||
            _rgController.text.isEmpty ||
            _cpflController.text.isEmpty ||
            _numTelefoneController.text.isEmpty ||
            _numTelefoneEmergenciaController.text.isEmpty ||
            _sexoController.text.isEmpty ||
            _enderecoController.text.isEmpty ||
            _bairroController.text.isEmpty ||
            _cepController.text.isEmpty ||
            _cidadeController.text.isEmpty ||
            _ufController.text.isEmpty ||
            _estilosController.text.isEmpty ||
            _provasController.text.isEmpty) {
          _exibirToast('Preencha todos os campos obrigatórios.');
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

        await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update({
          'nome': _nomeController.text,
          'email': _emailController.text,
        });

        // Atualizar dados de autenticação
        await user.updateEmail(_emailController.text);

        await FirebaseFirestore.instance.collection('atletas').doc(user.uid).update({
          'nom_atleta': _nomeController.text,
          'dtn_atleta': _dataNascimentoController.text,
          'nat_atleta': _naturalidadeController.text,
          'nac_atleta': _nacionalidadeController.text,
          'rg_atleta': _rgController.text,
          'cpf_atleta': _cpflController.text,
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
          'situacao_atleta': "habilitado",
        });

        // Atualizar o estado após a atualização
        _atualizarEstado();

        _exibirToast('Perfil atualizado com sucesso');

        // Desativar o botão novamente após a confirmação
        setState(() {
          _nomeOriginal = _nomeController.text;
          _emailOriginal = _emailController.text;
          _dataNascimentoOriginal = _dataNascimentoController.text;
          _naturalidadeOriginal = _naturalidadeController.text;
          _nacionalidadeOriginal = _nacionalidadeController.text;
          _rgOriginal = _rgController.text;
          _cpflOriginal = _cpflController.text;
          _numTelefoneOriginal = _numTelefoneController.text;
          _numTelefoneEmergenciaOriginal = _numTelefoneEmergenciaController.text;
          _sexoOriginal = _sexoController.text;
          _enderecoOriginal = _enderecoController.text;
          _bairroOriginal = _bairroController.text;
          _cepOriginal = _cepController.text;
          _cidadeOriginal = _cidadeController.text;
          _ufOriginal = _ufController.text;
          _maeAtletaOriginal = _maeAtletaController.text;
          _paiAtletaOriginal = _paiAtletaController.text;
          _clubeOriginal = _clubeController.text;
          _empresaOriginal = _empresaController.text;
          _convenioOriginal = _convenioController.text;
          _alergiaOriginal = _alergiaController.text;
          _estilosOriginal = _estilosController.text;
          _provasOriginal = _provasController.text;
        });
      }
    } catch (e) {
      // Lidar com erros, se houver algum problema durante a atualização
      _exibirToast('Erro durante a atualização do perfil: $e');
    }
  }

  bool _dadosForamAlterados() {
    return _nomeController.text.trim() != _nomeOriginal.trim() ||
        _emailController.text.trim() != _emailOriginal.trim() ||
        _dataNascimentoController.text.trim() != _dataNascimentoOriginal.trim() ||
        _naturalidadeController.text.trim() != _naturalidadeOriginal.trim() ||
        _nacionalidadeController.text.trim() != _nacionalidadeOriginal.trim() ||
        _rgController.text.trim() != _rgOriginal.trim() ||
        _cpflController.text.trim() != _cpflOriginal.trim() ||
        _numTelefoneController.text.trim() != _numTelefoneOriginal.trim() ||
        _numTelefoneEmergenciaController.text.trim() != _numTelefoneEmergenciaOriginal.trim() ||
        _sexoController.text.trim() != _sexoOriginal.trim() ||
        _enderecoController.text.trim() != _enderecoOriginal.trim() ||
        _bairroController.text.trim() != _bairroOriginal.trim() ||
        _cepController.text.trim() != _cepOriginal.trim() ||
        _cidadeController.text.trim() != _cidadeOriginal.trim() ||
        _ufController.text.trim() != _ufOriginal.trim() ||
        _maeAtletaController.text.trim() != _maeAtletaOriginal.trim() ||
        _paiAtletaController.text.trim() != _paiAtletaOriginal.trim() ||
        _clubeController.text.trim() != _clubeOriginal.trim() ||
        _empresaController.text.trim() != _empresaOriginal.trim() ||
        _convenioController.text.trim() != _convenioOriginal.trim() ||
        _alergiaController.text.trim() != _alergiaOriginal.trim() ||
        _estilosController.text.trim() != _estilosOriginal.trim() ||
        _provasController.text.trim() != _provasOriginal.trim();
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
        MaterialPageRoute(builder: (context) => RegistroAtleta()),
      );
    }

    else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PerfilAtleta()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navegue para a tela de login ou qualquer outra tela desejada após o logout
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print('Erro durante o logout: $e');
      // Lidar com erros, se necessário
    }
  }

// ...

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Tem certeza de que deseja sair da conta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(context); // Chama o método para fazer logout
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _verificarEmailExistente(String email) async {
    try {
      var result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      return false;
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
      backgroundColor: const Color(0xFF0b2d78),
      textColor: Colors.yellow,
      fontSize: 16.0,
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
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red, // Defina a cor do ícone como vermelho
                ),
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
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
                        controller: _nomeController,
                        onChanged: (value) {
                          _atualizarEstado();
                          setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                        },
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
                        onChanged: (value) {
                          _atualizarEstado();
                          setState(() {}); // Isso força a reconstrução do widget quando os dados são alterados
                        },
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
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        obscureText: true,
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
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        obscureText: true,
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
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Telefone 2',
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
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      TextField(
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
                        style: const TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'CLube de Origem',
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
                      SizedBox(height: 40 * ffem),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: _dadosForamAlterados() ? _atualizarPerfil : null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: _dadosForamAlterados() ? const Color(0xFF0C2172) : Colors.grey, // Altera a cor de fundo para cinza quando desativado
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                      SizedBox(height: 40 * ffem),
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
