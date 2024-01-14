import 'dart:typed_data';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class PosterDisplay extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PosterDisplay({
    required this.width,
    required this.model,
    required this.modelHelper,
    required this.posterType,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double width;
  final dynamic model;
  final dynamic modelHelper;
  final PosterType? posterType;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> capturePoster({
    required BuildContext context,
    required PosterType? posterType,
    required dynamic model,
    required dynamic helperModel,
    double? finalDesiredPicWidth,
    ScreenshotController? controller,
  }) async{

    final ScreenshotController? _controller = controller ?? ScreenshotController();
    final double _screenWidth = Scale.screenWidth(context);
    final double _finalDesiredWidth = finalDesiredPicWidth ?? Standards.posterDimensions.width!;
    // final double _posterHeight = NotePosterBox.getBoxHeight(width);

    blog('capturing long widget');

    final Uint8List? _bytes = await _controller?.captureFromWidget(
      BldrsProviders(
        child: PosterDisplay(
        posterType: posterType,
        width: _screenWidth,
        model: model,
        modelHelper: helperModel,
      ),
      ),
      context: context,
      /// FINAL PIC WIDTH = VIEW WIDTH * PIXEL RATIO
      //MediaQuery.of(_context).devicePixelRatio, no need to use this
      pixelRatio: _finalDesiredWidth / _screenWidth,
      delay: const Duration(milliseconds: 500),
    );

    return _bytes;

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // return Material(
    //   type: MaterialType.transparency,
    //   child: ChangeNotifierProvider(
    //     create: (_) => PhraseProvider(),
    //     lazy: false,
    //     child: PosterSwitcher(
    //       posterType: posterType,
    //       width: width,
    //       model: model,
    //       modelHelper: modelHelper,
    //     ),
    //   ),
    // );

    return Material(
      type: MaterialType.transparency,
      child: PosterSwitcher(
        posterType: posterType,
        width: width,
        model: model,
        modelHelper: modelHelper,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

/*

=> BLOGGING POSTER :: path : storage/flyers/newDraft/poster : 117309 Bytes | [ (640.0)w x (320.0)h ] | owners : [TSeD2x4uGWZZ2jorkigQvfBNcUN2, z0Obwze3JLYjoEl6uVeXfo4Luup1] | 0.11 MB | 114.56 KB
=> BLOGGING POSTER :: path : storage/flyers/newDraft/poster : 99334 Bytes | [ (640.0)w x (320.0)h ] | owners : [TSeD2x4uGWZZ2jorkigQvfBNcUN2, z0Obwze3JLYjoEl6uVeXfo4Luup1] | 0.09 MB | 97.01 KB
 */
