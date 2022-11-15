import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const VideoPlayerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
/// --------------------------------------------------------------------------
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  VideoPlayerController _videoPlayerController;
  VideoPlayerValue _value;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize()
      ..setVolume(10)
      ..play()
      ..addListener(() => setState(() => _value = _videoPlayerController.value));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: const Text('Testing Video Player'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // _value.log();
                setState(() {
                  _videoPlayerController.setVolume(100);
                });
              },
              icon: const Icon(Icons.local_activity))
        ],
      ),
      body: Center(

          child: GestureDetector(
            onTap: () {
              setState(() {
                _videoPlayerController.play();
                _videoPlayerController.setLooping(false);
              });
            },
            child: SizedBox(
              height: 500,
              width: 350,
              child: Stack(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias, // to clip the child corners to be circular forcefully
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 20,
                    child: _value == null || _value.isBuffering ?
                    const Center(child: Icon(Icons.close, size: 50))
                        :
                    VideoPlayer(_videoPlayerController),
                  ),
                  if (_value?.isPlaying == false)
                    const Center(
                        child: Icon(Icons.play_arrow,
                            size: 50,
                            color: Colors.red
                        )
                    )
                ],
              ),
            ),
          )),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          FloatingActionButton(
            onPressed: () {
              setState(() {
                _videoPlayerController.play();
                _videoPlayerController.setLooping(true);
              });
              // _value.isPlaying.log();
            },
            child: const Icon(Icons.play_arrow),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            onPressed: () {
              setState(() {
                _videoPlayerController.pause();
                _videoPlayerController.setLooping(false);
              });
              // _value.isPlaying.log();
            },
            child: const Icon(Icons.pause),
          ),
        ],
      ),
    );
  }
}
