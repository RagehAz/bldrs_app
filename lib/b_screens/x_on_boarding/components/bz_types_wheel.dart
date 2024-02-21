import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/circle_list/circle_list.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/b_screens/x_on_boarding/components/arc_text.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class BzTypesWheel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzTypesWheel({
    required this.pageZoneHeight,
    required this.width,
    required this.bzType,
    required this.onBzTypeTap,
    super.key,
  });
  // --------------------
  final double pageZoneHeight;
  final double width;
  final BzType? bzType;
  final Function(BzType? bzType) onBzTypeTap;
  // --------------------------------------------------------------------------
  int _getIndexByBzType(BzType bzType){
    return BzTyper.bzTypesList.indexOf(bzType);
  }
  // --------------------
  static double getStepDegree(){
    return 360 / BzTyper.bzTypesList.length;
  }
  // --------------------
  static double getDegreeByType(BzType bzType){

    final double _stepDegree = getStepDegree();

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
  // --------------------
  TextStyle _generateArcStyle({
    required BuildContext context,
    required BzSection bzSection,
  }){

    final bool _isSelected = bzType == null ?
    false
        :
    BzTyper.concludeBzSectionByBzTypes([bzType!]) == bzSection;
    final double _extraSize = _isSelected == true ? 0.0001 : 0;

    return BldrsText.createStyle(
      context: context,
      color: _isSelected == true ? Colorz.blue255 : Colorz.white50,
      weight: _isSelected == true ? VerseWeight.bold : VerseWeight.thin,
      scaleFactor: pageZoneHeight * (0.0015 + _extraSize),
    );

  }
  // --------------------
  String _getUserIcon(BuildContext context){

    final UserModel? _user = UsersProvider.proGetMyUserModel(context: context, listen: true);

    if (UserModel.userIsSignedUp(_user) == true){
      return _user!.picPath ?? Iconz.normalUser;
    }

    else {
      return Iconz.normalUser;
    }

  }
  // --------------------
  double _getUserIconSizeFactor(BuildContext context){
    final UserModel? _user = UsersProvider.proGetMyUserModel(context: context, listen: true);

    if (UserModel.userIsSignedUp(_user) == true){
      return 1;
    }

    else {
      return  0.7;
    }
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxHeight = pageZoneHeight;
    final double _circleDiameter = Scale.responsive(
        context: context,
        landscape: _boxHeight * 0.5,
        portrait: width * 0.8,
    );
    // --------------------
    final double _circleRadius = _circleDiameter * 0.5;
    const Offset _circleOrigin = Offset.zero;
    // --------------------
    final double _bzTypeCircleSize = _circleDiameter * 0.2;
    final double _innerRadius = _circleRadius * 0.6;
    // --------------------
    final double _stepDegree = getStepDegree();
    final double _halfStep = _stepDegree * 0.5;
    const double _zeroDegree = 90;
    // --------------------
    final bool _ownerIsSelected = bzType == null;
    // --------------------
    return Stack(
      children: <Widget>[

        /// CIRCLE
        BldrsBox(
          width: _circleDiameter,
          height: _circleDiameter,
          color: Colorz.white255.withOpacity(0.05),
          corners: _circleRadius,
          borderColor: Colorz.white20,
        ),

        /// REAL-ESTATE ARC TITLE
        SizedBox(
          width: _circleDiameter,
          height: _circleDiameter,
          child: BldrsArcText(
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            radius: _circleRadius,
            text: getWord('phid_realEstate'),
            startAngle: Numeric.degreeToRadian(90)!,
            textStyle: _generateArcStyle(
              context: context,
              bzSection: BzSection.realestate,
            ),
          ),
        ),

        /// CONSTRUCTION ARC TITLE
        SizedBox(
          width: _circleDiameter,
          height: _circleDiameter,
          child: BldrsArcText(
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            radius: _circleRadius,
            text: getWord('phid_construction'),
            startAngle: Numeric.degreeToRadian(180 + _halfStep + 10)!,
            textStyle: _generateArcStyle(
              context: context,
              bzSection: BzSection.construction,
            ),
          ),
        ),

        /// SUPPLIES ARC TITLE
        SizedBox(
          width: _circleDiameter,
          height: _circleDiameter,
          child: BldrsArcText(
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            radius: _circleRadius,
            text: getWord('phid_supplies'),
            startAngle: Numeric.degreeToRadian(-_halfStep)!,
            textStyle: _generateArcStyle(
              context: context,
              bzSection: BzSection.supplies,
            ),
          ),
        ),

        /// THE SEVEN BACK
        BldrsImage(
          width: _circleDiameter,
          height: _circleDiameter,
          pic: Iconz.theSevenBack,
        ),

        /// THE SEVEN FRONT
        BldrsImage(
          width: _circleDiameter,
          height: _circleDiameter,
          pic: BzTyper.getTheSevenArtwork(bzType),
          // iconColor: Colorz.yellow255,
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
            // showInitialAnimation: false,
            /// STYLING
            // gradient: ,
            innerCircleColor: Colorz.nothing,
            outerCircleColor: Colorz.nothing,
            /// CENTER WIDGET
            centerWidget: BldrsBox(
              height: _bzTypeCircleSize,
              corners: _bzTypeCircleSize * 0.5,
              icon: _getUserIcon(context),
              iconSizeFactor: _getUserIconSizeFactor(context),
              borderColor: _ownerIsSelected ? Colorz.yellow255 : null,
              iconColor: _ownerIsSelected ? Colorz.black255 : null,
              color: _ownerIsSelected == true ? Colorz.yellow255 : null,
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 100));
                onBzTypeTap(null);
              }
            ),
            children: <Widget>[

              ...List.generate(BzTyper.bzTypesList.length, (index){

                final BzType _bzType = BzTyper.bzTypesList[index];

                final bool _isSelected = bzType == null ?
                false
                :
                index == _getIndexByBzType(bzType!);

                final String _icon = BzTyper.getBzTypeIcon(_bzType)!
                ;

                return BldrsBox(
                  height: _bzTypeCircleSize,
                  verseWeight: VerseWeight.thin,
                  verseMaxLines: 3,
                  corners: _bzTypeCircleSize * 0.5,
                  icon: _icon,
                  iconSizeFactor: 0.6,
                  color: _isSelected == true ? Colorz.yellow255 : Colorz.white10,
                  iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    onBzTypeTap(_bzType);
                    },
                );

              }),

            ],
          ),
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
