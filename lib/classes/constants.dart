import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdr/classes/stage_map.dart';
import 'dart:ui' as UI;

const double buttonSize = 72;

const double cellSize = 16;
const Size mapSize = Size(20, 20);

// Cell types
CellType erba = CellType('erba', (_) {}, "grass");
CellType mattoni = CellType('mattoni', (_) {}, "stoneWall", block: true);
CellType woodenDoor = CellType('woodenDoor', (_) {}, "woodenDoor");
CellType poisonedDoor = CellType('woodenDoor', (_) {
  // poison player
}, "woodenDoor");

// Maps LE MAPPE NON SONO COSTANTI PER ORA LE RENDO COSTANTI PER DEBUG (IL LORO CONTENUTO NON E' MAIIII COSTANTE)
StageMap firstMap = StageMap(
  [
    '####################',
    '.@..................',
    '....................',
    '....................',
    '....................',
    '....................',
    '....................',
    '.............###....',
    '.............#.#....',
    '....................',
    '....................',
    '....................',
    '...........###......',
    '....................',
    '.......###..........',
    '........#...........',
    '........#...........',
    '....................',
    '....................',
    '####################',
  ],
);

StageMap secondMap = StageMap(
  [
    '####################',
    '....................',
    '....................',
    '....................',
    '....................',
    '.............###....',
    '...............#....',
    '...............#....',
    '.........#######....',
    '.........#...@......',
    '.........#..........',
    '.........#..........',
    '....................',
    '....................',
    '....................',
    '....................',
    '....................',
    '....................',
    '....................',
    '####################',
  ],
);

// Ui
Widget spaceSizedBox = const SizedBox(
  width: buttonSize,
  height: buttonSize,
);
