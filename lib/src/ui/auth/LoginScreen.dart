import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/auth/Registrarse.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.help,
              color: Colors.white,
              size: 33,
            ),
          )
        ],
      ),
      body: AnimatedSize(
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Login.png"),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\n\nIniciar Sesión",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Get.to(Registro());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 70, top: 70),
                                padding: EdgeInsets.only(left: 3, top: 3),
                                height: 42,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 1), // Borde blanco delgado
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  color:
                                      Colors.transparent, // Fondo transparente
                                  child: const Center(
                                    child: Text(
                                      "Registrarse",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _buildAnimatedIconJump(
                          context,
                          Icons.alternate_email,
                          "Correo Electrónico",
                        ),
                        const SizedBox(height: 20),
                        _buildAnimatedIconJump(
                          context,
                          Icons.lock,
                          "Contraseña",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 270, top: 50),
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Perfil_Usuario();
                              }));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIconJump(
      BuildContext context, IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: AnimatedIconJump(
              icon: icon,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedIconJump extends StatefulWidget {
  final IconData icon;

  const AnimatedIconJump({Key? key, required this.icon}) : super(key: key);

  @override
  _AnimatedIconJumpState createState() => _AnimatedIconJumpState();
}

class _AnimatedIconJumpState extends State<AnimatedIconJump>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, -_animation.value),
          child: child,
        );
      },
      child: Icon(
        widget.icon,
      ),
    );
  }
}
