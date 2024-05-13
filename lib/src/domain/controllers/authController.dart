import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/auth_Provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/auth/LoginScreen.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  Future<bool> signIn(String Autenticacion) async {
    try {
      late final user;

      switch (Autenticacion.toUpperCase()) {
        case "GOOGLE":
          user = await _authService.signInWithGoogle();
          break;
        case "GITHUB":
          user = await _authService.signInWithGitHub();
          break;
      }

      if (user != null) {
        // El usuario ha iniciado sesión exitosamente, puedes redirigir a otra pantalla o realizar otras acciones necesarias.
        return true;
      } else {
        // Manejar el caso en el que el usuario no haya iniciado sesión correctamente.
        return false;
      }
    } catch (error) {
      // Manejar errores, como mostrar un mensaje al usuario.
      print("Error al iniciar sesión con Google: $error");
      return false;
    }
  }

  void guardarInfoSesionStorage(String email, String clave){

    try{

      _authService.guardarInformacionUsuarioStorage(email, clave);
      
    }catch(error){

      print('Error de guardar sesion $error');
    }

  }

  Future<bool> verificarSesionStorage() async {

    try{

      return _authService.verificarSesionUsuarioStorage();

    }catch(error){
      print('error de verificar sesion: $error');
      return false;
    }

  }

  void CerrarSesionStorage(){
    
    _authService.CerrarSesionUsuarioStorage();

  }

  


}
