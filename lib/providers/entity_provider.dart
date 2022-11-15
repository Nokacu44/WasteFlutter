import 'package:flutter/material.dart';
import 'package:gdr/classes/constants.dart';
import 'package:gdr/classes/entity.dart';
import 'package:gdr/classes/stage_map.dart';
import 'package:gdr/providers/map_provider.dart';
import 'package:gdr/providers/status_messages_provider.dart';

import '../classes/game_math.dart';
import 'package:provider/provider.dart';

class Entities with ChangeNotifier {
  BuildContext? _context;
  BuildContext? get context => _context;
  set context(c) => _context = c;

  final Entity _player = Player(
    firstMap,
    Position(0, 0),
  );

  Entity get player => _player;

  void printPosition() {
    print("$_player position: ${_player.pos}");
  }

  void executePlayerFunction(Function function) {
    function.call();
    print("Player pos ${player.pos} ");

    // Compute state
    var cell = player.map.getCellAtPos(player.pos);

    // Check close to enemy
    for (var enemy in player.map.mapEntities) {
      if (enemy.pos.isNextTo(player.pos)) {
        _context?.read<StatusMessages>().changeMessage(
              Message("Attaccato da $enemy", type: Message.RED),
            );
        break;
      }
    }

    if (cell is DoorCell) {
      _context?.read<Maps>().changeMap(secondMap);
      player.map = secondMap;
    } else {
      _context?.read<StatusMessages>().changeMessage(
            cell.type.isEffectNull()
                ? Message(cell.type.applyEffect(player))
                : null,
          );
    }

    notifyListeners();
  }

  void executeEntityFunction(Entity entity, Function function) {
    function.call();

    // Compute state
    var cell = entity.map.getCellAtPos(entity.pos);
    cell.type.applyEffect(entity);

    notifyListeners();
  }
}
