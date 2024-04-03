import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class VideoTrailer extends StatefulWidget {
  VideoTrailer({this.url, this.title,this.type});
  final url;
  final title;
  final type;

  @override
  _VideoTrailerState createState() => _VideoTrailerState();
}

class _VideoTrailerState extends State<VideoTrailer> {
  late YoutubePlayerController _controller;
  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url).toString(),
      flags: YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: false,
      ),
    );
  }


  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }


  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context,player){
        return Column(
          children: <Widget>[
            player,
            GestureDetector(
              onTap: () async{
                final youtubeUrl =
                    'https://www.youtube.com/embed/${widget.url}';
                if (await canLaunch(youtubeUrl)) {
                  await launch(youtubeUrl);
                }
              },
              child: Text(widget.title,style: TextStyle(color: Colors.black45,),),
            ),
            Text(widget.type,style: TextStyle(color: Colors.black45),),
            SizedBox(height: 40,),
          ],
        );
      },
    );
  }
}