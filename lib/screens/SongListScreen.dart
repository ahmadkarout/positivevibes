import 'package:flutter/material.dart';
import 'package:heartbeats2/screens/MusicTherapy.dart';

class SongListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _songList = [
    {
      'title': 'Nature Sounds',
      'artist': 'Unknown',
      'coverImage': 'https://via.placeholder.com/150x150?text=Nature+Sounds',
      'source': 'https://example.com/nature-sounds.mp3',
    },
    {
      'title': 'Classical Music',
      'artist': 'Unknown',
      'coverImage': 'https://via.placeholder.com/150x150?text=Classical+Music',
      'source': 'https://example.com/classical-music.mp3',
    },
    {
      'title': 'Ambient Music',
      'artist': 'Unknown',
      'coverImage': 'https://via.placeholder.com/150x150?text=Ambient+Music',
      'source': 'https://example.com/ambient-music.mp3',
    },
    {
      'title': 'Relaxation Music',
      'artist': 'Unknown',
      'coverImage': 'https://via.placeholder.com/150x150?text=Relaxation+Music',
      'source': 'https://example.com/relaxation-music.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (context, index) {
          final song = _songList[index];
          return ListTile(
            leading: Image.network(
              song['coverImage'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(song['title']),
            subtitle: Text(song['artist']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicTherapy(
                    initialSongIndex: index,
                    playlist: _songList,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
