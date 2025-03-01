import 'package:flutter/material.dart'; 

void main() => runApp(TuaniTune());

class TuaniTune extends StatelessWidget {
  const TuaniTune({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "Tunaitune",
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TuaniTune", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(0, 57, 230, 1.0),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 30),
        actions: const [
          Icon(Icons.settings)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          ElevatedButton(
            onPressed: () => print('Chromatic pressed'),
            child: Text('Chromatic', textAlign: TextAlign.center,),
          ),
          ElevatedButton(
            onPressed: () => print('Guitar pressed'),
            child: Text('Guitar', textAlign: TextAlign.center,),
          ),
          ElevatedButton(
            onPressed: () => print('Ukelele pressed'),
            child:Text('Ukulele'),
          ),
          ElevatedButton(
            onPressed: () => print('Bass pressed'),
            child:Text('Bass'),
          ),
          ElevatedButton(
            onPressed: () => print('Violin pressed'),
            child:Text('Violin'),
          ),
          ElevatedButton(
            onPressed: () => print('Ukelele pressed'),
            child: Text('Custom'),
          ),
        ],
      ),
    );
  }
}
