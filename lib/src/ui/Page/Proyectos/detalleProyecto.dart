import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:manager_proyect/src/domain/controllers/DetallesController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/DetalleProyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/AdicionarUsuarios.dart';

UsuariosController gestionUsuarios = UsuariosController();
List<UsuarioModel> usuariosFiltrados = [];
DetallesController gestionDetalles = DetallesController();

class DetalleProyectoPage extends StatefulWidget {
  @override
  State<DetalleProyectoPage> createState() => _DetalleProyectoPageState();
}

class _DetalleProyectoPageState extends State<DetalleProyectoPage> {
  AuthController gestionAuth = AuthController();
  ProyectoModel proyecto = Get.arguments as ProyectoModel;

  Future<void> cargarUsuarios() async {
    List<UsuarioModel> usuarios =
        await gestionUsuarios.consultarUsuariosPorProyecto(proyecto.idProyecto);

    if (mounted) {
      setState(() {
        usuariosFiltrados = usuarios;
        proyecto = proyecto;
      });
    }
  }

  Future<void> adicionarUsuarios() async {
    List<UsuarioModel> usuariosSeleccionados =
        (await Get.to<List<UsuarioModel>?>(AdicionarUsuariosPage())) ?? [];

    if (usuariosSeleccionados.isNotEmpty) {
      // Filtrar los usuarios que no están en usuariosFiltrados
      List<UsuarioModel> nuevosUsuarios =
          usuariosSeleccionados.where((usuario) {
        return !usuariosFiltrados.contains(usuario);
      }).toList();

      UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();

      for (var usuario in nuevosUsuarios) {
        DetallesModel detalleProyectoUsuario = DetallesModel(
            idDetalle: 0,
            idUsuario: usuario.idUsuario,
            idProyecto: proyecto.idProyecto,
            porcentajeProyecto: 0,
            idLiderProyecto: usuarioActual.idUsuario);

        String resp =
            await gestionDetalles.registrarDetalles(detalleProyectoUsuario);

        print(resp);
        cargarUsuarios();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
              onPressed: adicionarUsuarios,
              icon: Image.asset(
                'assets/agregar.gif',
                width: 50,
                height: 50,
              ),
            ),
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
              icon: Image.asset(
                'assets/eliminar.gif',
                width: 50,
                height: 50,
              ),
            ),
          )
        ],
        title: Text(
          'Información del Proyecto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondoproyecto.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Stack(children: [
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(children: [
                Column(
                  children: [
                    _DetalleProyecto(proyecto: proyecto),
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _DetalleProyecto extends StatefulWidget {
  final ProyectoModel proyecto;

  const _DetalleProyecto({required this.proyecto});

  @override
  State<_DetalleProyecto> createState() => _DetalleProyectoState();
}

class _DetalleProyectoState extends State<_DetalleProyecto> {
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  Future<void> cargarUsuarios() async {
    List<UsuarioModel> usuarios = await gestionUsuarios
        .consultarUsuariosPorProyecto(widget.proyecto.idProyecto);

    if (mounted) {
      setState(() {
        usuariosFiltrados = usuarios;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5),
        width: 420,
        height: 720,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'Lider del proyecto',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/lider.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        '${widget.proyecto.liderProyecto}',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Nombre del Proyecto',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/contrato1.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                          enabled: _isEditing,
                          controller: TextEditingController(
                              text: '${widget.proyecto.nombre}'),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese el nombre',
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                'Fecha de Inicio',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario5.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                          enabled: _isEditing,
                          controller: TextEditingController(
                              text: dateFormat
                                  .format(widget.proyecto.fechaInicio)),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese la fecha de inicio',
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Fecha de Finalizacion',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario6.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                          enabled: _isEditing,
                          controller: TextEditingController(
                              text: dateFormat
                                  .format(widget.proyecto.fechaFinalizacion)),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese la fecha de finalización',
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: _toggleEditing,
              icon: Icon(_isEditing ? Icons.check : Icons.edit),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 340,
              child: Divider(
                color: Colors.white,
              ),
            ),
            Text(
              'Integrates',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuariosFiltrados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Texto con estilo
                            Container(
                              width: 60,
                              child: Text(
                                usuariosFiltrados[index].email,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                                width: 10), // Espacio entre el texto y el botón
                            // Contenedor del botón de eliminación
                            Container(
                              width: 60, // Ancho del contenedor del botón
                              child: InkWell(
                                onTap: () {
                                  gestionDetalles.eliminarUsuarioDeProyecto(
                                    usuariosFiltrados[index].idUsuario,
                                  );
                                  cargarUsuarios();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/eliminar-usuario.gif',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
