import 'package:flutter/material.dart';


class SearchIcon extends StatelessWidget {
  void _performSearch(BuildContext context) {
    // Implementa aquí la lógica de búsqueda
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Escribe tu búsqueda aquí'),
            onSubmitted: (value) {
              // Lógica para manejar la búsqueda
              Navigator.of(context).pop();
              print('Buscando: $value');
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _performSearch(context);
      },
      child: SizedBox(
        width: 50,
        child: Icon(
          Icons.search,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}