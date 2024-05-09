import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/auth_Provider.dart';

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
      print("Error al iniciar sesión con Googles: $error");
      return false;
    }
  }

  // Método para manejar la autenticación con GitHub
}
