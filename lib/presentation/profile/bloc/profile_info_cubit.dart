import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/domain/usecases/song/get_new_song.dart';
import 'package:taxi_app/presentation/profile/bloc/profile_info.state.dart';
import 'package:taxi_app/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());
  Future<void> getUser() async {
    var user = await sl<GetNewSongUsecase>().call();

    user.fold(
      (l) {
        emit(ProfileInfoFailure());
      },
      (UserEntity) {
        emit(ProfileInfoLoaded(userEntity: UserEntity));
      },
    );
  }
}
