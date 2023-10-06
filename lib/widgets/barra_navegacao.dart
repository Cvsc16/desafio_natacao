import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  CustomBottomNavigation({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Altura desejada para a BottomNavigationBar
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0), // Espaço superior desejado
              child: SvgPicture.asset(
                selectedIndex == 0
                    ? 'assets/inicio_selecionado.svg'
                    : 'assets/inicio.svg',
                width: 19,
                height: 20,
              ),
            ),
            label: '', // Esta propriedade está definida como uma string vazia
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0), // Espaço superior desejado
              child: SvgPicture.asset(
                selectedIndex == 1
                    ? 'assets/perfil_selecionado.svg'
                    : 'assets/perfil.svg',
                width: 19,
                height: 20,
              ),
            ),
            label: '', // Esta propriedade está definida como uma string vazia
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue, // Defina a cor do item selecionado
        onTap: onItemTapped,
      ),
    );
  }
}
