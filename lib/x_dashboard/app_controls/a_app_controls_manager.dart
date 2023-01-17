import 'package:bldrs/a_models/x_utilities/xx_app_controls_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/x_dashboard/app_controls/b_pricing_screen.dart';
import 'package:bldrs/x_dashboard/app_controls/x_app_controls_controller.dart';
import 'package:flutter/material.dart';

class AppControlsManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AppControlsManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AppControlsManagerState createState() => _AppControlsManagerState();
  /// --------------------------------------------------------------------------
}

class _AppControlsManagerState extends State<AppControlsManager> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _showOnlyVerifiedFlyers = ValueNotifier(false);
  ValueNotifier<AppControlsModel> _appControls;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    final AppControlsModel _initialModel = GeneralProvider.proGerAppControls(context, listen: false);
    _appControls = ValueNotifier(_initialModel);
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _showOnlyVerifiedFlyers.dispose();
    _appControls.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      title: Verse.plain('App Controls'),
      pyramidsAreOn: true,
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          icon: Iconz.bigMac,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const PricingScreen(),
          ),
        ),

      ],
      child: ValueListenableBuilder(
        valueListenable: _appControls,
        builder: (_, AppControlsModel controls, Widget child){

          if (controls == null){
            return const SizedBox();
          }
          else {
            return  ListView(
              padding: const EdgeInsets.only(top: Stratosphere.smallAppBarStratosphere),
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                const SuperVerse(
                  verse: Verse(
                    text: 'Wall Flyers',
                    translate: false,
                  ),
                ),

                TileBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: const Verse(
                      text: 'Show only Verified Flyers',
                      translate: false,
                    ),
                    leadingIcon: Iconz.notification,
                    leadingIconSizeFactor: 0.5,
                    switchValue: controls.showOnlyVerifiedFlyersInHomeWall,
                    onSwitchTap: (bool val) => switchOnlyShowVerifiedFlyersInHomeWall(
                      context: context,
                      value: val,
                      appControlsModel: _appControls,
                      mounted: mounted,
                    ),
                  ),
                  bulletPoints: const <Verse>[
                    Verse(text: 'Audit States are :-', translate: false,),
                    Verse(text: 'null', translate: false,),
                    Verse(text: 'verified', translate: false,),
                    Verse(text: 'suspended', translate: false,),
                    Verse(text: 'banned', translate: false,),
                  ],
                  secondLineVerse: const Verse(
                    text: 'Only verified flyers will be shown in Home screen wall.\n'
                        'if switched off, Audit state will be neglected in its search query showing both null and verified Audit states.\n'
                        'But still banned and suspended flyers will not be viewed.\n',
                    translate: false,
                  ),
                ),

              ],
            );
          }

        },
      ),
    );
    
  }
  // -----------------------------------------------------------------------------
}
