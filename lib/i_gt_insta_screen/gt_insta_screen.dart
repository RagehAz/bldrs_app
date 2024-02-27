import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/linker.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_clip_board.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/g_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/i_fish_tank/fish_tank.dart';
import 'package:bldrs/i_gt_insta_screen/src/components/insta_profile_bubble.dart';
import 'package:bldrs/i_gt_insta_screen/src/models/insta_post.dart';
import 'package:bldrs/i_gt_insta_screen/src/protocols/gt_insta_ops.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/map_tree/map_tree.dart';
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
        /// "bldrs://deep/redirect#key1=value1&key2=value2"
        await launchUrl(Uri.parse('bldrs://deep/redirect#${widget.queryParametersString}'));
      }

    }
  }
  // -----------------------------------------------------------------------------

  /// SCRAP

  // --------------------
  Future<void> _pasteAndScrap() async {

    final String? _text = await TextClipBoard.paste();

    await _scrap(
      url: _text,
    );

  }
  // --------------------
  Future<void> _pickFishAndScrap() async {

    final String? _instagramURL = await BzzFishTankManager.pickInstagramLink();

    await _scrap(
      url: _instagramURL,
    );

  }
  // --------------------
  Future<void> _scrap({
    required String? url,
}) async {

    final bool _urlIsValid = Formers.socialLinkValidator(
      url: url,
      contactType: ContactType.instagram,
      isMandatory: true,
    ) == null;

    if (_urlIsValid == false){
      await Dialogs.topNotice(verse: Verse.plain('Not an Instagram Link'), color: Colorz.red255);
    }

    else {

      final Map<String, dynamic>? _map = await GtInstaOps.scrapProfileByURL(
        url: url,
        facebookAccessToken: _facebookAccessToken,
      );

      if (_map?['error'] != null){
        await Dialogs.topNotice(
            verse: Verse.plain('Failed to get profile\n${GtInstaOps.extractProfileName(urlOrName: url)}'),
            color: Colorz.red255);
      }

      _setInstaProfile(
        map: _map,
        url: url,
      );

    }


  }
  // --------------------
  Map<String, dynamic>? _instaMap;
  InstaProfile? _profile;
  // --------------------
  void _setInstaProfile({
    required String? url,
    required Map<String, dynamic>? map,
  }){

    Mapper.blogMap(map, invoker: 'InstaMap');

    setState(() {
      _instaMap = map;
      _profile = InstaProfile.decipherInstaMap(map: map, url: url);
    });

  }
  // -----------------------------------------------------------------------------

  /// MORE

  // --------------------
  Future<void> _onMoreTap() async {

    blog('aaa');

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
    blog('a7axxx');
    // --------------------
    return MainLayout(
      canSwipeBack: false,
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

          /// SCRAP FISH BUTTONS
          SizedBox(
            width: Bubble.bubbleWidth(context: context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                /// PASTE & SCRAP
                WideButton(
                  width: Bubble.bubbleWidth(context: context) - 120,
                  icon: Iconz.gtInsta,
                  verse: Verse.plain('Paste & scrap'),
                  isActive: _facebookAccessToken != null,
                  onTap: _pasteAndScrap,
                  onDisabledTap: () async {
                    await Dialogs.topNotice(verse: Verse.plain('Get facebook token first'),color: Colorz.red255);
                  },
                ),

                /// GET FISH
                WideButton(
                  width: 115,
                  icon: Icons.fingerprint_sharp,
                  verse: Verse.plain('Get Fish'),
                  verseScaleFactor: 0.7,
                  isActive: _facebookAccessToken != null,
                  onTap: _pickFishAndScrap,
                ),

              ],
            ),
          ),

          /// PROFILE BUBBLE
          InstaProfileBubble(
            profile: _profile,
          ),

          if (_profile != null)
          Builder(
            builder: (context) {

              final int _length = _profile?.posts.length ?? 0;

              final double _width = Bubble.bubbleWidth(context: context);
              const double _spacing = 2;

              final double _boxSize = Scale.getUniformRowItemWidth(
                numberOfItems: 3,
                boxWidth: _width,
                spacing: _spacing,
                considerMargins: false,
              );
              final double _rowHeight = _boxSize + _spacing;

              final int _numberOfRows = (_length / 3).ceil();

              return SizedBox(
                width: _width,
                height: _rowHeight * _numberOfRows,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    itemCount: _length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: _spacing,
                      mainAxisSpacing: _spacing,
                      crossAxisCount: 3,
                      // childAspectRatio: 1,
                      // mainAxisExtent: _rowHeight,
                    ),
                    itemBuilder: (_, int index){

                    final InstaPost? _post = _profile!.posts[index];

                    final bool _isVideo = TextCheck.stringContainsSubString(
                        string: _post?.url,
                        subString: 'video'
                    );

                    /// VIDEO
                    if (_isVideo == true){
                      return BldrsBox(
                        width: _boxSize,
                        height: _boxSize,
                        margins: 0,
                        color: Colorz.white10,
                        icon: Iconz.play,
                        iconColor: Colorz.white20,
                        iconSizeFactor: 0.5,
                        corners: 0,
                        bubble: false,
                      );
                    }

                    /// PICTURE
                    else {
                      return BldrsBox(
                        width: _boxSize,
                        height: _boxSize,
                        margins: 0,
                        icon: _post?.url,
                        corners: 0,
                        bubble: false,
                        onTap: () async {

                          blog('a7');
                          await PicFullScreen.openStealUrlTheOpen(url: _post?.url, title: 'post');

                        },
                      );
                    }

                    },
                ),
              );
            }
          ),

          /// GET POSTS
          if (_instaMap != null)
            BldrsBox(
              height: 40,
              icon: Iconz.gallery,
              verse: Verse.plain('Get post'),
              color: Colorz.bloodTest,
              margins: 10,
              onTap: () async {

                final String? _thing = _instaMap!['business_discovery']['media']['data'][1]['media_url'];
                blog(_thing);



              },
            ),

          /// MAP TREE
          if (_instaMap != null)
          MapTree(
            map: _instaMap,
            width: Bubble.bubbleWidth(context: context),
            keyWidth: 100,
            // searchValue: null,
            // initiallyExpanded: false,
            onLastNodeTap: (String? path) async {

              if (path != null){

                final String? _lastNode = Pathing.getLastPathNode(path);
                final dynamic _value = MapPathing.getNodeValue(
                    path: path,
                    map: _instaMap,
                );

                blog('the value : $_value');
                await Keyboard.copyToClipboardAndNotify(copy: _lastNode);

              }

            },
            onExpandableNodeTap: (String? path) async {

              if (path != null){
                final String? _lastNode = Pathing.getLastPathNode(path);
                await Keyboard.copyToClipboardAndNotify(copy: _lastNode);
              }

            },
            selectedPaths: const [],
          )

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
