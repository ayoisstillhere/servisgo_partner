import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class UpdateServiceToOngoingUsecase {
  final FirebaseRepository repository;
  UpdateServiceToOngoingUsecase({
    required this.repository,
  });

  Future<void> call(String serviceId) async =>
      await repository.updateServiceToOnGoing(serviceId);
}
