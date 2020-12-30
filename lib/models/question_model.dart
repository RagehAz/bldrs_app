class Question {
  final String id;
  final String body;
  final String userID;

  Question({this.id, this.body, this.userID});

  factory Question.fromMap(data) {
    return Question(body: data['body']);
  }
}
