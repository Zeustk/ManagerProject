import 'package:flutter/material.dart';
import 'package:login/Page/LoginScreen.dart';
import 'package:login/Page/Principal.dart';
import 'package:login/constante/constantes.dart';

class Registro extends StatelessWidget {
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
                            ))
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 16),
                            child: Icon(
                              Icons.lock,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              hintText: "Contraseña",
                            ),
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
                            decoration: const InputDecoration(
                              hintText: "Confirmar Contraseña",
                            ),
                          )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 280, top: 20),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
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
