import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manager_proyect/src/constante/constantes.dart';

import 'package:manager_proyect/src/domain/controllers/DetallesController.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
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
  Map<String, dynamic> datos = Get.arguments;
  ProyectoController gestionProyectos = ProyectoController();
  ProyectoModel proyecto = ProyectoModel(
      liderProyecto: "sddads",
      nombre: "asdadsa",
      fechaInicio: DateTime.now(),
      fechaFinalizacion: DateTime.now(),
      descripcion: "asdasd",
      porcentajeProyecto: 30);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatosProyecto();
  }

  void cargarDatosProyecto() {
    ProyectoModel proyectoInfo = ProyectoModel(
      liderProyecto: datos["Lider_Proyecto"],
      nombre: datos["Nombre"],
      fechaInicio: datos["Fecha_Inicio"],
      fechaFinalizacion: datos["Fecha_Finalizacion"],
      descripcion: datos["Descripcion"],
      porcentajeProyecto: datos["Porcentaje_Proyecto"],
      idProyecto: datos["Id_Proyecto"],
      idEstado: datos["Id_Estado"],
    );

    setState(() {
      proyecto = proyectoInfo;
    });
  }

  void _showConfirmationDialog(BuildContext context, int idProyecto) {
    bool siUsuarioEsLider = datos["Id_LiderProyecto"];

    if (siUsuarioEsLider) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kSecondaryColor,
            title: Text('Confirmar Eliminación'),
            content: Text('¿Estás seguro de que deseas eliminar este Proyecto?',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Eliminar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _eliminarProyecto(context, idProyecto);
                },
              ),
            ],
          );
        },
      );
    } else {
      Get.snackbar(
        'Pemiso Denegado',
        'Solo el Lider del Proyecto Puede Eliminar Proyectos',
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }

  void _eliminarProyecto(BuildContext context, int idProyecto) {
    setState(() {
      gestionProyectos.eliminarProyecto(idProyecto);
      gestionProyectos.cambiarEstadoProyectosMemoria();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido eliminado')),
    );
  }

  //          "Id_LiderProyecto": esLiderProyecto(proyecto.idProyecto),

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
    bool esLiderProyecto = datos["Id_LiderProyecto"];

    if (esLiderProyecto) {
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
              idLiderProyecto: usuarioActual.idUsuario);

          String resp =
              await gestionDetalles.registrarDetalles(detalleProyectoUsuario);

          print(resp);
          cargarUsuarios();
        }
      }
    } else {
      Get.snackbar(
        'Pemiso Denegado',
        'Solo el Lider del Proyecto Puede Adicionar Usuarios',
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
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
              onPressed: () {
                _showConfirmationDialog(context, proyecto.idProyecto);
              },
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
  TextEditingController _controllerNombreProyecto = TextEditingController();
  TextEditingController _controllerNombreLiderProyecto =
      TextEditingController();
  TextEditingController _controllerFechaInicio = TextEditingController();
  TextEditingController _controllerFechaFin = TextEditingController();
  ProyectoController gestionProyectos = ProyectoController();
  AuthController gestionAuth= AuthController();

  bool _isEditing = false;
  bool _isEditing2 = false;
  bool _isEditing3 = false;
  void _toggleEditing3() {
    setState(() {
      _isEditing3 = !_isEditing3;
      actualizarProyecto();
    });
  }

  void _toggleEditing2() {
    setState(() {
      _isEditing2 = !_isEditing2;
      actualizarProyecto();
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      actualizarProyecto();
    });
  }

  void actualizarProyecto() async {
    if ((_isEditing==false) || (_isEditing2==false) || (_isEditing3==false)) {

      if (sonDatosDiferentes()) {
        print(_isEditing);
        print(_isEditing2);
        print(_isEditing3);
        ProyectoModel proyectoActualizado = ProyectoModel(
          liderProyecto: widget.proyecto.liderProyecto,
          nombre: _controllerNombreProyecto.text,
          fechaInicio: DateTime.parse(_controllerFechaInicio.text),
          fechaFinalizacion: DateTime.parse(_controllerFechaFin.text),
          descripcion: widget.proyecto.descripcion,
          porcentajeProyecto: widget.proyecto.porcentajeProyecto,
          idProyecto: widget.proyecto.idProyecto,
        );

        String msj =
            await gestionProyectos.actualizarProyecto(proyectoActualizado);
        
        mensaje(msj);

        widget.proyecto.nombre=_controllerNombreProyecto.text;
        widget.proyecto.fechaInicio=DateTime.parse(_controllerFechaInicio.text);
        widget.proyecto.fechaInicio=DateTime.parse(_controllerFechaFin.text);


        
      }
    }
  }

  void mensaje (String msj){

    Get.snackbar(
        'Actualizacion',
        msj,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );

  }

  bool sonDatosDiferentes(){

   

     if ((widget.proyecto.nombre != _controllerNombreProyecto.text) ||
          (DateTime.parse(_controllerFechaInicio.text) !=
                DateTime.parse(widget.proyecto.fechaInicio.toString())) ||
          (DateTime.parse(_controllerFechaFin.text)) !=
             DateTime.parse(widget.proyecto.fechaFinalizacion.toString())){
                return true;
              }
              return false;

  }

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
    cargarDatos();
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

  void cargarDatos() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String fechaFormateadainicio =
        dateFormat.format(widget.proyecto.fechaInicio);
    String fechaFormateadafin =
        dateFormat.format(widget.proyecto.fechaFinalizacion);

    _controllerNombreProyecto.text = widget.proyecto.nombre;
    _controllerNombreLiderProyecto.text = widget.proyecto.liderProyecto;
    _controllerFechaInicio.text = fechaFormateadainicio;
    _controllerFechaFin.text = fechaFormateadafin;
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
                  width: 200,
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
                          controller: _controllerNombreProyecto,
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
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.green, width: 2.0)),
                  child: IconButton(
                    onPressed: _toggleEditing,
                    icon: Image.asset(_isEditing
                        ? 'assets/sucess.gif'
                        : 'assets/editalapiz.gif'),
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
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                          enabled: _isEditing2,
                          controller: _controllerFechaInicio,
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
                SizedBox(width: 15),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.green, width: 2.0)),
                  child: IconButton(
                    onPressed: _toggleEditing2,
                    icon: Image.asset(_isEditing2
                        ? 'assets/sucess.gif'
                        : 'assets/editalapiz.gif'),
                  ),
                )
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
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                          enabled: _isEditing3,
                          controller: _controllerFechaFin,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
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
                SizedBox(width: 15),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.green, width: 2.0)),
                  child: IconButton(
                    onPressed: _toggleEditing3,
                    icon: Image.asset(_isEditing3
                        ? 'assets/sucess.gif'
                        : 'assets/editalapiz.gif'),
                  ),
                )
              ],
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
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Texto con estilo
                            Container(
                              margin: EdgeInsets.only(left: 100),
                              width: 80,
                              child: Text(
                                usuariosFiltrados[index].email,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 10),
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
