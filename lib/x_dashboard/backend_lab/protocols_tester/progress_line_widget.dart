import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/backend_lab/protocols_tester/progress_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class ProgressLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ProgressLine({
    @required this.progressModel,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final ProgressModel progressModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _stateButtonWidth = 110;
    const double _padding = 5;
    const double _height = 25;

    final List<String> _argsKeys = progressModel.args?.keys?.toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        DreamBox(
          height: _height,
          width: _stateButtonWidth,
          verse: Verse.plain(ProgressModel.getProgressString(progressModel.state)),
          color: ProgressModel.getProgressColor(progressModel.state),
          icon: ProgressModel.getProgressIcon(progressModel.state),
          margins: const EdgeInsets.only(bottom: 2, right: _padding),
          verseCentered: false,
          verseScaleFactor: 1.4,
          bubble: false,
          loading: progressModel.state == ProgressState.waiting,
          verseWeight: VerseWeight.black,
          corners: _height * 0.3,
        ),

        Column(
          children: <Widget>[

            DreamBox(
              height: _height,
              width: BldrsAppBar.width(context) - _stateButtonWidth - _padding,
              verse: Verse.plain(progressModel.title),
              color: ProgressModel.getProgressColor(progressModel.state),
              margins: const EdgeInsets.only(bottom: 2),
              verseCentered: false,
              verseScaleFactor: 1.4,
              bubble: false,
              verseWeight: VerseWeight.thin,
              corners: _height * 0.3,
            ),

            if (Mapper.checkCanLoopList(_argsKeys) == true)
              ...List.generate(_argsKeys.length, (index) {

                final String _key = _argsKeys[index];

                return DreamBox(
                  height: _height * 0.7,
                  width: BldrsAppBar.width(context) - _stateButtonWidth - _padding,
                  verse: Verse.plain('$_key : ${progressModel.args[_key]}'),
                  color: ProgressModel.getProgressColor(progressModel.state),
                  margins: const EdgeInsets.only(bottom: 2),
                  verseCentered: false,
                  verseScaleFactor: 1.4,
                  bubble: false,
                  verseWeight: VerseWeight.thin,
                  corners: _height * 0.3,
                  verseColor: Colorz.yellow200,
                  verseItalic: true,
                );
              }
              ),

          ],
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
