import 'package:servisgo_partner/features/home/domain/entities/job_request_entity.dart';

import '../../../home/domain/entities/user_entity.dart';
import '../entities/partner_entity.dart';

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
