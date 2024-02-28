import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';

class InstaPost{
  // --------------------------------------------------------------------------
  const InstaPost({
    required this.id,
    required this.mediaURL,
    required this.caption,
    required this.mediaType,
    required this.mediaProductType,
    required this.permalink,
    required this.thumbnailURL,
    required this.children,
  });
  // --------------------
  final String id;
  final String? mediaURL;
  final String? caption;
  final String? mediaType;
  final String? mediaProductType;
  final String? permalink;
  final String? thumbnailURL;
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

    if (map?['id'] != null){

      _output = InstaPost(
        id: map!['id'],
        mediaURL: map['media_url'],
        caption: map['caption'],
        mediaProductType: map['media_product_type'],
        mediaType: map['media_type'],
        permalink: map['permalink'],
        thumbnailURL: map['thumbnail_url'],
        children: decipherPosts(mediaMap: map['children']),
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
