import 'package:flutter/material.dart';
import 'dart:ui' as UI;

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../classes/stage_map.dart';
import 'package:gdr/classes/constants.dart';

import '../providers/entity_provider.dart';
import 'package:gdr/providers/map_provider.dart';

class GameWorld extends StatefulWidget {
  const GameWorld({
    Key? key,
  }) : super(key: key);

  @override
  State<GameWorld> createState() => _GameWorldState();
}

class _GameWorldState extends State<GameWorld> {
  late Future<Map<String, UI.Image>> _sprites;

  @override
  void initState() {
    _sprites = _loadAllSprites();

    super.initState();
  }

  Future<UI.Image> _loadImage(String imageName) async {
    ByteData bd = await rootBundle.load("assets/images/$imageName.png");
    final Uint8List bytes = Uint8List.view(bd.buffer);
    final UI.Codec codec = await UI.instantiateImageCodec(bytes);
    final UI.Image image = (await codec.getNextFrame()).image;

    return image;
  }

  Future<Map<String, UI.Image>> _loadAllSprites() async {
    // it is used to set the initial state of async loading in builder
    Map<String, UI.Image> map = <String, UI.Image>{
      'playerImage': await _loadImage("player"),
      'grass': await _loadImage("grass"),
      'stoneWall': await _loadImage("stoneWall"),
      'woodenDoor': await _loadImage("woodenDoor"),
      'goblin': await _loadImage('goblin'),
    };
    // Theese can await

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, UI.Image>>(
        future: _sprites,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, UI.Image>> snapshot) {
          Widget customPaint;
          if (snapshot.hasData) {
            customPaint = CustomPaint(
              size: MediaQuery.of(context).size,
              painter: GamePainter(context, snapshot.data!),
            );
          } else {
            customPaint = Container(
              color: Colors.black,
            );
          }
          return Container(
            color: Colors.black87,
            child: customPaint,
          );
        });
  }
}

class GamePainter extends CustomPainter {
  final Map<String, UI.Image> _sprites;

  final Paint _paint = Paint()..color = Colors.white;

  final BuildContext _context;

  GamePainter(this._context, this._sprites) {
    _context.read<Entities>().context = _context;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (Cell cell in _context.read<Maps>().currentMap.mapCells) {
      /*
      _paint.color = cell.type.color;
      canvas.drawRect(
          Rect.fromLTWH(cell.pos.x * cellSize, cell.pos.y * cellSize,
              cellSize + .3, cellSize + .3),
          _paint);
      */
      paintImage(
          canvas: canvas,
          rect: Rect.fromLTWH(cell.pos.x * cellSize, cell.pos.y * cellSize,
              cellSize + .3, cellSize + .3),
          image: _sprites[cell.type.sprite]!);
    }

    // Draw entities
    for (var entity in _context.read<Maps>().currentMap.mapEntities) {
      /*
      canvas.drawRect(
          Rect.fromLTWH(entity.pos.x * cellSize, entity.pos.y * cellSize,
              cellSize + .3, cellSize + .3),
          _paint);
      */

      canvas.drawImage(_sprites['goblin']!,
          Offset(entity.pos.x * cellSize, entity.pos.y * cellSize), _paint);
    }

    //R_paint.color = Colors.red;
    // _context.read<Entities>().player.pos.y * 16.0
    /*
    canvas.drawRect(
        Rect.fromLTWH(
            _context.read<Entities>().player.pos.x * cellSize,
            _context.read<Entities>().player.pos.y * cellSize,
            cellSize,
            cellSize),
        _paint);
    */

    canvas.drawImage(
        _sprites['playerImage']!,
        Offset(
          _context.read<Entities>().player.pos.x * cellSize,
          _context.read<Entities>().player.pos.y * cellSize,
        ),
        _paint);

    // Bordi arrotondati schermo
    _paint
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawRRect(
        RRect.fromLTRBR(
          -1,
          -1,
          size.width + 2,
          size.height + 2,
          const Radius.circular(4),
        ),
        _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
