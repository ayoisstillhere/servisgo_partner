import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class CreateCurrentUserUsecase {
  final FirebaseRepository repository;
  CreateCurrentUserUsecase({
    required this.repository,
  });

  Future<void> call(
    String partnerName,
    String partnerEmail,
    String partnerPhone,
    String status,
    String partnerPfpURL,
  ) async {
    repository.createCurrentUser(
      partnerName,
      partnerEmail,
      partnerPhone,
      status,
      partnerPfpURL,
    );
  }
}
