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
    String partnerPfpURL,
  );
  Future<void> signOut();
  Future<void> googleSignIn();
  Future<void> googleSignUp();
  Future<void> setPhone(String phoneNumber);
  Future<void> setServiceClass(String serviceClass);
  Future<void> resetPassword(String email);
}
