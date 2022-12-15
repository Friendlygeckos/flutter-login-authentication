import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithTwitter() async {
    try {
      if (kIsWeb) {
        TwitterAuthProvider twitterAuthProvider = TwitterAuthProvider();
        _firebaseAuth.signInWithPopup(twitterAuthProvider);
      } else {
        final twitterLogin = TwitterLogin(
          apiKey: 'TODO',
          apiSecretKey: 'TODO',
          redirectURI: 'TODO',
        );

        final authResult = await twitterLogin.login();

        final twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );

        await _firebaseAuth.signInWithCredential(twitterAuthCredential);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
