import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio6etapa/screens/home_atleta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/barra_navegacao_atleta.dart';

class InformacoesComplementares extends StatefulWidget {
  @override
  _InformacoesComplementaresState createState() => _InformacoesComplementaresState();
}

class _InformacoesComplementaresState extends State<InformacoesComplementares> {
  TextEditingController _rgController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _nomeMaeController = TextEditingController();
  TextEditingController _nomePaiController = TextEditingController();
  TextEditingController _clubeOrigemController = TextEditingController();
  TextEditingController _empresaController = TextEditingController();
  TextEditingController _alergiaMedicamentosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obterIDUsuario();
  }

  String? _userID;

  Future<void> _obterIDUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _userID = user.uid;
      });
    }
  }

  void _salvar() {
    // Verifique se o ID do usuário foi obtido
    if (_userID == null) {
      // Se o ID do usuário não estiver disponível, exiba uma mensagem de erro
      _exibirToast('Erro ao obter ID do usuário.');
      return;
    }

    // Recupere os valores dos campos
    String rg = _rgController.text;
    String cpf = _cpfController.text;
    String dataNascimento = _dataNascimentoController.text;

    // Realize as verificações necessárias
    if (rg.isEmpty || cpf.isEmpty || dataNascimento.isEmpty) {
      // Se algum dos campos obrigatórios estiver vazio, exiba uma mensagem de erro
      _exibirToast('Preencha todos os campos obrigatórios.');
      return;
    }

    // Verifique se os campos não obrigatórios estão preenchidos
    String nomeMae = _nomeMaeController.text;
    String nomePai = _nomePaiController.text;
    String clubeOrigem = _clubeOrigemController.text;
    String empresa = _empresaController.text;
    String alergiaMedicamentos = _alergiaMedicamentosController.text;

    // Salve os dados no Firestore
    _salvarNoFirestore(
      _userID!,
      rg,
      cpf,
      dataNascimento,
      nomeMae,
      nomePai,
      clubeOrigem,
      empresa,
      alergiaMedicamentos,
    );
  }

  Future<void> _salvarNoFirestore(
      String userID,
      String rg,
      String cpf,
      String dataNascimento,
      String nomeMae,
      String nomePai,
      String clubeOrigem,
      String empresa,
      String alergiaMedicamentos,
      ) async {
    // Atualize os dados no Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(_userID).get();
    FirebaseFirestore.instance.collection('atletas').doc(userID).update({
      'id_usuario': _userID,
      'nom_atleta': '...',
      'dtn_atleta': '...',
      'nat_atleta': '...',
      'nac_atleta': '...',
      'rg_atleta': '...',
      'cpf_atleta': '...',
      'num_telefone_atleta': '...',
      'num_telefone_emergencia': '...',
      'sex_atleta': '...',
      'end_atleta': '...',
      'bai_atleta': '...',
      'cep_atleta': '...',
      'cid_atleta': '...',
      'uf_atleta': '...',
      'mae_atleta': '...',
      'pai_atleta': '...',
      'clb_origem_atleta': '...',
      'emp_trabalha_atleta': '...',
      'cvm_atleta': '...',
      'alg_atleta': '...',
      'est_atleta': '...',
      'prv_atleta': '...',
      'img_atestado_atleta': '...',
      'img_rg_atleta': '...',
      'img_cpf_atleta': '...',
      'img_foto_atleta': '...',
      'img_comp_resid_atleta': '...',
      'img_regulamento_atleta': '...',
    });

    // Exiba uma mensagem de sucesso
    _exibirToast('Informações atualizadas com sucesso.');
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
              centerTitle: true, // Centralizar o título
              titlePadding: EdgeInsets.only(top: 8.0),
              title: Text(
                'Informações Adicionais',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
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
                          color: Color(0xFF010410),
                        ),
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
                          labelText: 'Nacionalidade',
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
                          labelText: 'Sexo',
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
                        decoration: InputDecoration(
                          labelText: 'Endereço',
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
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * ffem),
                      TextField(
                        style: TextStyle(
                          color: Color(0xFF010410),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Bairro',
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
                          labelText: 'CEP',
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
                          labelText: 'Cidade',
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
                          labelText: 'UF',
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
                          labelText: 'Nome da mãe',
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
                          labelText: 'Nome do pai',
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
                          labelText: 'CLube de Origem',
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
                          labelText: 'Empresa',
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
                          labelText: 'Convênio médico',
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
                          labelText: 'Alergia à medicamentos',
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
                          labelText: 'Estilos',
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
                          labelText: 'Provas',
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
                      SizedBox(height: 40 * ffem),
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
