import 'package:dartz/dartz.dart';
import 'package:taxi_app/data/model/auth/create_user_req.dart';
import 'package:taxi_app/data/model/auth/sigin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();

}
