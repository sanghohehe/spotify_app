import 'package:dartz/dartz.dart';
import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/data/model/auth/sigin_user_req.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/service_locator.dart';

class SigninUsecase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
