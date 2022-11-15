// ignore_for_file: unnecessary_this

import 'package:gdr/classes/stage_map.dart';

import 'constants.dart';
import 'game_math.dart';

class Entity {
  StageMap _map;
  final Position _pos;

  Position get pos => _pos;

  StageMap get map => _map;
  set map(m) => _map = m;

  Entity(this._map, this._pos);

  void move(int amount, String direction) {
    // Input
    switch (direction) {
      case 'right':
        if (pos.x < mapSize.width - 1) {
          if (!map.hasBlockingCellAt(pos, moveAmountX: amount)) {
            pos.x += amount;
          }
        }
        break;
      case 'left':
        if (pos.x > 0) {
          if (!map.hasBlockingCellAt(pos, moveAmountX: -amount)) {
            pos.x -= amount;
          }
        }
        break;
      case 'up':
        if (pos.y > 0) {
          if (!map.hasBlockingCellAt(pos, moveAmountY: -amount)) {
            pos.y -= amount;
          }
        }
        break;
      case 'down':
        if (pos.y < mapSize.height - 1) {
          if (!map.hasBlockingCellAt(pos, moveAmountY: amount)) {
            pos.y += amount;
          }
        }
        break;
      default:
    }
  }
}

class Player extends Entity {
  Player(super.map, super.pos);
}
