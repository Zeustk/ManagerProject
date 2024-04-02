import 'package:flutter/material.dart';
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
                text: 'Welcome to project manager',
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
              child: GestureDetector(
                onDoubleTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 25),
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Text(
                        'Lets start',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
