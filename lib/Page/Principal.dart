import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Page/LoginScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Gestor.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Bienvenido a Gestor De Proyecto',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextSpan()
            ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Icon(
                        EvaIcons.twitter,
                        color: Colors.blue[500],
                      )), // Icono de Facebook
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Icon(
                        EvaIcons.facebook,
                        color: Colors.blue[500],
                      )),
                ),
                SizedBox(width: 10),
              ],
            ),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    height: 50,
                    onPressed: () {
                      Get.to(Login());
                    },
                    color: Colors.white,
                    child: const Row(
                      children: [
                        // Espacio entre el icono y el texto
                        Text(
                          'Comencemos',
                          style: TextStyle(
                            color: Colors
                                .blue, // Cambia el color del texto según tus preferencias
                            fontSize:
                                16, // Ajusta el tamaño del texto según tus necesidades
                            // Puedes agregar más propiedades para personalizar el estilo del texto
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
