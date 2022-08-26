import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoResultFound({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return const SuperVerse(
      verse: 'phid_nothing_found',
      // translate: true,
      verseCasing: VerseCasing.upperCase,
      size: 4,
      maxLines: 3,
      italic: true,
      margin: 40,
    );

  }
}
