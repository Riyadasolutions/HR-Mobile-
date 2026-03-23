


import 'package:base_app/features/auth/core/auth/auth_helper.dart';
import 'package:base_app/features/auth/domain/parameters/social_signIn_parameters.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:base_app/core/utils/logger.dart';


class GoogleAuthHelper{

  static Future<SocialSignInParameters?> login() async {
    log('GoogleAuthHelper', 'Start');

    try {
      final googleSignIn = GoogleSignIn.instance;

      // Initialize if not already initialized
      // Note: This should ideally be called once at app startup
      try {
        await googleSignIn.initialize();
      } catch (e) {
        // Already initialized, ignore
        log('GoogleAuthHelper', 'Already initialized or initialization error: $e');
      }

      // Sign out any existing session first
      await googleSignIn.signOut();

      String? email;
      String? userId;
      String? displayName;
      String? image;
      String? idToken;

      log('GoogleAuthHelper', 'Attempting to sign in...');

      GoogleSignInAccount googleSignInAccount = await googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      email = googleSignInAccount.email;
      userId = googleSignInAccount.id;
      displayName = googleSignInAccount.displayName;
      image = googleSignInAccount.photoUrl;

      log('GoogleAuthHelper', 'userId $userId ,email $email, image ${image} ,name $displayName');

      GoogleSignInAuthentication auth = googleSignInAccount.authentication;
      idToken = auth.idToken;

      log('GoogleAuthHelper', 'idToken ${auth.idToken}');
      log('GoogleAuthHelper', ' userId: $userId, email: $email, name: $displayName, image: $image');

      if (userId.isEmpty) {
        log('GoogleAuthHelper', 'Error: userId is empty');
        return null;
      }

      return SocialSignInParameters(
        authType: AuthType.google,
        userId: userId,
        email: email,
        name: displayName,
        image: image,
        token: idToken,
      );
    } catch (e) {
      log('GoogleAuthHelper', 'Error during Google Sign-In: $e');
      // Re-throw to let the caller handle it
      rethrow;
    }
  }

}

