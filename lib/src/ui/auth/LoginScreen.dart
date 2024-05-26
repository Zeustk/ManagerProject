import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
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
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
      ),
      body: AnimatedSize(
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
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
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Get.to(Registro());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 40, top: 100),
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  height: 35,
                                  width: 35,
                                  child: Image.asset(
                                    'assets/git.png',
                                  ),
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
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.blue),
                                    color: Colors.white,
                                  ),
                                  height: 30,
                                  width: 30, // O cualquier otro tamaño deseado
                                  child: Image.asset(
                                    'assets/google.png',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 110, top: 20, right: 110),
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
                                  'assets/proximo.png',
                                  width: 37,
                                  height: 37,
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 200.0),
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
