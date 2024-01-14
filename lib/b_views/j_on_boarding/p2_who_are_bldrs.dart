import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/j_on_boarding/components/bz_types_wheel.dart';
import 'package:bldrs/b_views/j_on_boarding/components/onboarding_headline.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BWhoAreBldrs extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BWhoAreBldrs({
    super.key
  });

  @override
  State<BWhoAreBldrs> createState() => _BWhoAreBldrsState();
}

class _BWhoAreBldrsState extends State<BWhoAreBldrs> {
  // --------------------------------------------------------------------------
  BzType? _bzType = BzType.designer;
  bool _autoPlayMode = true;
  // --------------------
  @override
  void initState() {
    super.initState();

    _autoPlay();
  }
  // --------------------
  Future<void> _autoPlay() async {

    if (_autoPlayMode == true){

      await Future.delayed(const Duration(seconds: 2));

      BzType? _nextType;

      if (_bzType == null){
        _nextType = BzType.designer;
      }
      else {
        final int _index = BzTyper.bzTypesList.indexOf(_bzType!);
        final int _nextIndex = Numeric.getNextIndex(
          listLength: BzTyper.bzTypesList.length,
          currentIndex: _index,
          loop: false,
        )!;

        if (_index == _nextIndex){
          _nextType = null;
        }
        else {
          _nextType = BzTyper.bzTypesList[_nextIndex];
        }

      }

      if (mounted == true && _autoPlayMode == true){
        setState(() {
          _bzType = _nextType;
        });

        if (_autoPlayMode == true){
          await _autoPlay();
        }

      }

    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double width = OnBoardingScreen.getBubbleWidth();
    final double height = OnBoardingScreen.getPagesZoneHeight();
    final double pageZoneHeight = OnBoardingScreen.getPagesZoneHeight();
    // --------------------
    final double _topSpacingHeight = OnBoardingScreen.getSpacingsSize();
    final double _middleSpacingHeight = _topSpacingHeight;
    final double _textZoneHeight = OnBoardingScreen.getBelowWheelTextZoneHeight();
    // --------------------
    /// final double _stepDegree = 360 / _bzTypes.length;
    // --------------------
    return FloatingList(
      width: width,
      height: height,
      mainAxisAlignment: MainAxisAlignment.start,
      boxAlignment: Alignment.topCenter,
      columnChildren: <Widget>[

        /// HEADLINE
        const OnBoardingHeadline(
          phid: 'phid_whoAreBldrs',
        ),

        /// TOP SPACER
        Spacing(
          size: _topSpacingHeight,
        ),

        /// WHEEL
        BzTypesWheel(
          width: width,
          pageZoneHeight: pageZoneHeight,
          bzType: _bzType,
          onBzTypeTap: (BzType? bzType){
            setState(() {
              _autoPlayMode = false;
              _bzType = bzType;
            });
          },
        ),

        /// MIDDLE SPACER
        Spacing(
          size: _middleSpacingHeight,
        ),

        /// BZ TYPE NAME
        BldrsText(
          width: width * 0.9,
          scaleFactor: _textZoneHeight * 0.01,
          // height: _textZoneHeight * 0.2,
          verse: Verse(
            id: _bzType == null ? 'phid_owner': BzTyper.getBzTypePhid(
              bzType: _bzType,
              nounTranslation: false,
              // pluralTranslation: true,
            ),
            translate: true,
            casing: Casing.upperCase,
          ),
          italic: true,
          maxLines: 2,
          color: Colorz.yellow255,
          shadow: true,
        ),

        /// PARAGRAPH
        BldrsText(
          width: width,
          // height: _textZoneHeight * 0.8,
          verse: Verse(
            id: BzTyper.getBzTypeWhoArePhid(_bzType),
            translate: true,
          ),
          // centered: true,
          scaleFactor: _textZoneHeight  * 0.006,
          maxLines: 50,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          weight: VerseWeight.thin,
          italic:  true,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
