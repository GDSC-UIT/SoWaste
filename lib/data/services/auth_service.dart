import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _ggSignIn = GoogleSignIn();
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? ggSignInAccount = await _ggSignIn.signIn();
      if (ggSignInAccount != null) {
        final GoogleSignInAuthentication ggSignInAuthen =
            await ggSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: ggSignInAuthen.accessToken,
          idToken: ggSignInAuthen.idToken,
        );
        print("ACCESS TOKEN: " + ggSignInAuthen.accessToken.toString());
        print("ID TOKEN: " + ggSignInAuthen.idToken.toString());
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
