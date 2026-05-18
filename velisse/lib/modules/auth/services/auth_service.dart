/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

library;


/// ===============================================================
/// FIREBASE AUTH
/// ===============================================================

/// Firebase Authentication
///
/// Permite:
/// - registrar usuarios
/// - iniciar sesión
/// - cerrar sesión
/// - obtener usuario actual
import 'package:firebase_auth/firebase_auth.dart';


/// ===============================================================
/// CLOUD FIRESTORE
/// ===============================================================

/// Cloud Firestore
///
/// Permite:
/// - guardar datos
/// - crear colecciones
/// - leer documentos
/// - actualizar información
import 'package:cloud_firestore/cloud_firestore.dart';




/// ===============================================================
/// AUTH SERVICE
/// ===============================================================

/// Esta clase manejará:
///
/// - registro usuarios
/// - login usuarios
/// - Firebase Auth
/// - Firestore
class AuthService {

  /// =============================================================
  /// FIREBASE AUTH INSTANCE
  /// =============================================================

  /// Instancia principal Firebase Authentication
  ///
  /// Con esto podremos:
  /// - crear usuarios
  /// - iniciar sesión
  /// - cerrar sesión
  final FirebaseAuth _auth =
      FirebaseAuth.instance;



  /// =============================================================
  /// FIRESTORE INSTANCE
  /// =============================================================

  /// Instancia principal Firestore
  ///
  /// Con esto podremos:
  /// - guardar datos
  /// - leer colecciones
  /// - crear documentos
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;



  /// =============================================================
  /// REGISTER USER
  /// =============================================================

  /// Método encargado de:
  ///
  /// 1. Crear usuario en Firebase Auth
  /// 2. Obtener UID
  /// 3. Guardar datos en Firestore
  /// 4. Retornar usuario creado
  Future<UserCredential> registerUser({

    /// Nombre usuario
    required String nombre,

    /// Apellido usuario
    required String apellido,

    /// Correo usuario
    required String email,

    /// Teléfono usuario
    required String telefono,

    /// Contraseña usuario
    required String password,

  }) async {

    try {

      /// =========================================================
      /// DEBUG INICIO
      /// =========================================================

      /// Mensaje consola
      ///
      /// para saber si entró al método
      print('INICIANDO REGISTRO');



      /// =========================================================
      /// CREAR USUARIO FIREBASE AUTH
      /// =========================================================

      /// createUserWithEmailAndPassword:
      ///
      /// crea usuario dentro de:
      /// Firebase Authentication
      UserCredential userCredential =
          await _auth
              .createUserWithEmailAndPassword(

            /// Email usuario
            email: email,

            /// Password usuario
            password: password,
          )

              /// Timeout seguridad
              ///
              /// evita quedarse cargando eternamente
              .timeout(
            const Duration(seconds: 15),
          );



      /// =========================================================
      /// DEBUG AUTH EXITOSO
      /// =========================================================

      print('USUARIO CREADO EN AUTH');



      /// =========================================================
      /// OBTENER UID USUARIO
      /// =========================================================

      /// UID:
      ///
      /// identificador único Firebase
      String uid =
          userCredential.user!.uid;



      /// =========================================================
      /// DEBUG UID
      /// =========================================================

      print('UID USUARIO: $uid');



      /// =========================================================
      /// GUARDAR USUARIO EN FIRESTORE
      /// =========================================================

      /// collection('users'):
      ///
      /// crea o usa colección users
      ///
      /// doc(uid):
      ///
      /// crea documento con el UID
      await _firestore
          .collection('users')
          .doc(uid)
          .set({

        /// UID usuario
        'uid': uid,



        /// Nombre usuario
        'nombre': nombre,



        /// Apellido usuario
        'apellido': apellido,



        /// Correo usuario
        'email': email,



        /// Teléfono usuario
        'telefono': telefono,



        /// Rol usuario
        ///
        /// cliente por defecto
        'rol': 'cliente',



        /// Fecha creación
        ///
        /// Timestamp actual
        'createdAt': Timestamp.now(),

      })

          /// Timeout Firestore
          .timeout(
        const Duration(seconds: 10),
      );



      /// =========================================================
      /// DEBUG FIRESTORE EXITOSO
      /// =========================================================

      print('USUARIO GUARDADO EN FIRESTORE');



      /// =========================================================
      /// RETORNAR USUARIO
      /// =========================================================

      return userCredential;

    }



    /// ===========================================================
    /// FIREBASE AUTH ERROR
    /// ===========================================================

    on FirebaseAuthException catch (e) {

      /// Código error
      print('CODIGO ERROR: ${e.code}');



      /// Mensaje error
      print('MENSAJE ERROR: ${e.message}');



      /// Relanzar error
      rethrow;
    }



    /// ===========================================================
    /// ERROR GENERAL
    /// ===========================================================

    catch (e) {

      /// Mostrar error consola
      print('ERROR GENERAL: $e');



      /// Relanzar error
      rethrow;
    }
  }
}