import 'dart:math';
import 'package:gdr/classes/game_math.dart';

import 'constants.dart';
import 'entity.dart';

class CellType {
  final bool block;
  final String _sprite;
  final String _typeName;
  final Function(Entity) _effect;

  CellType(this._typeName, this._effect, this._sprite, {this.block = false});

  String get typeName => _typeName;
  String get sprite => _sprite;

  bool isEffectNull() {
    if (_effect.runtimeType.toString().endsWith("=> Null")) {
      return true;
    }
    return false;
  }

  String applyEffect(Entity entity) {
    if (isEffectNull()) return "";
    return "Effetto $_effect applicato a $entity";
  }

  @override
  String toString() => typeName;
}

class Cell {
  final Position _pos;
  final CellType _type;

  Position get pos => _pos;
  CellType get type => _type;

  Cell(this._pos, this._type);

  @override
  String toString() => 'Cell{$pos}-type{$type}';
}

class DoorCell extends Cell {
  final StageMap? _nextMap;
  StageMap? get nextMap => _nextMap;

  DoorCell(super.pos, super.type, this._nextMap);
  @override
  String toString() => 'DoorCell{$pos}-type{$type}';
}

class StageMap {
  // TODO: list entity
  // TODO: list oggetti
  final List<String> _map;

  final List<Cell> _mapCells = [];
  List<Cell> get mapCells => _mapCells;

  final List<DoorCell> _doorCells = [];
  List<DoorCell> get doorCells => _doorCells;

  final List<Cell> _blockingCells = [];

  List<Cell> get blockingCells => _blockingCells;

  // DEBUG
  List<Entity> mapEntities = [];

  bool hasBlockingCellAt(Position pos,
      {int moveAmountX = 0, int moveAmountY = 0}) {
    return _blockingCells.any((cell) {
      return cell.pos.x == pos.x + moveAmountX &&
          cell.pos.y == pos.y + moveAmountY;
    });
  }

  Cell getCellAtPos(Position pos) {
    return mapCells.firstWhere(
      (cell) => cell.pos == pos,
      orElse: () => null as Cell,
    );
  }

  void _populateMap() {
    for (var y = 0; y < 20; y++) {
      for (var x = 0; x < 20; x++) {
        Cell cell;

        // TODO: Rivedere sta robbbba
        switch (_map[y][x]) {
          case '.':
            cell = Cell(Position(x, y), erba);
            break;
          case '#':
            cell = Cell(Position(x, y), mattoni);
            break;
          case '@':
            cell = DoorCell(Position(x, y), woodenDoor, null);
            _doorCells.add(cell as DoorCell);
            break;
          default:
            cell = Cell(Position(x, y), erba);
            break;
        }
        if (cell.type.block == true) _blockingCells.add(cell);
        _mapCells.add(cell);
      }
    }
  }

  void _randomGenerateEntities(int numberOfEntities) {
    for (var i = 0; i < numberOfEntities; i++) {
      var pos = Position(0, 0); // Necessario crearlo?
      do {
        pos.x = Random().nextInt(20);
        pos.y = Random().nextInt(20);
      } while (hasBlockingCellAt(pos));

      mapEntities.add(Entity(this, pos));
    }
  }

  StageMap(this._map) {
    // DEBUG
    _populateMap();
    _randomGenerateEntities(4);
  }
}
