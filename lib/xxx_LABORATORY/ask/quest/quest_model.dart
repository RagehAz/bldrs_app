class Quest {
  final String id;
  final String body;
  final String userID;

  Quest({this.id, this.body, this.userID});

  factory Quest.fromMap(data) {
    return Quest(body: data['body']);
  }
}
