import 'package:flutter/material.dart';
import 'sound_recorder_manager.dart';

class Home extends StatefulWidget {
  const Home({
    super.key
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Chromatic'),
          Text('Guitar'),
          Text('Ukulele'),
          Text('Bass'),
          Text('Violin'),
          Text('Custom'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoundRecorderManager()),
              );
            },
            child: const Text('Graba tu voz!'),
          ),
        ],
      ),
    );
  }
}