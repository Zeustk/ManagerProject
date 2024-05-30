import 'package:flutter/material.dart';

class SearchIcon extends StatefulWidget {
  @override
  _SearchIconState createState() => _SearchIconState();
}

class _SearchIconState extends State<SearchIcon> {
  bool _showTextField = false;
  TextEditingController _controller = TextEditingController();

  void _performSearch(String value) {
    // Implementa aquí la lógica de búsqueda
    print('Buscando: $value');
    // Ocultar el TextField después de buscar
    setState(() {
      _showTextField = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showTextField
        ? Container(
            width: 200,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Escribe tu búsqueda aquí',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _performSearch(_controller.text),
                ),
              ),
              onSubmitted: _performSearch,
            ),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                _showTextField = true;
              });
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
