import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class AcceptJobRequestUsecase {
  final FirebaseRepository repository;
  AcceptJobRequestUsecase({
    required this.repository,
  });

  Future<void> call(
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
  ) async =>
      repository.acceptJobRequest(
        customerId,
        serviceClass,
        serviceStatus,
        scheduledDate,
        scheduledTime,
        servicePrice,
        serviceRating,
        additionalDetails,
        customerAddress,
        latitudeCustomer,
        longitudeCustomer,
        latitudePartner,
        longitudePartner,
        jobRequestId,
      );
}
