import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  @override
  Future<void> createCurrentUser(
    String partnerName,
    String partnerEmail,
    String partnerPhone,
    String status,
    String partnerPfpURL,
  ) {
    // TODO: implement createCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUid() {
    // TODO: implement getCurrentUid
    throw UnimplementedError();
  }

  @override
  Future<void> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> googleSignUp() {
    // TODO: implement googleSignUp
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> setPhone(
    String phoneNumber,
  ) {
    // TODO: implement setPhone
    throw UnimplementedError();
  }

  @override
  Future<void> setServiceClass(
    String serviceClass,
  ) {
    // TODO: implement setServiceClass
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(
    String email,
    String password,
  ) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
    String email,
    String password,
  ) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
