import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/Page/home/Principal.dart';
import 'package:manager_proyect/src/ui/auth/Registrarse.dart';

class Login extends StatelessWidget {
  final AuthController _controllerAuth = Get.find();
  final UsuariosController gestionUsuarios = UsuariosController();
  final UsuariosController _gestionUsuarioDb = UsuariosController();
  final ProyectoController gestionProyectos = ProyectoController();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerClave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondomo.gif',
            fit: BoxFit.cover,
          ),
        ),
        AnimatedSize(
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 320,
                    top: 40,
                  ),
                  child: MaterialButton(
                      onPressed: () {
                        Get.to(Principal());
                      },
                      child: Image.asset('assets/back.gif')),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Login.png"),
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Get.to(Registro());
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 40, top: 70),
                                  padding: EdgeInsets.only(left: 3, top: 1),
                                  height: 42,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1), // Borde blanco delgado
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    color: Colors
                                        .transparent, // Fondo transparente
                                    child: const Center(
                                      child: Text(
                                        "Registrarse",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 13, 71, 161)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          _buildEmailField(
                            context,
                          ),
                          const SizedBox(height: 10),
                          _buildPasswordField(
                            context,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60, //
                                child: InkWell(
                                  onTap: () {
                                    Autenticar('GITHUB');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Image.asset('assets/github.gif',
                                        width: 20, height: 30),
                                  ),
                                ),
                              ),
                              SizedBox(height: 70),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 60, //
                                child: InkWell(
                                  onTap: () {
                                    Autenticar('GOOGLE');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.white,
                                    ),
                                    // O cualquier otro tamaño deseado
                                    child: Image.asset('assets/google.gif',
                                        width: 20, height: 30),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 100, top: 20, right: 120),
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                height: 40,
                                color: Colors.white,
                                child: Row(children: [
                                  Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontFamily: AutofillHints.addressCity),
                                  ),
                                  Image.asset(
                                    'assets/siguiente.gif',
                                    height: 32,
                                    width: 32,
                                  ),
                                ]),
                                onPressed: () async {
                                  print(_controllerEmail.text);
                                  UsuarioModel usuarioVeri = UsuarioModel(
                                      idUsuario: 0,
                                      email: _controllerEmail.text,
                                      clave: _controllerClave.text,
                                      idRol: null);

                                  try {
                                    bool resultado = await _gestionUsuarioDb
                                        .verificarUsuario(usuarioVeri);
                                    print(
                                        'El valor del resultado es : $resultado');

                                    if (resultado) {
                                      Get.to(Perfil_Usuario());
                                      UsuarioModel UsuarioConId =
                                          await gestionUsuarios
                                              .getUsuarioPorId(usuarioVeri);
                                      print(UsuarioConId);
                                      gestionProyectos
                                          .cambiarEstadoProyectosMemoriaPorLogin();
                                      _controllerAuth.guardarInfoSesionStorage(
                                          _controllerEmail.text,
                                          _controllerClave.text,
                                          UsuarioConId.idUsuario);
                                    } else {
                                      Get.snackbar(
                                        "Verifique su correo y contraseña",
                                        "Datos incorrectos",
                                        snackPosition: SnackPosition.TOP,
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.white,
                                        colorText: Colors.blue,
                                        borderRadius: 10.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 200.0),
                                      );
                                    }
                                  } catch (error) {
                                    print(
                                        'Ocurrió un error al consultar el usuario: $error');
                                  }
                                }),
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
      ]),
    );
  }

  void Autenticar(String auntenticacion) async {
    bool esCorrecta = false;

    switch (auntenticacion.toUpperCase()) {
      case "GOOGLE":
        esCorrecta = await _controllerAuth.signIn('GOOGLE');
        break;
      case "GITHUB":
        esCorrecta = await _controllerAuth.signIn('GITHUB');
        break;
    }

    print(esCorrecta);

    if (esCorrecta) {
      Get.to(Perfil_Usuario());
    }
  }

  Widget _buildAnimatedImageJump(BuildContext context, String imagePath,
      String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                imagePath,
                width: 34,
                height: 34,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return _buildAnimatedImageJump(
      context,
      'assets/nose.gif',
      'Correo Electronico',
      _controllerEmail,
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return _buildAnimatedImageJump(
      context,
      'assets/clave.gif',
      'Contraseña',
      _controllerClave,
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
