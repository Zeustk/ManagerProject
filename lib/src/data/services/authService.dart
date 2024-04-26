import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      await signOut(); // Cerrar sesión antes de iniciar sesión con Google
      
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final String idToken = googleSignInAuthentication.idToken ?? '';
        
        if (idToken.isNotEmpty) {
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: idToken,
          );

          final UserCredential authResult = await _auth.signInWithCredential(credential);
          return authResult.user;
        } else {
          // El token de ID de Google está vacío
          print('El token de ID de Google está vacío');
          return null;
        }
      } else {
        // No se seleccionó ninguna cuenta de Google
        print('No se seleccionó ninguna cuenta de Google');
        return null;
      }
    } catch (error) {
      // Error al iniciar sesión con Google
      print("Error al iniciar sesión con Google: $error");
      return null;
    }
  }
}
