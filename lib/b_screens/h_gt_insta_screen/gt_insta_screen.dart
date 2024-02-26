import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/linker.dart';
import 'package:basics/helpers/strings/text_clip_board.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/h_gt_insta_screen/src/protocols/gt_insta_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GtInstaScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const GtInstaScreen({
    this.queryParametersString,
    super.key
  });
  // --------------------
  final String? queryParametersString;
  // --------------------
  @override
  _GtInstaScreenState createState() => _GtInstaScreenState();
// --------------------------------------------------------------------------
}

class _GtInstaScreenState extends State<GtInstaScreen> {
  // -----------------------------------------------------------------------------
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

    final Map<String, String> _map = Linker.getQueryParameters(widget.queryParametersString);
    _facebookAccessToken = _map['access_token'];

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);

        await _openApp();

        await _triggerLoading(setTo: false);

      });

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  // static const String accessToken = 'EAAGFEb3LTB8BO3ESju1370Ip9WQZAZBAub7Ni6VghTklZBD5mluFEqXhJpgdTRqoaRKVbw7HesZBRas1loFggHHODQRJI3euYddMAY1PS7lo7Imr6ZB7qXwmxZCTusSEqZB5mWb8EdsdchJO3qGnz4CpaZBRyYIkznxEhasAQGxTF8bGVd8xdgW5VZAeSKgZDZD';
  // static const String data_access_expiration_time = '1716599904';
  // static const String expires_in = '0';
  // static const String _query = 'access_token=$access_token&data_access_expiration_time=$data_access_expiration_time&expires_in=$expires_in';
  // static const String _url = 'https://bldrs.net/redirect#$_query';
  // -----------------------------------------------------------------------------

  /// FACEBOOK ACCESS TOKEN

  // --------------------
  String? _facebookAccessToken; // = accessToken;
  // --------------------
  Future<void> _onFacebookTokenButtonTap() async {

    /// GO GET TOKEN
    if (_facebookAccessToken == null){
      await GtInstaOps.goGetToken();
    }

    /// I HAVE TOKEN
    else {
      blog('I have token');
    }

  }
  // --------------------
  Future<void> _openApp() async {
    if (kIsWeb == true && widget.queryParametersString != null){

      final bool _go = await Dialogs.confirmProceed(
        titleVerse: Verse.plain('Open the App ?'),
      );

      if (_go == true){
        await launchUrl(Uri.parse('bldrs://deep/redirect#${widget.queryParametersString}'));
      }

    }
  }
  // -----------------------------------------------------------------------------

  /// SCRAP

  // --------------------
  Future<void> _scrapInstaProfile() async {

    final String? _text = await TextClipBoard.paste();

    final Map<String, dynamic>? _map = await GtInstaOps.scrapProfile(
        instagramProfileName: _text,
        facebookAccessToken: _facebookAccessToken,
    );

    Mapper.blogMap(_map, invoker: 'PROFILE: $_text');


  }
  // -----------------------------------------------------------------------------

  /// MORE

  // --------------------
  Future<void> _onMoreTap() async {

    await BottomDialog.showButtonsBottomDialog(
        numberOfWidgets: 6,
        builder: (_, __){

          return <Widget>[

            /// GO GET TOKEN
            BottomDialog.wideButton(
              icon: Iconz.comFacebookWhite,
              verse: Verse.plain(_facebookAccessToken == null ? 'Get Token.' : 'Good'),
              color: _facebookAccessToken == null ? Colorz.bloodTest : Colorz.green80,
              verseCentered: false,
              onTap: _onFacebookTokenButtonTap,
            ),

            /// OPEN APP
            BottomDialog.wideButton(
              icon: Iconz.bldrsAppIcon,
              verse: Verse.plain('Open App'),
              verseCentered: false,
              isDisabled: !kIsWeb,
              onTap: _openApp,
            ),

            const DotSeparator(),

            AppVersionBuilder(
                versionShouldBe: null,
                builder: (_, bool shouldUpdate, String version) {

                  return BldrsText(
                    verse: Verse.plain(version),
                    size: 1,
                    italic: true,
                    color: Colorz.white125,
                    weight: VerseWeight.thin,
                  );

                }),

            const DotSeparator(),

          ];

        }
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      loading: _loading,
      title: Verse.plain('Gt-Insta'),
      appBarRowWidgets: <Widget>[

        /// MORE
        AppBarButton(
          icon: Iconz.more,
          onTap: _onMoreTap,
        ),

      ],
      child: FloatingList(
        boxAlignment: Alignment.topCenter,
        padding: Stratosphere.stratosphereSandwich,
        columnChildren: <Widget>[

          /// THE TOKEN
          DataStrip(
            height: 30,
            dataKey: 'Token',
            dataValue: _facebookAccessToken,
            onValueTap: () => Keyboard.copyToClipboardAndNotify(copy: _facebookAccessToken),
          ),

          /// PASTE & SCRAP
          WideButton(
            icon: Iconz.gtInsta,
            verse: Verse.plain('Paste & scrap'),
            isActive: _facebookAccessToken != null,
            onTap: _scrapInstaProfile,
            onDisabledTap: () async {
              await Dialogs.topNotice(verse: Verse.plain('Get facebook token first'),color: Colorz.red255);
            },
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
