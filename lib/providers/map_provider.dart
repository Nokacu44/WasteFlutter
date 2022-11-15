import 'package:flutter/foundation.dart';
import 'package:gdr/classes/constants.dart';
import 'package:gdr/classes/stage_map.dart';

class Maps with ChangeNotifier {
  StageMap _currentMap = firstMap;

  StageMap get currentMap => _currentMap;

  void changeMap(StageMap newMap) {
    _currentMap = newMap;
    notifyListeners();
  }
}
