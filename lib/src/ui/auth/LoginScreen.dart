import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/auth/Registrarse.dart';

class Login extends StatelessWidget {
  final AuthController _controllerAuth = Get.find();
  final UsuariosController _gestionUsuarioDb = UsuariosController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerClave = TextEditingController();

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
                                margin: EdgeInsets.only(left: 40, top: 160),
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
                        const SizedBox(height: 10),
                        _buildAnimatedIconJumpp(
                          context,
                          Icons.lock,
                          "Contraseña",
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
                                  height: 40,
                                  width: 40, // O cualquier otro tamaño deseado
                                  child: Icon(
                                    FontAwesomeIcons.github,
                                    color: Colors.white, // Color del icono
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 70, width: 20),
                            SizedBox(
                              width: 60, //
                              child: InkWell(
                                onTap: () {
                                  // Acción al presionar el botón
                                },
                                child: Container(
                                  height: 40,
                                  width: 40, // O cualquier otro tamaño deseado
                                  child: Icon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white, // Color del icono
                                  ),
                                ),
                              ),
                            ),
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
                                  height: 40,
                                  width: 40, // O cualquier otro tamaño deseado
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white, // Color del icono
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 110, top: 20, right: 90),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 40,
                            color: Colors.white,
                            child: Row(children: [
                              Text(
                                'Iniciar Sesion',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontFamily: AutofillHints.addressCity),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                            ]),
                            onPressed: () {
                              print(_controllerEmail.text);
                              UsuarioModel usuarioVeri = UsuarioModel(
                                  idUsuario: 0,
                                  email: _controllerEmail.text,
                                  clave: _controllerClave.text,
                                  idRol: null);

                              _gestionUsuarioDb
                                  .verificarUsuario(usuarioVeri)
                                  .then((resultado) {
                                print('El valor del resultado es : $resultado');
                                if (resultado) {
                                  Get.to(Perfil_Usuario());
                                  _controllerAuth.guardarInfoSesionStorage(_controllerEmail.text, _controllerClave.text);
                                }
                                else{
                                  Get.snackbar(
                                    "Verifice su correo y contraseña",
                                    "Datos incorrectos",
                                    snackPosition: SnackPosition
                                        .TOP, // Posición del Snackbar en la pantalla
                                    duration: Duration(
                                        seconds: 3), // Duración del Snackbar
                                    backgroundColor: Colors
                                        .white, // Color de fondo del Snackbar
                                    colorText: Colors
                                        .blue, // Color del texto del Snackbar
                                    borderRadius:
                                        10.0, // Radio de borde del Snackbar
                                    margin: EdgeInsets.symmetric(
                                        vertical:
                                            200.0), // Margen vertical del Snackbar
                                  );
                                }
                              }).catchError((error) {
                                print(
                                    'Ocurrió un error de consultar el usuario: $error');
                              });
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
              controller: _controllerEmail,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedIconJumpp(
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
              controller: _controllerClave,
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
