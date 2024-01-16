/// The position of the actions.
enum ActionPosition {
  /// Start position
  start,

  /// End position
  end;

  /// Check if the action position is start
  bool get isStart => this == start;

  /// Check if the action position is end
  bool get isEnd => this == end;
}
