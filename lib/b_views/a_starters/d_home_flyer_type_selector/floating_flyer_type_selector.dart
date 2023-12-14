import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/layout_exit_swiper.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:flutter/material.dart';

class FloatingFlyerTypeSelector extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FloatingFlyerTypeSelector({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  _FloatingFlyerTypeSelectorState createState() => _FloatingFlyerTypeSelectorState();
/// --------------------------------------------------------------------------
}

class _FloatingFlyerTypeSelectorState extends State<FloatingFlyerTypeSelector> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  List<FlyerType> _types = [];
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

      final ZonePhidsModel? _zonePhidsModel = ChainsProvider.proGetZonePhids(
        context: context,
        listen: false,
      );

      // _zonePhidsModel?.blogZonePhidsModel(invoker: 'floating shit');

      final List<Chain>? _bldrsChains = ChainsProvider.proGetBldrsChains(
        context: context,
        onlyUseZoneChains: true,
        listen: false,
      );

      final List<FlyerType> _flyerTypes = ZonePhidsModel.getFlyerTypesByZonePhids(
          zonePhidsModel: _zonePhidsModel,
          bldrsChains: _bldrsChains,
      );

      // blog('FloatingFlyerTypeSelector init : _flyerTypes : $_flyerTypes : _zonePhidsModel : $_zonePhidsModel');

      _types = _flyerTypes;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onFlyerTypeTap({
    required BuildContext context,
    required FlyerType? flyerType,
  }) async {

    // blog('Floating flyer type selector : onFlyerTypeTap : TAPPED ON $flyerType');

    await Nav.goBack(
      context: context,
      passedData: flyerType,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _buttonWidth = MainButton.getButtonWidth(context: context);

    // final double hypotenuse = Numeric.pythagorasHypotenuse(
    //     side:_screenWidth ,
    // );

    // final double _ltrLeftShift =    (((hypotenuse - _screenWidth) * 0.5)
    //                               + (_screenWidth * 0.5))
    //                               * -1;

    // final double _rtlLeftShift = _ltrLeftShift + Scale.screenWidth(context);
    // final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // final double _horizontalShift = _appIsLTR == true ? _ltrLeftShift : _rtlLeftShift;
    // final double _verticalShift   = _ltrLeftShift;

    return SafeArea(
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTap: () => _onFlyerTypeTap(
              context: context,
              flyerType: null,
            ),
          child: LayoutExitSwiper(
            isOn: true,
            onBack: () => Nav.goBack(
              context: context,
            ),
            child: SizedBox(
              width: _screenWidth,
              height: Scale.screenHeight(context),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  /// BLUR LAYER
                  BlurLayer(
                    height: Scale.screenHeight(context),
                    width: _screenWidth,
                    color: Colorz.black125,
                    blurIsOn: true,
                  ),

                  /// SECTIONS
                  Container(
                    height: Scale.screenHeight(context),
                    color: Colorz.black80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        /// FLYER TYPES
                        if (Lister.checkCanLoop(_types) == true)
                        ...List.generate(_types.length, (index) {

                          final FlyerType? _flyerType = _types[index];
                          final String? _phid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);

                          return BldrsBox(
                            height: 55,
                            width: MainButton.getButtonWidth(context: context),
                            onTap: () => _onFlyerTypeTap(
                              context: context,
                              flyerType: _flyerType,
                            ),
                            verse: Verse(
                              id: _phid,
                              translate: true,
                              casing: Casing.upperCase,
                            ),
                            verseItalic: true,
                            icon: FlyerTyper.flyerTypeIcon(
                              flyerType: _flyerType,
                              isOn: false,
                            ),
                            iconSizeFactor: 0.7,
                            verseScaleFactor: 0.8 / 0.7,
                            margins: const EdgeInsets.only(
                              bottom: 10,
                            ),
                          );

                          // return AnimatedBar(
                          //   curvedAnimation: _linesControllers[index],
                          //   tween: _tween,
                          //   text: _translation,
                          //   verseColor: _linesMaps[index]['color'],
                          // );

                        }),

                        /// NO SECTIONS AVAILABLE
                        if (Lister.checkCanLoop(_types) == false)
                           BldrsText(
                             width: _buttonWidth,
                             verse: const Verse(
                               id: 'phid_no_sections_available',
                               translate: true,
                               casing: Casing.upperCase,
                             ),
                              italic: true,
                             size: 5,
                             margin: 20,
                             maxLines: 4,
                          ),

                        /// SEPARATOR
                        SeparatorLine(
                          width: _buttonWidth,
                          withMargins: true,
                        ),

                        /// GO BACK
                        BldrsBox(
                          height: 50,
                          onTap: () => Nav.goBack(context: context),
                          verse: const Verse(
                            id: 'phid_go_back',
                            translate: true,
                            casing: Casing.upperCase,
                          ),
                          verseItalic: true,
                          icon: Iconizer.superArrowENLeft(context),
                          iconSizeFactor: 0.4,
                          verseScaleFactor: 0.7 / 0.4,
                          margins: 25,
                          color: Colorz.bloodTest,
                        ),

                      ],
                    ),
                  ),

                ],

              ),
            ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
