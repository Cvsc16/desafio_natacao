import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationAtleta extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  CustomBottomNavigationAtleta({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, 
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset(
                selectedIndex == 0
                    ? 'assets/inicio_selecionado.svg'
                    : 'assets/inicio.svg',
                width: 19,
                height: 20,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: SvgPicture.asset(
                selectedIndex == 1
                    ? 'assets/cronometro_selecionado.svg'
                    : 'assets/cronometro.svg',
                width: 30,
                height: 30,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset(
                selectedIndex == 2
                    ? 'assets/perfil_selecionado.svg'
                    : 'assets/perfil.svg',
                width: 19,
                height: 20,
              ),
            ),
            label: '',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
