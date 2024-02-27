import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';

class InstaPost{
  // --------------------------------------------------------------------------
  const InstaPost({
    required this.id,
    required this.url,
    required this.children,
  });
  // --------------------
  final String id;
  final String url;
  final List<InstaPost> children;
  // -----------------------------------------------------------------------------

  ///  CYPHERS

  // --------------------
  ///
  static List<InstaPost> decipherPosts({
    required Map<String, dynamic>? mediaMap,
  }){
    final List<InstaPost> _output = [];

    if (mediaMap != null){

      final List<Map<String, dynamic>> _postsMaps = Mapper.getMapsFromDynamics(
        dynamics: mediaMap['data'],
      );

      if (Lister.checkCanLoop(_postsMaps) == true){

        for (final Map<String, dynamic> map in _postsMaps){

          final InstaPost? _post = decipherPost(
            map: map,
          );

          if (_post != null){
            _output.add(_post);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static InstaPost? decipherPost({
    required Map<String, dynamic>? map,
  }){
    InstaPost? _output;

    if (map != null){

      _output = InstaPost(
        id: map['id'],
        url: map['media_url'],
        children: decipherPosts(
          mediaMap: map['children'],
        ),
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
