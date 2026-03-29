import 'package:dartz/dartz.dart';
import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/domain/repository/song/song.dart';
import 'package:taxi_app/service_locator.dart';

class GetNewSongUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getNewSongs();
  }
}
