import 'package:bldrs/models/author_model.dart';
import 'package:bldrs/models/connection_model.dart';
import 'package:flutter/foundation.dart';
import './co_user.dart';

class CoAuthor {
  final AuthorModel author;
  final CoUser coUser;
  List<ConnectionModel> connections;
  List<String> authorFlyersIDs;

  CoAuthor({
    @required this.author,
    @required this.coUser,
    @required this.connections,
    @required this.authorFlyersIDs,
  });
}
