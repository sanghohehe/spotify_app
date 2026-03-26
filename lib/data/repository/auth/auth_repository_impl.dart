import 'package:taxi_app/data/model/auth/create_user_req.dart';
import 'package:taxi_app/data/sources/auth/auth_firebase_service.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
