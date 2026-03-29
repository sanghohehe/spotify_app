import 'package:dartz/dartz.dart';
import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/domain/repository/song/song.dart';
import 'package:taxi_app/service_locator.dart';

class AddOrRemoveFavoriteSongUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }
}
