import 'package:flutter/material.dart';
import 'package:manager_proyect/src/constante/constantes.dart';

class DetalleProyectoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.library_add,
                  color: Colors.green,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.update,
                  color: Colors.amber,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 7),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                )),
          )
        ],
        title: Text(
          'Información del Proyecto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: _DetalleProyecto(),
          ),
        ),
      ),
    );
  }
}

class _DetalleProyecto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'Lider del proyecto',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(
            height: 40,
            width: 230,
            child: Text(
              'hola',
              style: TextStyle(color: Colors.red),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          )
        ],
      ),
    );
  }
}
