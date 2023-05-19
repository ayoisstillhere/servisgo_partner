import '../repositories/firebase_repository.dart';

class UpdatePhoneUsecase {
  final FirebaseRepository repository;
  UpdatePhoneUsecase({
    required this.repository,
  });

  Future<void> call(
    String newPhone,
  ) async =>
      await repository.updatePhone(
        newPhone,
      );
}
