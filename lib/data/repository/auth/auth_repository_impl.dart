import 'package:dartz/dartz.dart';
import 'package:taxi_app/data/model/auth/create_user_req.dart';
import 'package:taxi_app/data/model/auth/sigin_user_req.dart';
import 'package:taxi_app/data/sources/auth/auth_firebase_service.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signUserReq) async {
    return await sl<AuthFirebaseService>().signin(signUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
