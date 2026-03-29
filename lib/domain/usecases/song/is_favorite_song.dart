import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/domain/repository/song/song.dart';
import 'package:taxi_app/service_locator.dart';

class IsFavoriteSongUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}
