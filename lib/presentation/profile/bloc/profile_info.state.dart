import 'package:taxi_app/domain/entities/auth/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({required this.userEntity});
}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoFailure extends ProfileInfoState {}
