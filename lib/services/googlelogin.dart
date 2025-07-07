import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleLoginService {
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn;
      if (kIsWeb) {
        googleSignIn = GoogleSignIn(
          clientId: '666147731145-l9ge2m648o7rkk303ieidl6n4iskfsae.apps.googleusercontent.com',
        );
      } else {
        googleSignIn = GoogleSignIn();
      }
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null; // User cancelled
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Add user details to Firestore
      final user = userCredential.user;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userDoc.set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'lastSignIn': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }
}

