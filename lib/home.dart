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
            color: Color.fromRGBO(153, 233, 242, 1.0), // Color del borde
            width: 2.0, // Grosor del border),
          ),
          borderRadius:BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(16), // Margen de 16 en todos los lados
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            ElevatedButton(
              onPressed: () => print('Chromatic pressed'),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                children: [
                  Icon(Icons.graphic_eq, color: Colors.blue), // Ícono,
                  SizedBox(width: 8), // Espacio entre ícono y texto
                  Text('Chromatic', textAlign: TextAlign.center),
                ],
              )
            ),
            ElevatedButton(
              onPressed: () => print('Guitar pressed'),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    Icon(Icons.play_arrow, color: Colors.blue), // Ícono,
                    SizedBox(width: 8), // Espacio entre ícono y texto
                    Text('Guitar', textAlign: TextAlign.center),
                  ],
                )
            ),
            ElevatedButton(
              onPressed: () => print('Ukelele pressed'),
                child :Row(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    Icon(Icons.speed, color: Colors.blue), // Ícono,
                    SizedBox(width: 8), // Espacio entre ícono y texto
                    Text('Ukulele', textAlign: TextAlign.center),
                  ],
                )
            ),
            ElevatedButton(
              onPressed: () => print('Bass pressed'),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    Icon(Icons.tune, color: Colors.blue), // Ícono,
                    SizedBox(width: 8), // Espacio entre ícono y texto
                    Text('Bass', textAlign: TextAlign.center),
                  ],
                )
            ),
            ElevatedButton(
              onPressed: () => print('Violin pressed'),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    Icon(Icons.library_add_check, color: Colors.blue), // Ícono,
                    SizedBox(width: 8), // Espacio entre ícono y texto
                    Text('Violin', textAlign: TextAlign.center),
                  ],
                )
            ),
            ElevatedButton(
              onPressed: () => print('Custom pressed'),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    Icon(Icons.radio, color: Colors.blue), // Ícono,
                    SizedBox(width: 8), // Espacio entre ícono y texto
                    Text('Custom', textAlign: TextAlign.center),
                  ],
                )
            ),
          ],
        ),
      ),
      ),
    );
  }
}
