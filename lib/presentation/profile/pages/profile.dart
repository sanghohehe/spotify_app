import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/common/helpers/is_dark_mode.dart';
import 'package:taxi_app/common/widgets/appbar/app_bar.dart';
import 'package:taxi_app/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:taxi_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:taxi_app/presentation/profile/bloc/profile_info.state.dart';
import 'package:taxi_app/presentation/profile/bloc/profile_info_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileInfoCubit()..getUser()),
        BlocProvider(create: (_) => FavoriteSongsCubit()..getFavoriteSongs()),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          backgroundColor: Color(0xff2C2B2B),
          title: Text('Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfo(),
            SizedBox(height: 30),
            _favoriteSongs(context),
          ],
        ),
      ),
    );
  }
}

Widget _profileInfo() {
  return Builder(
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.IsDarkMode ? Color(0xff2C2B2B) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProfileInfoFailure) {
              return Center(child: Text('Failed to load user info'));
            }

            if (state is ProfileInfoLoaded) {
              final user = state.userEntity;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          user.imageUrl ?? 'https://via.placeholder.com/150',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    user.email ?? 'No email',
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: 10),

                  Text(
                    user.fullName ?? 'No name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            return SizedBox();
          },
        ),
      );
    },
  );
}

Widget _favoriteSongs(BuildContext context) {
  return BlocProvider(
    create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Favorite Songs'),
          SizedBox(height: 20),
          BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
            builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return CircularProgressIndicator();
              }
              if (state is FavoriteSongsLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.favoriteSongs.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final song = state.favoriteSongs[index];

                    return Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(song.image!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(song.title, overflow: TextOverflow.ellipsis),
                              SizedBox(height: 5),
                              Text(song.artist),
                            ],
                          ),
                        ),

                        Text(song.duration.toString().replaceAll('.', ':')),
                      ],
                    );
                  },
                );
              }
              if (state is FavoriteSongsFailure) {
                return Text('Failed to load favorite songs');
              }
              return Container();
            },
          ),
        ],
      ),
    ),
  );
}
