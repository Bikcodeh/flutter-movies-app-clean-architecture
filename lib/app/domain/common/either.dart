class Either<Left, Right> {
  final Left? _left;
  final Right? _right;
  final bool isLeft;

  Either._(this._left, this._right, this.isLeft);

  factory Either.left(Left left) {
    return Either._(left, null, true);
  }

  factory Either.right(Right right) {
    return Either._(null, right, false);
  }

  R fold<R>(
    R Function(Left) left,
    R Function(Right) right,
  ) {
    if (isLeft) {
      return left(_left as Left);
    } else {
      return right(_right as Right);
    }
  }

  Right? get right {
    return _right;
  }

  Left? get left {
    return _left;
  }
}
