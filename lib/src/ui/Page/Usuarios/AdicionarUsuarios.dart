import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';

class AdicionarUsuariosPage extends StatefulWidget {
  @override
  _AdicionarUsuariosPageState createState() => _AdicionarUsuariosPageState();
}

class _AdicionarUsuariosPageState extends State<AdicionarUsuariosPage> {
  UsuariosController gestionUsuarios = UsuariosController();
  AuthController gestionAuth= AuthController();
  List<UsuarioModel> listaIntegrantes = [];
  List<UsuarioModel> listaIntegrantesFiltrados = [];
  List<UsuarioModel> integrantesSeleccionados = [];

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
   
  }


  Future<void> cargarUsuarios() async {

     UsuarioModel usuarioActual= await gestionAuth.obtenerDatosDeStorage();

    gestionUsuarios.consultarUsuario().then((data) {
      setState(() {
        listaIntegrantes = data.where((usuario) => usuario.email != usuarioActual.email).toList();
        listaIntegrantesFiltrados = listaIntegrantes.take(4).toList();
      });
    });

  }

  void filtrarIntegrantes(String query) {
    if (query.isEmpty) {
      setState(() {
        listaIntegrantesFiltrados = integrantesSeleccionados.take(4).toList();
      });
    } else {
      setState(() {
        listaIntegrantesFiltrados = listaIntegrantes
            .where((usuario) {
              return usuario.email
                  .toLowerCase()
                  .startsWith(query.toLowerCase());
            })
            .take(4)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
        title: Text('Adicionar Integrantes',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filtrarIntegrantes(value);
              },
              decoration: InputDecoration(
                hintText: 'Buscar integrantes...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaIntegrantesFiltrados.length,
              itemBuilder: (context, index) {
                final usuario = listaIntegrantesFiltrados[index];
                final isSelected = integrantesSeleccionados.contains(usuario);
                return ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.white),
                  title: Text(usuario.email,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(usuario.email,
                      style: TextStyle(color: Colors.white)),
                  trailing: Checkbox(
                    activeColor: Colors.white,
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          integrantesSeleccionados.add(usuario);
                        } else {
                          integrantesSeleccionados.remove(usuario);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // Aquí puedes utilizar integrantesSeleccionados como desees
          print('Integrantes seleccionados: $integrantesSeleccionados');

          Get.back(result: integrantesSeleccionados);
        },
        child: Icon(
          Icons.check,
          color: Colors.blue,
          size: 30,
        ),
      ),
    );
  }
}
