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
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showTextField = !_showTextField;
      if (!_showTextField) {
        _focusNode.unfocus();
      } else {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  void _hideTextField() {
    if (_showTextField) {
      setState(() {
        _showTextField = false;
        _focusNode.unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideTextField();
      },
      child: Center(
        child: Row(
          children: [
            if (!_showTextField)
              Text(
                'Mis Proyectos',
                style: TextStyle(color: Colors.white),
              ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: _showTextField
                  ? GestureDetector(
                      onTap:
                          () {}, // Evita que el GestureDetector padre oculte el TextField
                      child: Container(
                        width: 200,
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Escribe tu búsqueda aquí',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                widget.onTextChanged(_controller.text);
                              },
                            ),
                          ),
                          onChanged: widget.onTextChanged,
                        ),
                      ),
                    )
                  : SearchIcon(onTap: _toggleSearch),
            ),
          ],
        ),
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
