import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/poster/structure/a_note_switcher.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PosterDisplay extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PosterDisplay({
    @required this.posterWidth,
    @required this.model,
    @required this.modelHelper,
    @required this.posterType,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double posterWidth;
  final dynamic model;
  final dynamic modelHelper;
  final PosterType posterType;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _posterHeight = NotePosterBox.getBoxHeight(posterWidth);

    return Material(
      type: MaterialType.transparency,
      child: ChangeNotifierProvider(
        create: (_) => PhraseProvider(),
        lazy: false,
        child: PosterSwitcher(
          posterType: posterType,
          width: _posterHeight,
          model: model,
          modelHelper: modelHelper,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
