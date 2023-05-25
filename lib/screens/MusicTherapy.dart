// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class MusicTherapy extends StatefulWidget {
//   @override
//   _MusicTherapyState createState() => _MusicTherapyState();
// }
//
// class _MusicTherapyState extends State<MusicTherapy> {
//   late AudioPlayer _audioPlayer;
//   PlayerState _audioPlayerState = PlayerState.stopped;
//   bool _isPlaying = false;
//   List<Map<String, dynamic>> _playlist = [
//     {
//       'title': 'Nature Sounds',
//       'artist': 'Unknown',
//       'coverImage': 'https://via.placeholder.com/150x150?text=Nature+Sounds'
//     },
//     {
//       'title': 'Classical Music',
//       'artist': 'Unknown',
//       'coverImage': 'https://via.placeholder.com/150x150?text=Classical+Music'
//     },
//     {
//       'title': 'Ambient Music',
//       'artist': 'Unknown',
//       'coverImage': 'https://via.placeholder.com/150x150?text=Ambient+Music'
//     },
//     {
//       'title': 'Relaxation Music',
//       'artist': 'Unknown',
//       'coverImage': 'https://via.placeholder.com/150x150?text=Relaxation+Music'
//     },
//   ];
//   int _currentSongIndex = 0;
//   double _volume = 1.0;
//   Duration _duration = Duration();
//   Duration _position = Duration();
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _audioPlayer.onDurationChanged.listen((Duration d) {
//       setState(() {
//         _duration = d;
//       });
//     });
//     _audioPlayer.onPositionChanged.listen((Duration p) {
//       setState(() {
//         _position = p;
//       });
//     });
//     _audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
//       setState(() {
//         _audioPlayerState = s;
//         if (_audioPlayerState == PlayerState.completed) {
//           _isPlaying = false;
//           _nextSong();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   void _playPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     } else {
//       _audioPlayer.resume();
//       setState(() {
//         _isPlaying = true;
//       });
//     }
//   }
//
//   void _nextSong() {
//     if (_currentSongIndex < _playlist.length - 1) {
//       setState(() {
//         _currentSongIndex++;
//       });
//     } else {
//       setState(() {
//         _currentSongIndex = 0;
//       });
//     }
//     _playSong();
//   }
//
//   void _previousSong() {
//     if (_currentSongIndex > 0) {
//       setState(() {
//         _currentSongIndex--;
//       });
//     } else {
//       setState(() {
//         _currentSongIndex = _playlist.length - 1;
//       });
//     }
//     _playSong();
//   }
//
//   void _playSong() async {
//     if (_audioPlayerState == PlayerState.playing) {
//       await _audioPlayer.stop();
//     }
//     await _audioPlayer.play(_playlist[_currentSongIndex]['source']);
//     setState(() {
//       _isPlaying = true;
//     });
//   }
//
//   void _changeVolume(double value) {
//     _audioPlayer.setVolume(value);
//     setState(() {
//       _volume = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Music Therapy'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 32),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 _playlist[_currentSongIndex]['title'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 _playlist[_currentSongIndex]['artist'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.network(
//                     _playlist[_currentSongIndex]['coverImage'],
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('${_position.inSeconds}'),
//                   Expanded(
//                     child: Slider(
//                       value: _position.inSeconds.toDouble(),
//                       min: 0.0,
//                       max: _duration.inSeconds.toDouble(),
//                       onChanged: (double value) {
//                         setState(() {
//                           _audioPlayer.seek(Duration(seconds: value.toInt()));
//                         });
//                       },
//                     ),
//                   ),
//                   Text('${_duration.inSeconds}'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.skip_previous),
//                   iconSize: 48,
//                   onPressed: _previousSong,
//                 ),
//                 IconButton(
//                   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                   iconSize: 64,
//                   onPressed: _playPause,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.skip_next),
//                   iconSize: 48,
//                   onPressed: _nextSong,
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.volume_down),
//                   Expanded(
//                     child: Slider(
//                       value: _volume,
//                       onChanged: _changeVolume,
//                     ),
//                   ),
//                   Icon(Icons.volume_up),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicTherapy extends StatefulWidget {
  final int initialSongIndex;
  final List<Map<String, dynamic>> playlist;

  const MusicTherapy({
    Key? key,
    required this.initialSongIndex,
    required this.playlist,
  }) : super(key: key);

  @override
  _MusicTherapyState createState() => _MusicTherapyState();
}

class _MusicTherapyState extends State<MusicTherapy> {
  late AudioPlayer _audioPlayer;
  PlayerState _audioPlayerState = PlayerState.stopped;
  bool _isPlaying = false;
  int _currentSongIndex = 0;
  double _volume = 1.0;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();
    _currentSongIndex = widget.initialSongIndex;
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        _audioPlayerState = s;
        if (_audioPlayerState == PlayerState.completed) {
          _isPlaying = false;
          _nextSong();
        }
      });
    });
    _playSong();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _nextSong() {
    if (_currentSongIndex < widget.playlist.length - 1) {
      setState(() {
        _currentSongIndex++;
      });
    } else {
      setState(() {
        _currentSongIndex = 0;
      });
    }
    _playSong();
  }

  void _previousSong() {
    if (_currentSongIndex > 0) {
      setState(() {
        _currentSongIndex--;
      });
    } else {
      setState(() {
        _currentSongIndex = widget.playlist.length - 1;
      });
    }
    _playSong();
  }

  void _playSong() async {
    if (_audioPlayerState == PlayerState.playing) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.play(widget.playlist[_currentSongIndex]['source']);
    setState(() {
      _isPlaying = true;
    });
  }

  void _changeVolume(double value) {
    _audioPlayer.setVolume(value);
    setState(() {
      _volume = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playlist != null) {
      // Use widget.playlist here
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Therapy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.playlist[_currentSongIndex]['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.playlist[_currentSongIndex]['artist'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.playlist[_currentSongIndex]['coverImage'],
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_position.inSeconds}'),
                  Expanded(
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        });
                      },
                    ),
                  ),
                  Text('${_duration.inSeconds}'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48,
                  onPressed: _previousSong,
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 64,
                  onPressed: _playPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 48,
                  onPressed: _nextSong,
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.volume_down),
                  Expanded(
                    child: Slider(
                      value: _volume,
                      onChanged: _changeVolume,
                    ),
                  ),
                  Icon(Icons.volume_up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }
    else{
      return Scaffold(
          appBar: AppBar(
          title: Text('Music Therapy'),
    ),
    body: Container(
    child: Text('error')
    ));
    }
  }
}
