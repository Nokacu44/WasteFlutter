class Position {
// Constants Positions
  static final Position up = Position(0, -1);
  static final Position down = Position(0, 1);
  static final Position left = Position(-1, 0);
  static final Position right = Position(1, 0);

  num _x;
  num _y;

  num get x => _x;
  num get y => _y;

  set y(y) => _y = y;
  set x(x) => _x = x;

  Position(this._x, this._y);

  bool isNextTo(Position pos) {
    if ((this + up) == pos) return true;
    if ((this + down) == pos) return true;
    if ((this + left) == pos) return true;
    if ((this + right) == pos) return true;
    return false;
  }

  @override
  String toString() => '{$_x,$_y}';

  @override
  bool operator ==(Object other) =>
      other is Position &&
      other.runtimeType == runtimeType &&
      other._x == _x &&
      other._y == _y;
  Position operator +(Position other) => Position(_x + other._x, _y + other._y);
}
