import '../repositories/firebase_repository.dart';

class UpdateNameUsecase {
  final FirebaseRepository repository;

  UpdateNameUsecase({required this.repository});

  Future<void> call(
    String newName,
  ) async =>
      await repository.updateName(
        newName,
      );
}
