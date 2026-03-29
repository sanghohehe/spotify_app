import 'package:dartz/dartz.dart';
import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/data/model/auth/create_user_req.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/service_locator.dart';

class SignupUsecase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
