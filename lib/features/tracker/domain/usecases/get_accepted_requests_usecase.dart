import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';
import 'package:servisgo_partner/features/tracker/domain/entities/accepted_service_entity.dart';

class GetAcceptedRequestsUsecase {
  final FirebaseRepository repository;
  GetAcceptedRequestsUsecase({
    required this.repository,
  });

  Stream<List<AcceptedServiceEntity>> call() =>
      repository.getAcceptedServices();
}
