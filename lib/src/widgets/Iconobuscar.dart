import 'package:flutter/material.dart';

class Botonbuscar extends StatefulWidget {
  final Function(String) onTextChanged;

  Botonbuscar({required this.onTextChanged});

  @override
  _BotonbuscarState createState() => _BotonbuscarState();
}

class _BotonbuscarState extends State<Botonbuscar> {
  bool _showTextField = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode(); // Declara el FocusNode

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose del FocusNode
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showTextField = !_showTextField;
      if (!_showTextField) {
        // Si se oculta el campo de texto, quitar el foco
        _focusNode.unfocus();
      } else {
        // Si se muestra el campo de texto, asignar el foco
        FocusScope.of(context).requestFocus(_focusNode);
      }
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
                      focusNode: _focusNode, // Asigna el FocusNode al TextField
                      decoration: InputDecoration(
                        hintText: 'Escribe tu búsqueda aquí',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            widget.onTextChanged(_controller.text);
                          },
                        ),
                      ),
                      onChanged: widget.onTextChanged,
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
