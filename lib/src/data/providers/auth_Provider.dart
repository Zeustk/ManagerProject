import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String clientId = 'a7ebb67da7f9e722b99a';
  final String redirectUri =
      'https://projectmanager-dd4d0.firebaseapp.com/__/auth/handler';
  final String clientSecret = '4ad1f1b5fa9d641afc429707434470c4b2929b4';

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      await signOut(); // Cerrar sesión antes de iniciar sesión con Google

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final String idToken = googleSignInAuthentication.idToken ?? '';

        if (idToken.isNotEmpty) {
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: idToken,
          );

          final UserCredential authResult =
              await _auth.signInWithCredential(credential);
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

  Future<UserCredential?> signInWithGitHub() async {
    try {
      final String url = 'https://github.com/login/oauth/authorize' +
          '?client_id=$clientId&redirect_uri=$redirectUri';

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }

      // Espera a que el usuario regrese de la autenticación de GitHub
      final String currentUrl =
          'https://projectmanager-dd4d0.firebaseapp.com/__/auth/handler'; // Reemplaza 'URL_ACTUAL' con la URL de redirección actual en tu aplicación
      final Uri uri = Uri.parse(currentUrl);
      final String? codigoDeAutorizacion = uri.queryParameters['code'];

      if (codigoDeAutorizacion == null) {
        throw 'Authorization code is null';
      }

      // Intercambia el código de autorización por un token de acceso de GitHub
      final String tokenUrl = 'https://github.com/login/oauth/access_token';
      final http.Response tokenResponse = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'redirect_uri': redirectUri,
          'code': codigoDeAutorizacion,
        },
      );

      final Map<String, dynamic> tokenData = jsonDecode(tokenResponse.body);
      final String accessToken = tokenData['access_token'];

      // Autentica al usuario en Firebase con el token de acceso
      final AuthCredential credential =
          GithubAuthProvider.credential(accessToken);
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      // Retorna el resultado de la autenticación
      return authResult;
    } catch (error) {
      print("Error al iniciar sesión con GitHub: $error");
      return null;
    }
  }

  void guardarInformacionUsuarioStorage(String email, String clave) async {
    
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'clave', value: clave);

// Obtener todos los valores del almacenamiento seguro
    // Map<String, String> allValues = await storage.readAll();
    //print('Contenido del almacenamiento seguro: $allValues');
  }

  Future<bool> verificarSesionUsuarioStorage() async {

    String? email = await _storage.read(key: 'email');
    String? clave = await _storage.read(key: 'clave');

    if (email != null && clave != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> CerrarSesionUsuarioStorage() async {
    // Elimina todos los datos guardados en el almacenamiento seguro
    await _storage.deleteAll();
  }
}
