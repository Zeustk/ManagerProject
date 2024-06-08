import 'package:flutter/material.dart';
import 'package:manager_proyect/src/domain/controllers/Perfiles_Controller.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Perfiles_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';

import 'package:manager_proyect/src/widgets/Drawer.dart';

class Perfil_Usuario extends StatefulWidget {
  @override
  State<Perfil_Usuario> createState() => _Perfil_UsuarioState();
}

class _Perfil_UsuarioState extends State<Perfil_Usuario> {
  AuthController gestionAuth = AuthController();
  PerfilesController gestionPerfil = PerfilesController();
  ProyectoController gestionProyectos = ProyectoController();

  UsuarioModel usuarioActual = UsuarioModel();
  PerfilesModel perfilActual = PerfilesModel();
  List<ProyectoModel> proyectos = [];
  bool _isEditing = false;
  TextEditingController _controlleNombre = TextEditingController();
  TextEditingController _controlleCorreo = TextEditingController();
  TextEditingController _controlleClave = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarPerfil();
    _controlleNombre = TextEditingController(
      text: perfilActual.nombreCompleto ?? '',
    );
    _controlleCorreo = TextEditingController(text: usuarioActual.email ?? '');
    _controlleClave = TextEditingController(
      text: usuarioActual.clave = '•' * usuarioActual.clave.length,
    );
  }

  @override
  void dispose() {
    _controlleNombre.dispose();
    _controlleCorreo.dispose();
    _controlleClave.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> cargarPerfil() async {
    try {
      UsuarioModel usuario = await gestionAuth.obtenerDatosDeStorage();
      PerfilesModel perfil = await gestionPerfil.getPerfilPorId(usuario);
      List<ProyectoModel> proyectosList =
          await gestionProyectos.consultarProyectos(usuario.idUsuario);

      if (mounted) {
        setState(() {
          perfilActual = perfil;
          usuarioActual = usuario;
          proyectos = proyectosList;
        });
      }
    } catch (error) {
      print('Error al cargar perfil y proyectos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      drawer: Draweer(),
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [],
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: Text(
              'Mi Perfil',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoproyecto.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(top: 140),
                  height: 60,
                  width: 142,
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          _toggleEditing();
                        },
                        child: Container(
                          width: 110,
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Color.fromARGB(255, 58, 164, 190),
                                  width: 2.5)),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/editarusu.png',
                                width: 30,
                              ),
                              Text('Editar',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 20),
                  padding: EdgeInsets.only(top: 10),
                  width: 100,
                  height: 100,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/perfil2.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Mi Perfil',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
              Row(children: [
                SizedBox(width: 30),
                Text('Nombre',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(width: 70),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 10,
                    width: 100,
                    child: TextField(
                      controller: _controlleNombre,
                      enabled: _isEditing,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ))
              ]),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    SizedBox(width: 30),
                    Text('Correo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 41),
                      margin: EdgeInsets.only(top: 10),
                      width: 308,
                      height: 20,
                      child: TextField(
                        controller: _controlleCorreo,
                        enabled: _isEditing,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text('N# Proyectos',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 35,
                  ),
                  Text(proyectos.length.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text('Estado',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(
                    width: 77,
                  ),
                  Text(
                    perfilActual.estado ? 'Conectado' : 'Desconectado',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text('Pin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 10,
                      width: 100,
                      child: TextField(
                        controller: _controlleClave,
                        enabled: _isEditing,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Mis Proyectos',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: proyectos.length > 6 ? 6 : proyectos.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(width: 30),
                        Text('Proyecto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(proyectos[index].nombre,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
