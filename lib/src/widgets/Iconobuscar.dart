import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Botonbuscar extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Botonbuscar> {
  bool _showTextField = false;
  TextEditingController _controller = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _showTextField = !_showTextField;
    });
  }

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
    return Center(
      child: Row(
        children: [
          if (!_showTextField)
            Text(
              'Mis Proyectos',
              style: TextStyle(color: Colors.white),
            ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: _showTextField
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
                : SearchIcon(onTap: _toggleSearch),
          ),
        ],
      ),
    );
  }
}

class SearchIcon extends StatelessWidget {
  final VoidCallback onTap;

  SearchIcon({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
