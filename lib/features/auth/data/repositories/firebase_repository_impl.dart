import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasources/firebase_remote_datasource.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasource firebaseRemoteDatasource;
  FirebaseRepositoryImpl({
    required this.firebaseRemoteDatasource,
  });
  @override
  Future<void> createCurrentUser(
    String partnerName,
    String partnerEmail,
    String partnerPhone,
    String status,
    String serviceClass,
    String partnerPfpURL,
  ) async {
    return await firebaseRemoteDatasource.createCurrentUser(
      partnerName,
      partnerEmail,
      partnerPhone,
      status,
      serviceClass,
      partnerPfpURL,
    );
  }

  @override
  Future<String> getCurrentUid() async =>
      await firebaseRemoteDatasource.getCurrentUid();

  @override
  Future<void> googleSignIn() async =>
      await firebaseRemoteDatasource.googleSignIn();

  @override
  Future<void> googleSignUp() async =>
      await firebaseRemoteDatasource.googleSignUp();

  @override
  Future<bool> isSignIn() async => await firebaseRemoteDatasource.isSignIn();

  @override
  Future<void> resetPassword(String email) async =>
      await firebaseRemoteDatasource.resetPassword(email);

  @override
  Future<void> setPhone(
    String phoneNumber,
  ) async {
    return await firebaseRemoteDatasource.setPhone(phoneNumber);
  }

  @override
  Future<void> setServiceClass(
    String serviceClass,
  ) async {
    return await firebaseRemoteDatasource.setServiceClass(serviceClass);
  }

  @override
  Future<void> signIn(
    String email,
    String password,
  ) async =>
      await firebaseRemoteDatasource.signIn(email, password);

  @override
  Future<void> signOut() => firebaseRemoteDatasource.signOut();

  @override
  Future<void> signUp(
    String email,
    String password,
  ) async =>
      await firebaseRemoteDatasource.signUp(email, password);

  @override
  Stream<List<PartnerEntity>> getPartners() {
    return firebaseRemoteDatasource.getPartners();
  }
}
