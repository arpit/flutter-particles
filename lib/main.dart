import 'package:flutter/material.dart';
import 'particle_field_painter.dart';
import 'particle_field.dart';
import 'components/sprite_sheet.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
@override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  SpriteSheet _spriteSheet;
  ParticleField _particleField;
  Ticker _ticker;

  @override
  void initState() {
    _spriteSheet = SpriteSheet(
      imageProvider: AssetImage("images/circle_spritesheet.png"),
      length: 15, // number of frames in the sprite sheet.
      frameWidth: 10,
      frameHeight: 10,
    );

    _particleField = ParticleField();
    _ticker = createTicker(_particleField.tick)..start();
    super.initState();
  }

  void _explode(){
    double x = 100;
    double y = 100;
    double w = 200;
    _particleField.pointExplosion(x, y , 100, 0xffFF009B);
  }

  void _explodeLine(){
    double x = 100;
    double y = 100;
    double w = 200;

    _particleField.lineExplosion(x, y, w);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xff23243D),
                  height: 200,
                ),
              ),
              FlatButton(
                child: Text("Explode"),
                onPressed: ()=> _explode(),
              ),
              FlatButton(
                child: Text("Explode Line"),
                onPressed: ()=> _explodeLine(),
              )
            ],
          ),
          Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: ParticleFieldPainter(field: _particleField, spriteSheet: _spriteSheet)),
              )),
        ],
      )

    );
  }
}
