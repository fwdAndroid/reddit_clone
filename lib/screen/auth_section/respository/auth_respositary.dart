import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/constants/constant.dart';
import 'package:reddit_clone/constants/fiirebasecontanstants.dart';
import 'package:reddit_clone/models/user_model.dart';
import 'package:reddit_clone/providers/firebase_providers.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserModel userModel = UserModel(
        name: userCredential.user!.displayName ?? 'No Name',
        profilePic: Constants.avatarDefault,
        banner: Constants.bannerDefault,
        uid: userCredential.user!.uid,
        isAuthenticated: true,
        karma: 0,
        awards: [],
      );
      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
    } catch (e) {
      print(e);
    }
  }

  // FutureEither<UserModel> signInAsGuest() async {
  //   try {
  //     var userCredential = await _auth.signInAnonymously();

  // UserModel userModel = UserModel(
  //   name: 'Guest',
  //   profilePic: Constants.avatarDefault,
  //   banner: Constants.bannerDefault,
  //   uid: userCredential.user!.uid,
  //   isAuthenticated: false,
  //   karma: 0,
  //   awards: [],
  // );

  //     await _users.doc(userCredential.user!.uid).set(userModel.toMap());

  //     return right(userModel);
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  // Stream<UserModel> getUserData(String uid) {
  //   return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  // }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
