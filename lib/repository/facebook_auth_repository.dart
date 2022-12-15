import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthRepository {
  final _facebookAuth = FacebookAuth.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();
      final OAuthCredential facebookAtuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _firebaseAuth.signInWithCredential(facebookAtuthCredential);
    } catch (e) {
      throw Exception(e);
    }
  }
}
