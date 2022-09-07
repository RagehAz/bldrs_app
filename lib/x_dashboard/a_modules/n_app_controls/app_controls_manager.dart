import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_model.dart';
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
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'AppControlsManager',);
    }
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
  /// TAMAM
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
      pageTitleVerse:  'App Controls',
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      loading: _loading,
      layoutWidget: ValueListenableBuilder(
        valueListenable: _appControls,
        builder: (_, AppControlsModel controls, Widget child){

          if (controls == null){
            return const SizedBox();
          }
          else {
            return  ListView(
              padding: Scale.superInsets(context: context, top: Stratosphere.smallAppBarStratosphere),
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                const SuperVerse(
                  verse:  'Wall Flyers',
                ),

                TileBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse:  'Show only Verified Flyers',
                    leadingIcon: Iconz.news,
                    leadingIconSizeFactor: 0.5,
                    switchIsOn: controls.showOnlyVerifiedFlyersInHomeWall,
                    onSwitchTap: (bool val) => switchOnlyShowVerifiedFlyersInHomeWall(
                      context: context,
                      value: val,
                      appControlsModel: _appControls,
                    ),
                  ),
                  bulletPoints: const <String>[
                    'Audit States are :-',
                    'null',
                    'verified',
                    'suspended',
                    'banned',
                  ],
                  secondLineVerse:  'Only verified flyers will be shown in Home screen wall.\n'
                      'if switched off, Audit state will be neglected in its search query showing both null and verified Audit states.\n'
                      'But still banned and suspended flyers will not be viewed.\n',
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
