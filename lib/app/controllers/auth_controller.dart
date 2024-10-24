import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Stream untuk mengecek status autentikasi pengguna (login/logout)
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // Method untuk signup menggunakan email dan password
  void signup(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
          title: "Verifikasi email",
          middleText:
              "Kami telah mengirimkan verfikasi ke email $emailAddress.",
          onConfirm: () {
            Get.back(); //close dialog
            Get.back(); //login
          },
          textConfirm: "OK");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Method untuk login
  Future<void> login(String email, String pass) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (credential.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Peringatan !!",
          middleText: "Harap melakukan verifikasi email terlebih dahulu.",
        );
      }
      ;
      // Jika login berhasil, navigasi ke halaman HOME
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "Wrong password provided for that user.",
        );
      } else {
        print('Error: ${e.message}');
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: e.message.toString(),
        );
      }
    }
  }

  // Method untuk logout
  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  // Method untuk mereset password
  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke $email",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
        );
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "Tidak dapat melakukan reset password.");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi kesalahan", middleText: "Email tidak valid");
}
}
}
