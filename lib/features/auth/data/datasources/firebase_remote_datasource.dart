// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:servisgo_partner/features/auth/data/models/partner_model.dart';

abstract class FirebaseRemoteDatasource {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<bool> isSignIn();
  Future<String> getCurrentUid();
  Future<void> createCurrentUser(
    String partnerName,
    String partnerEmail,
    String partnerPhone,
    String status,
    String serviceClass,
    String partnerPfpURL,
  );
  Future<void> signOut();
  Future<void> googleSignIn();
  Future<void> googleSignUp();
  Future<void> setPhone(String phoneNumber);
  Future<void> setServiceClass(String serviceClass);
  Future<void> resetPassword(String email);
}

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _partnerCollection = FirebaseFirestore.instance.collection('partners');
  final googleSignin = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  @override
  Future<void> createCurrentUser(
    String partnerName,
    String partnerEmail,
    String partnerPhone,
    String status,
    String serviceClass,
    String partnerPfpURL,
  ) async {
    _partnerCollection.doc(_auth.currentUser!.uid).get().then((user) {
      if (!user.exists) {
        final newUser = PartnerModel(
          partnerId: _auth.currentUser!.uid,
          partnerName: partnerName,
          partnerEmail: partnerEmail,
          partnerPhone: partnerPhone,
          status: status,
          serviceClass: serviceClass,
          partnerPfpURL: partnerPfpURL,
        ).toDocument();
        _partnerCollection.doc(_auth.currentUser!.uid).set(newUser);
        return;
      }
    });
  }

  @override
  Future<String> getCurrentUid() async => _auth.currentUser!.uid;

  @override
  Future<void> googleSignIn() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> googleSignUp() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);

    await _partnerCollection.doc(_auth.currentUser!.uid).get().then((user) {
      if (!user.exists) {
        final newUser = PartnerModel(
          partnerId: _auth.currentUser!.uid,
          partnerName: _user!.displayName!,
          partnerEmail: _user!.email,
          partnerPhone: "",
          status: "offline",
          serviceClass: "",
          partnerPfpURL: _user!.photoUrl!,
        ).toDocument();
        _partnerCollection.doc(_auth.currentUser!.uid).set(newUser);
        return;
      }
    });
  }

  @override
  Future<bool> isSignIn() async => _auth.currentUser!.uid != null;

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> setPhone(String phoneNumber) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'partnerPhone': phoneNumber,
    });
  }

  @override
  Future<void> setServiceClass(String serviceClass) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'serviceClass': serviceClass,
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    if (await googleSignin.isSignedIn()) {
      googleSignin.disconnect();
    }
    await _auth.signOut();
  }

  @override
  Future<void> signUp(
    String email,
    String password,
  ) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
