import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

class AppleSignInService {
  static Future<UserCredential?> signInWithApple() async {
    try {
      if (!Platform.isIOS && !Platform.isMacOS) {
        throw Exception('Apple Sign-In is only available on iOS and macOS.');
      }
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      rethrow;
    }
  }
}
