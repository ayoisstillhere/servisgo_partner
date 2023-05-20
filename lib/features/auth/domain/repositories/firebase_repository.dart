import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';

abstract class FirebaseRepository {
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
}
