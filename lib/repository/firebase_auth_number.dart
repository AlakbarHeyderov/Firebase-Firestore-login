import '../api/firebase_number_auth.dart';

class FirebaseAuthNumberRepo {
  Future<void> signInNumber(
    String name,
    String surname,
    String number,
    int age,
    var context,
  ) async {
    FirabaseSendApi firabaseSendApi = FirabaseSendApi(context: context);
    firabaseSendApi.firebaseNumber(number, name, surname, age);
  }
}
