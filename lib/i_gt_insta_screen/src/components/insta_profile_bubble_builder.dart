import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/i_fish_tank/fish_tank.dart';
import 'package:bldrs/i_gt_insta_screen/src/components/insta_profile_bubble.dart';
import 'package:bldrs/i_gt_insta_screen/src/protocols/gt_insta_ops.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class InstaProfileBubbleBuilder extends StatefulWidget {
  // --------------------------------------------------------------------------
  const InstaProfileBubbleBuilder({
    required this.url,
    required this.facebookAccessToken,
    super.key
  });
  // --------------------
  final String? url;
  final String? facebookAccessToken;
  // --------------------
  @override
  _InstaProfileBubbleBuilderState createState() => _InstaProfileBubbleBuilderState();
// --------------------------------------------------------------------------
}

class _InstaProfileBubbleBuilderState extends State<InstaProfileBubbleBuilder> {
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
      _isInit = false; // good

      asyncInSync(() async {

        await _scrap(
          url: widget.url,
        );

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(InstaProfileBubbleBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
    oldWidget.url != widget.url
        ||
        oldWidget.facebookAccessToken != widget.facebookAccessToken
    ) {

      unawaited(
        Future.delayed(
          const Duration(milliseconds: 250),
              () async {

            _pageNumber = 0;
            _totalPages = 1;
            await _scrap(url: widget.url);

          },
        ),
      );
    }
  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// PROFILE

  // --------------------
  bool _loading = false;
  Map<String, dynamic>? _instaMap;
  bool _showMap = false;
  InstaProfile? _profile;
  int _pageNumber = 0;
  int _totalPages = 1;
  // --------------------
  Future<void> _scrap({
    required String? url,
    String? startAfterCursor,
    String? startBeforeCursor,
  }) async {

    final bool _urlIsValid = Formers.socialLinkValidator(
      url: url,
      contactType: ContactType.instagram,
      isMandatory: true,
    ) == null;

    if (_urlIsValid == false){
      await Dialogs.topNotice(verse: Verse.plain('Not an Instagram Link'), color: Colorz.red255);
    }

    else if (_loading == false){

      if (mounted){
        setState(() {
          _loading = true;
        });
      }


      blog('scraping aho');

      final Map<String, dynamic>? _map = await GtInstaOps.scrapProfileByURL(
        url: url,
        facebookAccessToken: widget.facebookAccessToken,
        limit: 9,
        startAfterCursor: startAfterCursor,
        startBeforeCursor: startBeforeCursor,
      );

      if (_map?['error'] != null){
        await Dialogs.topNotice(
            verse: Verse.plain('Failed to get profile\n${GtInstaOps.extractProfileName(urlOrName: url)}'),
            color: Colorz.red255);
        Mapper.blogMap(_map);
        if (mounted){
          setState(() {
            _showMap = true;
          });
        }
      }

      if (TextCheck.stringContainsSubString(string: _map?['error']?['message'], subString: 'Application request limit reached')){
        await Dialogs.centerNotice(
          verse: Verse.plain('Max API calls limit Reached'),
          color: Colorz.red255,
        );
      }

      if (mounted){
        setState(() {

          _instaMap = _map;
          _profile = InstaProfile.decipherInstaMap(map: _map, url: url);
          _loading = false;

          /// GOING FORWARD
          if (startAfterCursor != null){
            if (_totalPages - _pageNumber == 1 && _profile?.afterCursor != null){
              _totalPages++;
            }
            _pageNumber++;
          }
          /// GOING BACKWARDS
          if (startBeforeCursor != null){
            _pageNumber--;
          }

          if (_profile?.afterCursor == null){
            _totalPages = _pageNumber;
          }

          _showMap = false;

        });
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return InstaProfileBubble(
      pageNumber: _pageNumber,
      totalPages: _totalPages,
      profile: _profile,
      instaMap: _instaMap,
      showMap: _showMap,
      loading: _loading,
      onGoNext: () => _scrap(
        url: _profile?.getInstagramURL(),
        startAfterCursor: _profile?.afterCursor,
      ),
      onGoBack: () => _scrap(
        url: _profile?.getInstagramURL(),
        startBeforeCursor: _profile?.beforeCursor,
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
