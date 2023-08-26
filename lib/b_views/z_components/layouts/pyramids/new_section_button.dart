import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';

/// PLAN : SECTION_WHEEL

/*

class SectionsMenu extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const SectionsMenu({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  State<SectionsMenu> createState() => _SectionsMenuState();
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static const double extraBottomMargin = 20;
  // --------------------
  static double bigHeight(BuildContext context){
    final double _screenHeight = Scale.screenHeight(context);
    return _screenHeight - PyramidsPanel.bottomMargin - 20 - 14 - extraBottomMargin;
  }
  // --------------------
  static double bigWidth(BuildContext context){
    return BldrsAppBar.width(context);
  }
  // --------------------
  static double bigCorners = BldrsAppBar.corners.topLeft.x;

}

class _SectionsMenuState extends State<SectionsMenu> {

  bool isBig = false;

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bigHeight = SectionsMenu.bigHeight(context);
    final double _bigWidth = SectionsMenu.bigWidth(context);
    final double _smallCorner = PyramidFloatingButton.size/2;
    final double _bigCorner = SectionsMenu.bigCorners;
    // --------------------
    return GestureDetector(
      onTap: (){
        setState(() {
          isBig = !isBig;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isBig ? _bigWidth : PyramidFloatingButton.size,
        height: isBig ? _bigHeight : PyramidFloatingButton.size,
        decoration: BoxDecoration(
          color: isBig ? Colorz.black125 : Colorz.white80,
          borderRadius: Borderers.cornerAll(context, isBig ? _bigCorner : _smallCorner),
        ),
        margin: Scale.superInsets(
          context: context,
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          bottom: isBig ? SectionsMenu.extraBottomMargin : 0,
        ),
        /// for ths shuttering button to be positioned while animation
        alignment: Alignment.bottomRight,
        child: isBig ?
        const BigSectionsMenu()
            :
        const SectionsMenuButton(),
      ),
    );
    // --------------------
  }
}

class SectionsMenuButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SectionsMenuButton({
    super.key
  });
  // -----------------------------------------------------------------------------
  List<String> getPhids({
    required BuildContext context,
  }){
    final ZonePhidsModel _phidsModels = ChainsProvider.proGetZonePhids(context: context, listen: true);
    return ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: _phidsModels);
  }
  // --------------------
  String getIcon({
    required BuildContext context,
    required List<String> phids,
  }){

    // final bool _canRenderImages = Mapper.checkCanLoopList(phids);
    //
    // if (_canRenderImages == true){
    //   final int _index = Numeric.createRandomIndex(listLength: phids.length - 1);
    //   return ChainsProvider.proGetPhidIcon(context: context, son: phids[_index]);
    // }
    //
    // else {
      return Iconz.keywords;
    // }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _phids = getPhids(context: context);
    // --------------------
    return ClockRebuilder(
      startTime: DateTime.now(),
      duration: const Duration(milliseconds: 300),
      builder: (int timeDifference, Widget? child){

        return SuperBox(
          height: PyramidFloatingButton.size,
          width: PyramidFloatingButton.size,
          icon: getIcon(
            context: context,
            phids: _phids,
          ),
          iconSizeFactor: 0.7,
          // color: Colorz.white20,
          corners: PyramidFloatingButton.size/2,
          bubble: false,

        );
        },
    );
  }
  // -----------------------------------------------------------------------------
}

class BigSectionsMenu extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BigSectionsMenu({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = SectionsMenu.bigWidth(context);
    final double _height = SectionsMenu.bigHeight(context);

    return Container(
      width: _width,
      height: _height,
      color: Colorz.black200,
      child: Stack(
        children: <Widget>[

          // BlurLayer(
          //   width: _width,
          //   height: _width,
          //   borders: Borderers.cornerAll(context, SectionsMenu.bigCorners),
          //   blurIsOn: true,
          // ),
///---
          Consumer<ChainsProvider>(
            builder: (_, ChainsProvider chainsPro, Widget child) {

              final ZonePhidsModel _zonePhidsModel = chainsPro.zonePhidsModel;
              final List<Chain> _bldrsChains = chainsPro.zoneChains;

              final List<FlyerType> _flyerTypes = ZonePhidsModel.getFlyerTypesByZonePhids(
                zonePhidsModel: _zonePhidsModel,
                bldrsChains: _bldrsChains,
              );

              return ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  FloatingList(
                  columnChildren: <Widget>[

                    ...List.generate(_flyerTypes.length, (index) {
                      final FlyerType _flyerType = _flyerTypes[index];
                      final String _phid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);

                      return FlyerTypeButton(
                        isSelected: false,
                        icon: FlyerTyper.flyerTypeIcon(flyerType: _flyerType, isOn: true),
                        verse: Verse(
                          id: _phid,
                          translate: true,
                        ),
                        onTap: () async {
                          final String phid = await PhidsPickerScreen.goPickPhid(
                            context: context,
                            flyerType: _flyerType,
                            event: ViewingEvent.homeView,
                            onlyUseZoneChains: true,
                            // selectedPhids:
                          );

                          if (phid != null) {
                            await setActivePhidK(
                              context: context,
                              phidK: phid,
                              flyerType: _flyerType,
                            );
                            setState(() {
                              isBig = false;
                            });
                          }
                        },
                      );
                    }),

                  ],
                ),

                ],
              );
            },
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

 */

class SectionWheel extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SectionWheel({
    super.key
  });
  // -----------------------------------------------------------------------------
  Future<void> onTapPhid(String phid) async {

    final List<Chain>? _bldrsChains = ChainsProvider.proGetBldrsChains(
        context: getMainContext(),
        onlyUseZoneChains: false,
        listen: false,
    );

    final FlyerType? _flyerType = ZonePhidsModel.getFlyerTypeByPhid(
      phid: phid,
      bldrsChains: _bldrsChains,
    );

    await setActivePhidK(
      phidK: phid,
      flyerType: _flyerType,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // -------------------------------

    /// ZONE PHIDS

    // -------------------------------
    final ZonePhidsModel? _zonePhidsModel = ChainsProvider.proGetZonePhids(
        context: context,
        listen: true,
    );
    // -------------------------------
    final List<String> _phids = ZonePhidsModel.getPhidsFromZonePhidsModel(
      zonePhidsModel: _zonePhidsModel,
    );
    // -------------------------------
    final String? _currentPhid = ChainsProvider.proGetHomeWallPhid(
      context: context,
      listen: true,
    );
    // -------------------------------
    /*
    // final List<Chain>? _bldrsChains = ChainsProvider.proGetBldrsChains(
    //     context: context,
    //     onlyUseZoneChains: true,
    //     listen: true,
    // );
     */
    // -------------------------------

    /// SCREEN SCALE

    // -------------------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // -------------------------------

    /// CIRCLE

    // -------------------------------
    const double _buttonSize = 40;
    const Offset _circleOrigin = Offset.zero;
    const double _circleRadius = Ratioz.pyramidsHeight * 3;
    const double _innerRadius = _circleRadius - _buttonSize;
    // -------------------------------
    return SizedBox(
      width: _screenWidth,
      height: _screenHeight,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[

          SuperPositioned(
            appIsLTR: true,
            enAlignment: Alignment.bottomRight,
            horizontalOffset: -_circleRadius,
            verticalOffset: -_circleRadius,
            child: SizedBox(
              width: _circleRadius * 2,
              height: _circleRadius * 2,
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
                initialAngle: Numeric.degreeToRadian(0)!,
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
                rotateMode: RotateMode.onlyChildrenRotate,
                // isChildrenVertical: true,
                // showInitialAnimation: false,
                /// STYLING
                // gradient: ,
                innerCircleColor: Colorz.nothing,
                outerCircleColor: Colorz.nothing,
                /// CENTER WIDGET
                // centerWidget: BldrsBox(
                //   height: _bzTypeCircleSize,
                //   corners: _bzTypeCircleSize * 0.5,
                //   icon: _getUserIcon(context),
                //   iconSizeFactor: _getUserIconSizeFactor(context),
                //   borderColor: _ownerIsSelected ? Colorz.yellow255 : null,
                //   iconColor: _ownerIsSelected ? Colorz.black255 : null,
                //   color: _ownerIsSelected == true ? Colorz.yellow255 : null,
                //   onTap: () async {
                //     await Future.delayed(const Duration(milliseconds: 100));
                //     onBzTypeTap(null);
                //   }
                // ),
                children: <Widget>[

                  ...List.generate(_phids.length, (index){

                    final String _phid = _phids[index];
                    final bool _isSelected = _currentPhid == _phid;

                    return BldrsBox(
                      height: _buttonSize,
                      width: _buttonSize,
                      corners: _buttonSize/2,
                      icon: ChainsProvider.proGetPhidIcon(son: _phid),
                      color: _isSelected == true ? Colorz.yellow255 : Colorz.white10,
                      iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                      onTap: () => onTapPhid(_phid),
                    );

                  }),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
