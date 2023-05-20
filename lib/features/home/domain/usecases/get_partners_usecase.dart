import '../../../auth/domain/entities/partner_entity.dart';
import '../../../auth/domain/repositories/firebase_repository.dart';

class GetPartnersUsecase {
  final FirebaseRepository repository;
  GetPartnersUsecase({
    required this.repository,
  });

  Stream<List<PartnerEntity>> call() => repository.getPartners();
}
