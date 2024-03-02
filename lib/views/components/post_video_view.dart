import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';

import 'package:video_player/video_player.dart';

class PostVideoView extends StatefulWidget {
  final Post post;
  const PostVideoView({required this.post, Key? key}) : super(key: key);

  @override
  _PostVideoViewState createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView> {
  late VideoPlayerController _controller;
  bool _isVideoPlayerReady = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.post.fileUrl));
    _controller.initialize().then((_) {
      setState(() {
        _isVideoPlayerReady = true;
        _controller.setLooping(false);
        _controller.play();
      });
    });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = !_showControls;
        });
      },
      child: Stack(
        children: <Widget>[
          if (_isVideoPlayerReady)
            AspectRatio(
              aspectRatio: widget.post.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 15), // Adjust the size as needed.
                CupertinoActivityIndicator(
                  color: Colors.black,
                  radius: 5,
                ),
                SizedBox(width: 5),
                Text("Loading...",
                    style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          if (_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : CupertinoIcons.play_circle_fill,
                      size: 20, // Adjust the size as needed.
                      color: _controller.value.isPlaying
                          ? Colors.green
                          : Colors.red, // Set the color to blue.
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 1, // Adjust the thickness as needed.
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6.0),
                        thumbColor: Colors.red,
                        // Adjust the size as needed.
                      ),
                      child: Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _controller
                                .seekTo(Duration(seconds: value.toInt()));
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Text(
                    '${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
