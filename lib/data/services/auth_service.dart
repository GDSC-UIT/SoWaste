import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _ggSignIn = GoogleSignIn();
  static late final String? idToken;
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? ggSignInAccount = await _ggSignIn.signIn();
      if (ggSignInAccount != null) {
        final GoogleSignInAuthentication ggSignInAuthen =
            await ggSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: ggSignInAuthen.accessToken,
          idToken: ggSignInAuthen.idToken,
        );

        // Lấy thông tin người dùng đã xác thực
        // Xác thực với Firebase sử dụng thông tin xác thực của Google
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Lấy thông tin người dùng đã xác thực
        final User? user = userCredential.user;
        idToken = await user!.getIdToken();
        return user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool isLoggedIn() => FirebaseAuth.instance.currentUser != null;
}
