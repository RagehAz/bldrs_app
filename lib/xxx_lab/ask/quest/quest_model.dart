class Quest {
  /// --------------------------------------------------------------------------
  Quest({this.id, this.body, this.userID});
  /// --------------------------------------------------------------------------
  factory Quest.fromMap(Map<String, dynamic>data) {
    return Quest(body: data['body']);
  }
  /// --------------------------------------------------------------------------
  final String id;
  final String body;
  final String userID;
/// --------------------------------------------------------------------------
}
