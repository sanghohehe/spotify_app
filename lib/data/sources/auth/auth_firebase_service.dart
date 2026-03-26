import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxi_app/data/model/auth/create_user_req.dart';

abstract class AuthFirebaseService {
  Future<void> signup(CreateUserReq createUsserReq);
  Future<void> signin();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq createUsserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUsserReq.email,
        password: createUsserReq.password,
      );
    } on FirebaseAuthException catch (e) {}
  }
}
