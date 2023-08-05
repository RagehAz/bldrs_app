import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';

class BzTypesWheel extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzTypesWheel({
    required this.pageZoneHeight,
    required this.width,
    super.key,
  });
  // --------------------
  final double pageZoneHeight;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  State<BzTypesWheel> createState() => _BzTypesWheelState();
}

class _BzTypesWheelState extends State<BzTypesWheel> {
  /// --------------------------------------------------------------------------
  int _selectedBzTypeIndex = 0;
  static const List<BzType> _bzTypes = [
    BzType.designer,
    BzType.contractor,
    BzType.artisan,
    BzType.manufacturer,
    BzType.supplier,
    BzType.developer,
    BzType.broker,
  ];
  /// --------------------------------------------------------------------------
  double? _zeroDegree = 90;

  @override
  void initState() {

    _zeroDegree = _getDegreeByType(BzType.designer);

    super.initState();
  }
  /// --------------------------------------------------------------------------
  double _getDegreeByType(BzType bzType){

    final double _stepDegree = 360 / _bzTypes.length;

    double _deg = 0;

    switch(bzType){
      case BzType.designer:     _deg = 90;                    break;
      case BzType.contractor:   _deg = 90 - _stepDegree;      break;
      case BzType.artisan:      _deg = 90 - (_stepDegree*2);  break;
      case BzType.manufacturer: _deg = 90 - (_stepDegree*3);  break;
      case BzType.supplier:     _deg = 90 - (_stepDegree*4);  break;
      case BzType.developer:    _deg = 90 - (_stepDegree*5);  break;
      case BzType.broker:       _deg = 90 - (_stepDegree*6);  break;
    }

    return Numeric.move360Degree(source360Degree: 0, moveBy360Degree: _deg)!;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxHeight = widget.pageZoneHeight;
    final double _titleBoxHeight = _boxHeight * 0.1;
    final double _topSpacingHeight = _boxHeight * 0.02;
    final double _circleDiameter = _boxHeight * 0.5;
    final double _middleSpacingHeight = _topSpacingHeight;
    final double _textZoneHeight = _boxHeight
        -_titleBoxHeight
        -_topSpacingHeight
        - _circleDiameter
        - _middleSpacingHeight;
    // --------------------
    final double _circleRadius = _circleDiameter * 0.5;
    const Offset _circleOrigin = Offset.zero;
    // --------------------
    final double _bzTypeCircleSize = _circleDiameter * 0.2;
    final double _innerRadius = _circleRadius * 0.6;
    // --------------------
    /// final double _stepDegree = 360 / _bzTypes.length;
    // --------------------
    return Column(
      children: [

        /// HEADLINE
        Container(
          width: widget.width,
          height: _titleBoxHeight,
          color: Colorz.bloodTest,
        ),

        /// TOP SPACER
        Spacing(
          size: _topSpacingHeight,
        ),

        /// WHEEL
        SizedBox(
          width: _circleDiameter,
          height: _circleDiameter,
          child: CircleList(

            /// ANIMATION
            animationSetting: AnimationSetting(
              curve: Curves.ease,
              duration: const Duration(seconds: 1),
            ),

            /// SCALING
            origin: _circleOrigin,
            outerRadius: _circleRadius,
            innerRadius: _innerRadius,
            childrenPadding: 0,
            initialAngle: Numeric.degreeToRadian(_zeroDegree)!,

            /// BEHAVIOUR
            // dragAngleRange: ,
            // innerCircleRotateWithChildren: false,
            // onDragEnd: ,
            // onDragStart: ,
            // onDragUpdate: (PolarCoord coord){
            //
            //   final double _d = Numeric.radianTo360Degree(coord.angle)!;
            //   // final double _zeroDegreeFixed = Numeric.degreeTo360Degree(_zeroDegree)!;
            //   // final double _fixed = _degree - _zeroDegreeFixed;
            //
            //   final double _theZero = Numeric.move360Degree(
            //       source360Degree: _d,
            //       moveBy360Degree: 90,
            //   )!;
            //
            //   blog('_d : $_d : theZero : $_theZero');
            //
            //   final int? _quotient = Numeric.getDivisionQuotient(
            //     dividend: _theZero,
            //     divisor: _stepDegree,
            //   );
            //
            //   final int _newIndex = Numeric.reverseIndex(
            //       listLength: 7,
            //       index: _quotient,
            //   )!;
            //
            //   // final int _newIndex = _quotient!;
            //
            //   // final double _z = Numeric.roundFractions(_theZero, 2)!;
            //   // blog('_newIndex : $_zᴼ : $_newIndex');
            //
            //   if (_selectedBzTypeIndex != _newIndex){
            //     setState(() {
            //       _selectedBzTypeIndex = _newIndex;
            //     });
            //   }
            //
            //   },
            rotateMode: RotateMode.stopRotate,
            // isChildrenVertical: true,
            showInitialAnimation: true,

            /// STYLING
            // gradient: ,
            innerCircleColor: Colorz.nothing,
            outerCircleColor: Colorz.white10,

            /// CENTER WIDGET
            centerWidget: BldrsBox(
              height: _bzTypeCircleSize,
              corners: _bzTypeCircleSize * 0.5,
              icon: UsersProvider.proGetMyUserModel(context: context, listen: true)?.picPath,
            ),

            children: [

              ...List.generate(_bzTypes.length, (index){

                final BzType _bzType = _bzTypes[index];
                final bool _isSelected = index == _selectedBzTypeIndex;
                final String _icon = _isSelected == true ?
                BzTyper.getBzTypeIconOn(_bzType)!
                :
                BzTyper.getBzTypeIconOff(_bzType)!
                ;

                return BldrsBox(
                  height: _bzTypeCircleSize,
                  // width: _bzTypeCircleSize,
                  // verse: Verse.plain(index.toString()),
                  // verseScaleFactor: 0.4,
                  verseWeight: VerseWeight.thin,
                  verseMaxLines: 3,
                  corners: _bzTypeCircleSize * 0.5,
                  icon: _icon,
                  onTap: () async {

                    await Future.delayed(const Duration(milliseconds: 100));

                    setState(() {
                      _selectedBzTypeIndex = index;
                    });

                  },
                );

              }),

            ],

          ),
        ),

        /// MIDDLE SPACER
        Spacing(
          size: _middleSpacingHeight,
        ),

        /// BZ TYPE NAME
        BldrsBox(
          width: widget.width,
          height: _textZoneHeight * 0.2,
          verse: Verse(
            id: BzTyper.getBzTypePhid(
              bzType: _bzTypes[_selectedBzTypeIndex],
              nounTranslation: false,
              // pluralTranslation: true,
            ),
            translate: true,
            casing: Casing.upperCase,
          ),
          verseItalic: true,
          bubble: false,
        ),

        /// PARAGRAPH
        Container(
          width: widget.width,
          height: _textZoneHeight * 0.8,
          color: Colorz.bloodTest,
          child: BldrsText(
            width: widget.width,
            height: _textZoneHeight * 0.8,
            verse: Verse(
              id: BzTyper.getBzTypeAskHintPhid(_bzTypes[_selectedBzTypeIndex]),
              translate: true,
            ),
            // centered: true,
            scaleFactor: _textZoneHeight  * 0.005,
            maxLines: 20,
            labelColor: Colorz.blue80,
          ),
        ),

      ],
    );
    // --------------------
  }
}
