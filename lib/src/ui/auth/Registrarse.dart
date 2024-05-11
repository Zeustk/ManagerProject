import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Login.png"),
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
                              child: Icon(
                                Icons.alternate_email,
                              ),
                            ),
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
                            child: Icon(
                              Icons.lock,
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
                            child: Icon(
                              Icons.password,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              hintText: "Confirmar Contraseña",
                            ),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 100, top: 40, right: 110),
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
                            UsuarioModel usuario = UsuarioModel(
                              idUsuario: 2,
                              email: _controllerCorreo.text,
                              clave: __controllerClave.text,
                              idRol: null,
                            );

                            gestionUsuarios
                                .registrarUsuarios(usuario)
                                .then((resultado) {
                              print(
                                  'El resultado de registrar el usuario es: $resultado');
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
