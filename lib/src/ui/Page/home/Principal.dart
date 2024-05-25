import 'dart:ffi';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/auth/LoginScreen.dart';
import 'package:manager_proyect/src/widgets/AnimacionIconosPrincipal.dart';

class JumpingButton extends StatefulWidget {
  final VoidCallback onPressed;

  const JumpingButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _JumpingButtonState createState() => _JumpingButtonState();
}

class _JumpingButtonState extends State<JumpingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    );
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 2.0, end: 20.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, -value),
          child: child,
        );
      },
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        height: 50,
        onPressed: widget.onPressed,
        color: Colors.white,
        child: Row(
          children: const [
            Text(
              'Comencemos',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Principal extends StatelessWidget {
  AuthController _controllerAuth = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kSecondaryColor,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Gestor.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(seconds: 2),
                    builder: (context, double opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Bienvenido a Gestor De Proyecto',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white),
                      child: Image.asset(
                        'assets/facebook.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        'assets/x.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        'assets/instagram.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: JumpingButton(
                      onPressed: () {
                        InicioSesionPorStorage();
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void InicioSesionPorStorage() async {
    if (await _controllerAuth.verificarSesionStorage()) {
      Get.to(Perfil_Usuario());
    } else {
      Get.to(Login());
    }
  }
}
