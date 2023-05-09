import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';
import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class GetPartnersUsecase {
  final FirebaseRepository repository;
  GetPartnersUsecase({
    required this.repository,
  });
  
  Stream<List<PartnerEntity>> call() => repository.getPartners();

}
