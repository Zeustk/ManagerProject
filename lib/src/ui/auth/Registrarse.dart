import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class Registro extends StatelessWidget {
  UsuariosController gestionUsuarios = UsuariosController();

  TextEditingController _controllerCorreo = TextEditingController();
  TextEditingController __controllerClave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/fondoregistrar.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
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
                          "\n\nSing Up",
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    'assets/nose.gif',
                                    width: 34,
                                    height: 34,
                                  ),
                                )),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
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
                              hintText: "Contraseña",
                            ),
                            controller: __controllerClave,
                          )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 16, bottom: 20, top: 20),
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
                              hintText: "Confirmar Contraseña",
                            ),
                            controller: __controllerClave,
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 100, top: 40, right: 100),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
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
                            UsuarioModel usuario = UsuarioModel(
                              idUsuario: 0,
                              email: _controllerCorreo.text,
                              clave: __controllerClave.text,
                              idRol: null,
                            );

                            gestionUsuarios
                                .registrarUsuarios(usuario)
                                .then((resultado) {
                              print(
                                  'El resultado de registrar el usuario es: $resultado');
                              Get.snackbar(
                                'Usuario Creado',
                                'Usuario Creado Exitosamente',
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                              );
                            }).catchError((error) {
                              print(
                                  'Ocurrió un error al registrar el usuarios: $error');
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
