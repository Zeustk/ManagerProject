import 'package:get/get.dart';
import 'package:manager_proyect/src/data/services/authService.dart';


class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  Future<bool> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
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
}
