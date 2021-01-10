import 'package:bldrs/models/author_model.dart';
import 'package:bldrs/models/connection_model.dart';
import './co_user.dart';

class CoAuthor {
  final AuthorModel author;
  final CoUser coUser;
  List<ConnectionModel> connections;
  List<String> authorFlyersIDs;

  CoAuthor({
    this.author, // was @required
    this.coUser, // was @required
    this.connections, // was @required
    this.authorFlyersIDs, // was @required
  });
}
