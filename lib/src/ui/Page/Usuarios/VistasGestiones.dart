import 'package:flutter/material.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';

class Vista_Proyectos extends StatelessWidget {
  const Vista_Proyectos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
    );
  }
}