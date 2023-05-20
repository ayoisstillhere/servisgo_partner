import '../repositories/firebase_repository.dart';

class UpdatePartnerPfpUrlUsecase {
  final FirebaseRepository repository;
  UpdatePartnerPfpUrlUsecase({
    required this.repository,
  });

  Future<void> call(String newPartnerPfpUrl) async => await repository.updatePartnerPfpUrl(newPartnerPfpUrl);
  
}
