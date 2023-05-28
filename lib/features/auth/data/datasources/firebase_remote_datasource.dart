// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:servisgo_partner/features/auth/data/models/partner_model.dart';
import 'package:servisgo_partner/features/home/data/models/job_request_model.dart';
import 'package:servisgo_partner/features/tracker/data/models/accepted_service_model.dart';

import '../../../home/data/models/user_model.dart';
import '../../../home/domain/entities/job_request_entity.dart';
import '../../../home/domain/entities/user_entity.dart';
import '../../domain/entities/partner_entity.dart';
import 'package:uuid/uuid.dart';

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
  Stream<List<PartnerEntity>> getPartners();
  Future<void> updateStatus(String status);
  Future<void> updateName(String newName);
  Future<void> updatePhone(String newPhone);
  Future<void> updatePartnerPfpUrl(String newPartnerPfpUrl);
  Stream<List<JobRequestEntity>> getJobRequests();
  Stream<List<UserEntity>> getUsers();
  Future<void> acceptJobRequest(
    String customerId,
    String serviceClass,
    String serviceStatus,
    String scheduledDate,
    String scheduledTime,
    String servicePrice,
    double serviceRating,
    String additionalDetails,
    String customerAddress,
    double? latitudeCustomer,
    double? longitudeCustomer,
    double? latitudePartner,
    double? longitudePartner,
    String jobRequestId,
  );
}

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _partnerCollection = FirebaseFirestore.instance.collection('partners');
  final _jobRequestCollection =
      FirebaseFirestore.instance.collection('jobRequests');
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _acceptedServiceCollection =
      FirebaseFirestore.instance.collection("acceptedServices");
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
    await _partnerCollection.doc(_auth.currentUser!.uid).get().then((user) {
      if (!user.exists) {
        final newUser = PartnerModel(
          partnerId: _auth.currentUser!.uid,
          partnerName: partnerName,
          partnerEmail: partnerEmail,
          partnerPhone: partnerPhone,
          status: status,
          serviceClass: serviceClass,
          partnerPfpURL: partnerPfpURL,
          ratings: const [],
          completed: 0,
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
          ratings: const [],
          completed: 0,
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
      await googleSignin.disconnect();
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

  @override
  Stream<List<PartnerEntity>> getPartners() {
    return _partnerCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((docSnapshot) => PartnerModel.fromSnapshot(docSnapshot))
        .toList());
  }

  @override
  Future<void> updateStatus(String status) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'status': status,
    });
  }

  @override
  Future<void> updateName(String newName) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'partnerName': newName,
    });
  }

  @override
  Future<void> updatePhone(String newPhone) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'partnerPhone': newPhone,
    });
  }

  @override
  Future<void> updatePartnerPfpUrl(String newPartnerPfpUrl) async {
    await _partnerCollection.doc(_auth.currentUser!.uid).update({
      'partnerPfpURL': newPartnerPfpUrl,
    });
  }

  @override
  Stream<List<JobRequestEntity>> getJobRequests() {
    return _jobRequestCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((docSnapshot) => JobRequestModel.fromSnapshot(docSnapshot))
            .toList());
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    return _userCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((docSnapshot) => UserModel.fromSnapshot(docSnapshot))
        .toList());
  }

  @override
  Future<void> acceptJobRequest(
    String customerId,
    String serviceClass,
    String serviceStatus,
    String scheduledDate,
    String scheduledTime,
    String servicePrice,
    double serviceRating,
    String additionalDetails,
    String customerAddress,
    double? latitudeCustomer,
    double? longitudeCustomer,
    double? latitudePartner,
    double? longitudePartner,
    String jobRequestId,
  ) async {
    var uuid = const Uuid();
    final String id = uuid.v4();

    final newAcceptedService = AcceptedServiceModel(
      id: id,
      customerId: customerId,
      partnerId: _auth.currentUser!.uid,
      serviceClass: serviceClass,
      serviceStatus: serviceStatus,
      scheduledDate: scheduledDate,
      scheduledTime: scheduledTime,
      servicePrice: servicePrice,
      serviceRating: serviceRating,
      additionalDetails: additionalDetails,
      customerAddress: customerAddress,
      latitudeCustomer: latitudeCustomer,
      longitudeCustomer: longitudeCustomer,
      latitudePartner: latitudePartner,
      longitudePartner: longitudePartner,
    );

    await _acceptedServiceCollection
        .doc(id)
        .set(newAcceptedService.toDocument());

    await _jobRequestCollection
        .doc(jobRequestId)
        .update({'jobRequestStatus': 'Accepted'});
  }
}
