import 'package:flutter/material.dart'; 

void main() => runApp(TuaniTune());

class TuaniTune extends StatelessWidget {
  const TuaniTune({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "TuaniTune",
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({
    super.key
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ElevatedButton _openTunerButton(
      Function onPressed, IconData icon, String label) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 114, 133, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 114, 133, 1.0),
        title: Text("TuaniTune", style: TextStyle(color: Colors.white)),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 30),
        actions: const [
          Icon(Icons.settings)
        ],
      ),
      body: Center(
        child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(153, 233, 242, 1.0),
            width: 2.0,
          ),
          borderRadius:BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            _openTunerButton(
              () => debugPrint('Chromatic pressed'),
              Icons.graphic_eq,
              'Chromatic',
            ),
            _openTunerButton(
              () => debugPrint('Guitar pressed'),
              Icons.play_arrow,
              'Guitar',
            ),
            _openTunerButton(
              () => debugPrint('Ukelele pressed'),
              Icons.speed,
              'Ukulele',
            ),
            _openTunerButton(
              () => debugPrint('Bass pressed'),
              Icons.tune,
              'Bass',
            ),
            _openTunerButton(
              () => debugPrint('Violin pressed'),
              Icons.library_add_check,
              'Violin',
            ),
            _openTunerButton(
              () => debugPrint('Custom pressed'),
              Icons.radio,
              'Custom',
            ),
          ],
        ),
      ),
      ),
    );
  }
}
