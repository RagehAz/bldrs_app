import 'dart:async';

import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/widgets/buttons/store_button.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:basics/super_text/super_text.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/x_app_settings_controllers.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class BannerScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BannerScreen({
    super.key
  });
  // --------------------------------------------------------------------------
  @override
  State<BannerScreen> createState() => _BannerScreenState();
  // --------------------------------------------------------------------------
}

class _BannerScreenState extends State<BannerScreen> {
  // --------------------
  /// KEYBOARD VISIBILITY
  StreamSubscription<bool>? _keyboardSubscription;
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  // --------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// NO NEED HERE
        // await initializeDonya();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _keyboardSubscription?.cancel();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _shortestSide = Scale.screenShortestSide(context);

    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: const Duration(seconds: 2),
      child: MainLayout(
        canSwipeBack: false,
        appBarType: AppBarType.non,
        pyramidsAreOn: true,
        pyramidType: PyramidType.crystalYellow,
        loading: _loading,
        skyType: SkyType.stars,
        child: FloatingList(
          columnChildren: <Widget>[

            /// LOGO
            SuperImage(
              width: _shortestSide * 0.5 * 0.8,
              height: _shortestSide * 0.4 * 0.8,
              pic: Iconz.bldrsNameEn,
              loading: false,
            ),

            /// SPACER
            const SizedBox(
              width: 10,
              height: 10,
            ),

            /// SLOGAN
            SuperText(
              text: "The Builder's Network",
              font: BldrsThemeFonts.fontEnglishBody,
              weight: FontWeight.w400,
              italic: true,
              boxWidth: _shortestSide * 0.7,
              textHeight: _shortestSide * 0.05,
              maxLines: 2,
            ),

            /// SPACER
            SizedBox(
              width: 10,
              height: _shortestSide * 0.025,
            ),

            /// Available on
            WidgetFader(
              fadeType: FadeType.repeatAndReverse,
              duration: const Duration(seconds: 5),
              child: SuperText(
                text: 'Available on ..',
                font: BldrsThemeFonts.fontBldrsHeadlineFont,
                italic: true,
                weight: FontWeight.w600,
                boxWidth: _shortestSide * 0.7,
                textHeight: _shortestSide * 0.07,
                maxLines: 2,
                letterSpacing: 3,
                textColor: Colorz.yellow125,
              ),
            ),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                /// GOOGLE PLAY STORE
                StoreButton(
                  storeType: StoreType.googlePlay,
                  onTap: () => Launcher.launchURL(Standards.androidAppStoreURL),
                ),

                /// SPACER
                const SizedBox(
                  width: 10,
                  height: 10,
                ),

                /// IOS APP STORE
                StoreButton(
                    storeType: StoreType.appStore,
                    onTap: () => Launcher.launchURL(Standards.iosAppStoreURL),
                  ),

              ],
            ),

            /// SPACER
            SizedBox(
              width: 10,
              height: _shortestSide * 0.05,
            ),

            /// TERMS
            SuperBox(
              textCentered: false,
              text: 'Terms & Regulations',
              bubble: false,
              textItalic: true,
              textWeight: FontWeight.w200,
              // width: _referenceLength * 0.7,
              height: _shortestSide * 0.05,
              icon: Iconz.terms,
              iconSizeFactor: 0.5,
              textScaleFactor: 0.8 / 0.5,
              color: Colorz.black125,
              corners: _shortestSide * 0.025,
              onTap: () => onTermsAndTap(),
            ),

            /// SPACER
            SizedBox(
              width: 10,
              height: _shortestSide * 0.005,
            ),

            /// PRIVACY
            SuperBox(
              textCentered: false,
              text: 'Privacy Policy',
              bubble: false,
              textItalic: true,
              textWeight: FontWeight.w200,
              // width: _referenceLength * 0.7,
              height: _shortestSide * 0.05,
              icon: Iconz.terms,
              textScaleFactor: 0.8 / 0.5,
              iconSizeFactor: 0.5,
              color: Colorz.black125,
              corners: _shortestSide * 0.025,
              onTap: () => onPrivacyTap(),
            ),

            /// SPACER
            SizedBox(
              width: 10,
              height: _shortestSide * 0.02,
            ),

            /// Rageh El Azzazy
            AppVersionBuilder(
                versionShouldBe: '0.0.0',
                builder: (context, bool shouldUpdate, String version) {

                  return SuperText(
                    text: 'Copyright © 2023 Rageh Azzazy. All rights reserved.'
                        '\nv : $version',
                    font: BldrsThemeFonts.fontEnglishBody,
                    italic: true,
                    boxWidth: _shortestSide * 0.7,
                    textHeight: _shortestSide * 0.025,
                    textColor: Colorz.white80,
                    maxLines: 3,
                    letterSpacing: 1,
                  );

                }
                ),

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
