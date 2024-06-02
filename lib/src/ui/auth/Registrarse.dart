import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/Perfiles_Controller.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/models/Perfiles_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/auth/LoginScreen.dart';

class Registro extends StatelessWidget {
  UsuariosController gestionUsuarios = UsuariosController();
  PerfilesController gestionPerfiles = PerfilesController();

  TextEditingController _controllerCorreo = TextEditingController();
  TextEditingController __controllerClave = TextEditingController();
  TextEditingController __controllerClaveConfir = TextEditingController();

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
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 310),
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor:
                        Colors.transparent, // Asegúrate de que no haya sombra
                    elevation: 0, // Asegúrate de que no haya elevación
                  ),
                  label: Text(
                    'Atras',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Image.asset(
                    'assets/back.gif',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Get.to(Login());
                  },
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/fondoregistrar.png"),
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "\n\nRegistrarse",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 11, top: 11),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        'assets/nose.gif',
                                        width: 34,
                                        height: 34,
                                      ),
                                    )),
                                Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "Correo Electronico"),
                                  controller: _controllerCorreo,
                                ))
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, right: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    'assets/clave.gif',
                                    width: 34,
                                    height: 34,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Contraseña",
                                ),
                                controller: __controllerClave,
                                obscureText: true,
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 16, bottom: 20, top: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    'assets/contrasenaregi.gif',
                                    width: 34,
                                    height: 34,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Confirmar Contraseña",
                                ),
                                controller: __controllerClaveConfir,
                                obscureText: true,
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 100, top: 20, right: 110),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blue, width: 1.7),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              color: Colors.white,
                              child: Row(children: [
                                Text(
                                  'Registrarse',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontFamily: AutofillHints.addressCity,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/siguiente.gif',
                                  height: 32,
                                  width: 32,
                                ),
                              ]),
                              onPressed: () {
                                registro(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ]),
    );
  }

  void _register(BuildContext context, UsuarioModel usuario) {
    String password = __controllerClave.text;
    String confirmPassword = __controllerClaveConfir.text;

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Error', style: TextStyle(color: Colors.blue)),
            content: Text('Las contraseñas no coinciden',
                style: TextStyle(color: Colors.blue)),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      gestionUsuarios.registrarUsuarios(usuario).then((resultado) {
        print('El resultado de registrar el usuario es: $resultado');

        PerfilesModel perfil = PerfilesModel();

        gestionPerfiles.registrarPerfil(perfil).then((resultado) {
          print(resultado);
        }).catchError((error) {
          print('Error al registrar perfil $error');
        });

        Get.snackbar(
          'Usuario Creado',
          'Usuario Creado Exitosamente',
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      }).catchError((error) {
        print('Ocurrió un error al registrar el usuario: $error');
      });
    }
  }

  void registro(BuildContext context) {
    UsuarioModel usuario = UsuarioModel(
      idUsuario: 0,
      email: _controllerCorreo.text,
      clave: __controllerClave.text,
      idRol: null,
    );

    _register(context, usuario);
  }

  /* void registro() {  !!!NO BORRAR !!
    UsuarioModel usuario = UsuarioModel(
      idUsuario: 0,
      email: _controllerCorreo.text,
      clave: __controllerClave.text,
      idRol: null,
    );
    print(__controllerClaveConfir.text);

    void _register(BuildContext context) {
      String password = __controllerClave.text;
      String confirmPassword = __controllerClaveConfir.text;

      print(password);
      print(confirmPassword);
      if (password != confirmPassword) {
        // Muestra un AlertDialog si las contraseñas no coinciden
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Las contraseñas no coinciden'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Registrar al usuario si las contraseñas coinciden
        gestionUsuarios.registrarUsuarios(usuario).then((resultado) {
          print('El resultado de registrar el usuario es: $resultado');

          PerfilesModel perfil = PerfilesModel();

          gestionPerfiles.registrarPerfil(perfil).then((resultado) {
            print(resultado);
          }).catchError((error) {
            print('Error al registrar perfil $error');
          });

          Get.snackbar(
            'Usuario Creado',
            'Usuario Creado Exitosamente',
            backgroundColor: Colors.white,
            colorText: Colors.black,
          );
        }).catchError((error) {
          print('Ocurrió un error al registrar el usuario: $error');
        });
      }
    }
  } */
}
