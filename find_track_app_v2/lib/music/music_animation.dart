import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/bloc/auth_bloc.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/song/song_bloc.dart';
import 'details_song.dart';
import 'favorites.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation({super.key});

  @override
  State<MusicAnimation> createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;

  @override
  void initState() {
    super.initState();
    controller =  AnimationController(
      vsync: this, 
      lowerBound: 0.3,
      duration: Duration(milliseconds: 3000)
    );
    curve = CurvedAnimation(
      parent: controller, 
      curve: Curves.fastLinearToSlowEaseIn
    );
    controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SongBloc, SongState>(
        listener: (context, state) {
          if (state is SongLoadedState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsSong(
                    title: state.musicInfo['title'],
                    artist: state.musicInfo['artist'],
                    release_date: state.musicInfo['release_date'],
                    apple: state.musicInfo['apple'],
                    spotify: state.musicInfo['spotify'],
                    album: state.musicInfo['album'],
                    image: state.musicInfo['image'],
                    song_link:state.musicInfo['song_link'],
                  ),
                ),
              );
          }
          else if (state is SongErrorState) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SongLoadingState) 
            return _main('${state.message}');
          else if (state is SongSearchingState){
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _text('${state.message}'),
                  SizedBox(height: 20),
                  _tryout(),
                ],
              ),
            );
          }
          else
            return _main('Toque para escuchar');
        },
      )
    );
  }

  Container _main(String text){
    if (BlocProvider.of<SongBloc>(context).state is SongLoadingState) {
      controller.repeat();
      return Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              _text(text),
              SizedBox(height: 40),
              _searchSong(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _favorites(context),
                  SizedBox(width: 30),
                  _logoutButton(context),
                ],
              )
            ],
        ),
      );
    }
    else {
      controller.reset();
      return Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              _text(text),
              SizedBox(height: 40),
              _searchSong2(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _favorites(context),
                  SizedBox(width: 30),
                  _logoutButton(context),
                ],
              ),
            ],
        ),
      );
    }
  }

  Container _searchSong(BuildContext context) {
    return Container(
      height: 385,
      child: 
        GestureDetector(
          onTap: () {
            BlocProvider.of<SongBloc>(context).add(SongEventHear());
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildCircularContainer(250, Colors.indigoAccent),
              _buildCircularContainer(300, Colors.deepPurpleAccent),
              _buildCircularContainer(350, Colors.pink.shade900),
              Align(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/music2.jpeg"), 
                  radius: 100
                )
              ),
            ],
          ),
        ),
    );
  }

  Container _searchSong2(BuildContext context) {
    return Container(
      height: 385,
      child: 
        GestureDetector(
          onTap: () {
            BlocProvider.of<SongBloc>(context).add(SongEventHear());
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/music2.jpeg"), 
                  radius: 100
                )
              ),
            ],
          ),
        ),
    );
  }

  Widget _favorites(BuildContext context){
    return CircleAvatar(
      radius: 20, 
      backgroundColor: Colors.white,
      child: IconButton(
        onPressed: () {
          //print("Favoritos");
          BlocProvider.of<FavoritesBloc>(context).add(FavoritesEventAddTo(
            
          ));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoritesS(
              ),
            ),
          );
        },
        icon: Icon(Icons.favorite, color: Colors.black),
      ),
    );
  }

  Widget _logoutButton(BuildContext context){
    return CircleAvatar(
      radius: 20, 
      backgroundColor: Colors.white,
      child: IconButton(
        onPressed: () {
          _logout(context);
        },
        icon: Icon(Icons.power_settings_new, color: Colors.black),
      ),
    );
  }

  Text _text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 19,
      ),
    );
  }

  Widget _loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _tryout() {
    return Image.asset(
      "assets/bunny_libgloss_3.gif",
      height: 150,
    );
  }

  Widget _buildCircularContainer(double radius, Color color) {
    return AnimatedBuilder(
      animation: curve,
      builder: (context, child) {
        return Container(
          width: controller.value * radius,
          height: controller.value * radius,
          decoration: BoxDecoration(
            color: color.withOpacity(1 - controller.value), 
            shape: BoxShape.circle
          ),
        );
      },
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cerrar sesión"),
          content: Text("Al cerrar sesión de su cuenta será redirigido a la pantalla de Log In ¿Quiere continuar?"),
          actions: [
            TextButton(
              onPressed: () { 
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.purple.shade200)
              ),
            ),
            TextButton(
              onPressed: () { 
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.purple.shade200)
              ),
            ),
          ],
        );
      }
    );
  }
}