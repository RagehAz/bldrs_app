import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
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
  // --------------------
  final ProgressModel progressModel;
  // --------------------
  static const double stateButtonWidth = 110;
  static const double padding = 5;
  static const double height = 25;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        DreamBox(
          height: height,
          width: stateButtonWidth,
          verse: Verse.plain(ProgressModel.getProgressString(progressModel.state)),
          color: ProgressModel.getProgressColor(progressModel.state),
          icon: ProgressModel.getProgressIcon(progressModel.state),
          margins: const EdgeInsets.only(bottom: 2, right: padding),
          verseCentered: false,
          verseScaleFactor: 1.4,
          bubble: false,
          loading: progressModel.state == ProgressState.waiting,
          verseWeight: VerseWeight.black,
          corners: height * 0.3,
        ),

        Column(
          children: <Widget>[

            DreamBox(
              height: height,
              width: BldrsAppBar.width(context) - stateButtonWidth - padding,
              verse: Verse.plain(progressModel.title),
              color: ProgressModel.getProgressColor(progressModel.state),
              margins: const EdgeInsets.only(bottom: 2),
              verseCentered: false,
              verseScaleFactor: 1.4,
              bubble: false,
              verseWeight: VerseWeight.thin,
              corners: height * 0.3,
            ),

            if (progressModel?.args != null)
            ArgsLines(
              args: progressModel.args,
            ),

            // if (Mapper.checkCanLoopList(_argsKeys) == true)
            //   ...List.generate(_argsKeys.length, (index) {
            //
            //     final String _key = _argsKeys[index];
            //
            //     return DreamBox(
            //       height: height * 0.7,
            //       width: BldrsAppBar.width(context) - stateButtonWidth - padding,
            //       verse: Verse.plain('$_key : ${progressModel.args[_key]}'),
            //       color: ProgressModel.getProgressColor(progressModel.state),
            //       margins: const EdgeInsets.only(bottom: 2),
            //       verseCentered: false,
            //       verseScaleFactor: 1.4,
            //       bubble: false,
            //       verseWeight: VerseWeight.thin,
            //       corners: height * 0.3,
            //       verseColor: Colorz.yellow200,
            //       verseItalic: true,
            //     );
            //   }
            //   ),

          ],
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}

class ArgsLines extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const ArgsLines({
    @required this.args,
    Key key
  }) : super(key: key);
  // --------------------
  final Map<String, dynamic> args;
  // -----------------------------------------------------------------------------
  @override
  State<ArgsLines> createState() => _ArgsLinesState();
  // -----------------------------------------------------------------------------
}

class _ArgsLinesState extends State<ArgsLines> {
  // -----------------------------------------------------------------------------
  bool _showArgs = false;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _argsKeys = widget.args?.keys?.toList();

    return Column(
      children: <Widget>[

        DreamBox(
          height: ProgressLine.height * 0.7,
          width: BldrsAppBar.width(context) - ProgressLine.stateButtonWidth - ProgressLine.padding,
          verse: Verse.plain('${_argsKeys.length} Keys'),
          color: Colorz.white10,
          margins: const EdgeInsets.only(bottom: 2),
          verseCentered: false,
          verseScaleFactor: 1.4 / 0.6,
          bubble: false,
          verseWeight: VerseWeight.thin,
          corners: ProgressLine.height * 0.3,
          verseColor: Colorz.yellow200,
          verseItalic: true,
          icon: _showArgs == true ? Iconz.arrowDown : Iconz.arrowRight,
          iconSizeFactor: 0.6,
          onTap: (){

            setState(() {
              _showArgs = !_showArgs;
            });

          },
        ),

        if (Mapper.checkCanLoopList(_argsKeys) == true && _showArgs == true)
          ...List.generate(_argsKeys.length, (index) {

            final String _key = _argsKeys[index];

            return DreamBox(
              height: ProgressLine.height * 0.7,
              width: BldrsAppBar.width(context) - ProgressLine.stateButtonWidth - ProgressLine.padding,
              verse: Verse.plain('$_key : ${widget.args[_key]}'),
              color: Colorz.white10,
              margins: const EdgeInsets.only(bottom: 2),
              verseCentered: false,
              verseScaleFactor: 1.4,
              bubble: false,
              verseWeight: VerseWeight.thin,
              corners: ProgressLine.height * 0.3,
              verseColor: Colorz.yellow200,
              verseItalic: true,
              onTap: () => Keyboard.copyToClipboard(
                context: context,
                copy: widget.args[_key]?.toString(),
              ),
            );

          }),

      ],
    );
  }
  // -----------------------------------------------------------------------------
}
