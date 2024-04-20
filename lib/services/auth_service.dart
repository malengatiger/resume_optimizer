import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';
import '../util/functions.dart';
import '../util/prefs.dart';
import 'firestore_service.dart';

class AuthService {
  static const String mm = '🍎🍎🍎 AuthService: ';

  final auth.FirebaseAuth firebaseAuth;
  final Prefs prefs;
  final FirestoreService firestoreService;

  AuthService(this.firebaseAuth, this.prefs, this.firestoreService);

  Future<User?> registerUser(User user) async {
    pp('$mm registerUser: create Firebase User .. ${user.toJson()}.');

    try {
      var creds = await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      if (creds.user != null) {
        pp('$mm user created ... cool! 🍎${creds.user!.email} 🍎');

        user.firebaseUserId = creds.user?.uid;
        if (user.name != null) {
          await firebaseAuth.currentUser!.updateDisplayName('${user.name}');
        }
        pp('$mm add user to Firebase ....');
        await firestoreService.addUser(user);
        prefs.saveUser(user);
        pp('$mm User added to Firebase/Firestore, saved in prefs: ${user.toJson()}');
        return user;
      } else {
        pp('$mm ... we going down, Boss!');
        throw Exception(
            'createUserWithEmailAndPassword failed. creds.user is null');
      }
    } catch (e, s) {
      pp('$mm registerUser: failed. $e $s');
      throw Exception(
          'Unable to create authenticated user. Check your email address');
    }
    return null;
  }

  Future forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInUser(String email, String password) async {
    pp('$mm signIn Firebase User ...');

    try {
      var creds = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (creds.user == null) {
        throw Exception('Sign in failed');
      }

      pp('$mm Firebase User authenticated OK, ');

      var mUser = await firestoreService.getUser(creds.user!.uid);
      if (mUser != null) {
        pp('$mm User is signed in: ${mUser.toJson()}');
        prefs.saveUser(mUser);
        return mUser;
      } else {
        pp('$mm User not found');
        throw Exception('SgelaAI user not found');
      }
    } catch (e, s) {
      pp('$mm Firebase ERROR: 😡$e 😡$e');
      rethrow;
    }
  }

  bool isSignedIn() {
    if (firebaseAuth.currentUser == null) {
      return false;
    }
    firebaseAuth.authStateChanges().listen((user) async {
      if ((user != null)) {
        pp('authStateChanges, token: ${await user.getIdToken()}');
      }
    });
    return true;
  }
}
