// https://flexiple.com/app/basics-of-flutter-animations/
// https://github.com/deven98/simple_flutter_animation/blob/master/lib/main.dart
// https://www.youtube.com/watch?v=d0wsoY6meBY
// https://github.com/apgapg/avatar_glow/issues/8
// https://docs.flutter.dev/development/ui/animations/tutorial
// https://github.com/flutter/website/blob/main/examples/animation/animate2/lib/main.dart
// https://docs.flutter.dev/development/ui/animations/staggered-animations
// https://github.com/flutter/website/blob/main/examples/_animation/basic_staggered_animation/main.dart
// https://stackoverflow.com/questions/55554314/play-pause-a-flutter-animation

// https://www.flutterbeads.com/circular-image-in-flutter/

/* import 'package:flutter/material.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation({super.key});

  @override
  State<MusicAnimation> createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;
  
  var estado_texto = {
    0: "Toque para escuchar",
    1: "Escuchando...",
  };
  bool estado_boton = false;
  bool favoritos = false;

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
  dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                estado_boton == false ? estado_texto[0]! : estado_texto[1]!,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 385,
                child: 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        estado_boton = !estado_boton;
                        if (!estado_boton) controller.reset();
                        else controller.repeat();
                      });
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
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print("Favoritos");
                  });
                },
                child: CircleAvatar(
                  radius: 20, 
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.black),
                ),
              ),
              /* Container(
                height: 50,
                child: 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print('favoritos');
                        favoritos = !favoritos;
                        if (!favoritos) controller.forward();
                        else controller.stop();
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _buildCircularContainer(120, Colors.white),
                        Align(
                          child: CircleAvatar(
                            radius: 20, 
                            backgroundColor: Colors.white,
                            child: Icon(Icons.favorite, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
              ), */
            ],
        ),
      ),
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

} */

/* import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/music/bloc/song_bloc.dart';
import 'package:music_app/music/details_song.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation({super.key});

  @override
  State<MusicAnimation> createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;
  
  var estado_texto = {
    0: "Toque para escuchar",
    1: "Escuchando...",
  };
  bool estado_boton = false;
  bool favoritos = false;

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
  dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              _record(),
              SizedBox(height: 40),
              _searchSong(context),
              _favorites(context),
            ],
        ),
      ),
    );
  }

  Container _searchSong(BuildContext context) {
    return Container(
      height: 385,
      child: 
        GestureDetector(
          onTap: () {
            setState(() {
              //estado_boton = !estado_boton;
              //if (!estado_boton) controller.reset();
              //else controller.repeat();
              BlocProvider.of<SongBloc>(context).add(
                SongEventHear(
                  
                ));
            });
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

  Column _favorites(BuildContext context){
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              print("Favoritos");
            });
          },
          child: CircleAvatar(
            radius: 20, 
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.black),
          ),
        ),
      ],
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

  BlocConsumer<SongBloc, SongState> _record (){
    return 
      BlocConsumer<SongBloc, SongState>(
        listener: (context, state) {
          if (state is SongLoadedState) {
            SchedulerBinding.instance.addPostFrameCallback((_) { 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsSong(
                    title: state.musicInfo['title'],
                    artist: state.musicInfo['artist'],
                    release_date: state.musicInfo['release_date'],
                    apple: state.musicInfo['apple'],
                    spotify: state.musicInfo['spotify'],
                    album: state.musicInfo['album'],
                    artwork: state.musicInfo['artwork'],
                    song_link:state.musicInfo['song_link'],
                  ),
                ),
              );
            });
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
            return _text('${state.message}');
          else if (state is SongSearchingState){
            //controller.stop();
            //return _goDetails();
            return Column(
              children: [
                _text('${state.message}'),
                _loadingView(),
              ],
            );
          }
          else
            return _text("Toque para escuchar");
        },
      );
    }
} */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/song_bloc.dart';
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
            //SchedulerBinding.instance.addPostFrameCallback((_) { 
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
            //});
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
                  //SizedBox(height: 30),
                  //_loadingView(),
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
              _favorites(context),
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
              _favorites(context),
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

  Column _favorites(BuildContext context){
    return Column(
      children: [
        CircleAvatar(
          radius: 20, 
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {
              //print("Favoritos");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesS(
                    
                  ),
                ),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.black),
          ),
        ),
      ],
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
}