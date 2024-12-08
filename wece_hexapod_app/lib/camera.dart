import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ArducamStreamPage extends StatefulWidget {
  const ArducamStreamPage({Key? key}) : super(key: key);

  @override
  _ArducamStreamPageState createState() => _ArducamStreamPageState();
}

class _ArducamStreamPageState extends State<ArducamStreamPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Replace with your OBS stream URL
    _controller = VideoPlayerController.network('http://localhost:8080/live')
      ..initialize().then((_) {
        setState(() {}); // Update UI once the video is ready
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ArduCAM Stream")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
