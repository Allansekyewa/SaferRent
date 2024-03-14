import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends StatefulWidget {
  final Post p;
  const PostVideoView({required this.p, Key? k}) : super(key: k);
  @override
  _PostVideoViewState createState() => _PostVideoViewState();
}

class _PostVideoViewState extends State<PostVideoView> {
  late VideoPlayerController _c;
  bool _rz = false;
  bool _sc = true;

  @override
  void initState() {
    super.initState();
    _c = VideoPlayerController.networkUrl(Uri.parse(widget.p.fileUrl));
    _c.initialize().then((_) {
      setState(() {
        _rz = true;
        _c.setLooping(false);
        _c.play();
      });
    });
    _c.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  String fd(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sc = !_sc;
        });
      },
      child: Stack(
        children: <Widget>[
          if (_rz)
            AspectRatio(
              aspectRatio: widget.p.aspectRatio,
              child: VideoPlayer(_c),
            )
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 15),
                CupertinoActivityIndicator(
                  color: Colors.red,
                  radius: 5,
                ),
                SizedBox(width: 5),
                Text("Loading...",
                    style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          if (_sc)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      _c.value.isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : CupertinoIcons.play_circle_fill,
                      size: 20,
                      color: _c.value.isPlaying ? Colors.green : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _c.value.isPlaying ? _c.pause() : _c.play();
                      });
                    },
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 1,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6.0),
                        thumbColor: Colors.red,
                      ),
                      child: Slider(
                        value: _c.value.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _c.value.duration.inSeconds.toDouble(),
                        onChanged: (double v) {
                          setState(() {
                            _c.seekTo(Duration(seconds: v.toInt()));
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Text(
                    '${fd(_c.value.position)} / ${fd(_c.value.duration)}',
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
