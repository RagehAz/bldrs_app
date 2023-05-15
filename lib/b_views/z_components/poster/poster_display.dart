import 'dart:typed_data';

import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scale/scale.dart';
import 'package:screenshot/screenshot.dart';

class PosterDisplay extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PosterDisplay({
    @required this.width,
    @required this.model,
    @required this.modelHelper,
    @required this.posterType,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double width;
  final dynamic model;
  final dynamic modelHelper;
  final PosterType posterType;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> capturePoster({
    @required BuildContext context,
    @required PosterType posterType,
    @required dynamic model,
    @required dynamic helperModel,
    double finalDesiredPicWidth,
    ScreenshotController controller,
  }) async{

    final ScreenshotController _controller = controller ?? ScreenshotController();
    final double _screenWidth = Scale.screenWidth(getMainContext());
    final double _finalDesiredWidth = finalDesiredPicWidth ?? Standards.posterDimensions.width;
    // final double _posterHeight = NotePosterBox.getBoxHeight(width);

    final Uint8List _bytes = await _controller.captureFromWidget(
      BldrsProviders(
        child: PosterDisplay(
        posterType: posterType,
        width: _screenWidth,
        model: model,
        modelHelper: helperModel,
      ),
      ),
      context: getMainContext(),
      /// FINAL PIC WIDTH = VIEW WIDTH * PIXEL RATIO
      //MediaQuery.of(_context).devicePixelRatio, no need to use this
      pixelRatio: _finalDesiredWidth / _screenWidth,
      delay: const Duration(milliseconds: 200),
    );

    return _bytes;

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,
      child: ChangeNotifierProvider(
        create: (_) => PhraseProvider(),
        lazy: false,
        child: PosterSwitcher(
          posterType: posterType,
          width: width,
          model: model,
          modelHelper: modelHelper,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
