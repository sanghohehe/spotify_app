import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/domain/entities/song/song.dart';
import 'package:taxi_app/domain/usecases/song/get_favorite_songs.dart';
import 'package:taxi_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:taxi_app/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());


  List<SongEntity> favoriteSongs = [];
  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUsecase>().call();
    result.fold(
      (l) {
        emit(FavoriteSongsFailure());
      },
      (favoriteSongs) {
        this.favoriteSongs = favoriteSongs;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }
}
