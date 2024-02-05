import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; // Commented out Facebook authentication
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saferent/state/auth/modesls/auth_result.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut(); // Commented out Facebook logOut
  }

  Future<AuthResult> loginWithFacebook() async {
    // Commented out Facebook login functionality
    // final loginResult = await FacebookAuth.instance.login();
    // final token = loginResult.accessToken?.token;
    //
    // if (token == null) {
    //   return AuthResult.aborted;
    // }
    //
    // final oauthCredentials = FacebookAuthProvider.credential(token);
    //
    // try {
    //   await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
    //   return AuthResult.successs;
    // } on FirebaseAuthException catch (e) {
    //   final email = e.email;
    //   final credential = e.credential;
    //   // Handle exceptions here using Constants
    //   if (e.code == Constants.accExistDiff &&
    //       email != null &&
    //       credential != null) {
    //     final providers =
    //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    //     if (providers.contains(Constants.googlecom)) {
    //       await loginWithGoogle();
    //       FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    //     }
    //     return AuthResult.successs;
    //   }
    //   return AuthResult.failure;
    // }
    return AuthResult.aborted; // Return an appropriate value
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();

    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final GoogleSignInAuthentication googleAuth =
        await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.successs;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
