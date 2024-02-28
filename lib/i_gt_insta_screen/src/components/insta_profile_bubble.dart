import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/g_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/i_fish_tank/fish_tank.dart';
import 'package:bldrs/i_gt_insta_screen/src/models/insta_post.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contacts_wrap.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/map_tree/map_tree.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class InstaProfileBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const InstaProfileBubble({
    required this.profile,
    required this.onGoNext,
    required this.onGoBack,
    required this.pageNumber,
    required this.totalPages,
    required this.loading,
    this.instaMap,
    this.showMap = false,
    super.key
  });
  // --------------------
  final InstaProfile? profile;
  final Function onGoNext;
  final Function onGoBack;
  final int pageNumber;
  final int totalPages;
  final bool loading;
  final Map<String, dynamic>? instaMap;
  final bool showMap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _textZoneWidth = Bubble.clearWidth(context: context) - 70;
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
      columnChildren: <Widget>[

        /// PROFILE
        SizedBox(
          width: Bubble.clearWidth(context: context),
          // height: 100,
          // color: Colorz.bloodTest,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              BldrsBox(
                height: 60,
                width: 60,
                corners: 35,
                icon: profile?.logo,
              ),

              const Spacing(),

              SizedBox(
                width: _textZoneWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// NAME
                    BldrsText(
                      verse: Verse.plain(profile?.name),
                      centered: false,
                      textDirection: TextDirection.ltr,
                    ),

                    /// followers
                    Builder(
                      builder: (context) {

                        final String? _count = Numeric.formatNumToCounterCaliber(
                          x: profile?.followers,
                          thousand: 'k',
                          million: 'M',
                        );

                        return BldrsText(
                          verse: Verse.plain(_count ?? '..'),
                          size: 0,
                          centered: false,
                        );
                      }
                    ),

                    /// BIO
                    BldrsText(
                      maxWidth: _textZoneWidth,
                      verse: Verse.plain(profile?.biography),
                      size: 1,
                      centered: false,
                      italic: true,
                      maxLines: 50,
                      textDirection: TextDirection.ltr,
                    ),

                    /// CONTACTS
                    if (Lister.checkCanLoop(profile?.contacts) == true)
                      ContactsWrap(
                        contacts: profile!.contacts,
                        spacing: 10,
                        boxWidth: _textZoneWidth,
                        rowCount: 6,
                        buttonSize: 20,
                      ),


                  ],
                ),
              ),

            ],
          ),
        ),

        /// SPACING
        if (profile != null)
          const Spacing(),

        /// POSTS
        if (profile != null)
          Builder(
              builder: (context) {

                final int _length = profile?.posts.length ?? 0;

                final double _width = Bubble.clearWidth(context: context);
                const double _spacing = 2;

                final double _boxSize = Scale.getUniformRowItemWidth(
                  numberOfItems: 3,
                  boxWidth: _width,
                  spacing: _spacing,
                  considerMargins: false,
                );
                final double _rowHeight = _boxSize + _spacing;

                int _numberOfRows = (_length / 3).ceil();
                _numberOfRows = _numberOfRows < 3 ? 3 : _numberOfRows;

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

                      final InstaPost? _post = profile!.posts[index];

                      final bool _isVideo = TextCheck.stringContainsSubString(
                          string: _post?.mediaURL,
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
                          onLongTap: () => Keyboard.copyToClipboardAndNotify(copy: _post?.mediaURL),
                        );
                      }

                      /// PICTURE
                      else {
                        return Stack(
                          children: <Widget>[

                            /// PIC
                            BldrsBox(
                              width: _boxSize,
                              height: _boxSize,
                              margins: 0,
                              icon: _post?.mediaURL ?? Iconz.dvBlankSVG,
                              // color: Colorz.white10,
                              corners: 0,
                              bubble: false,
                              onTap: () async {

                                await PicFullScreen.openStealUrlTheOpen(url: _post?.mediaURL, title: 'post');

                              },
                              onLongTap: () => Keyboard.copyToClipboardAndNotify(copy: _post?.mediaURL),
                            ),

                            ///

                          ],
                        );
                      }

                    },
                  ),
                );
              }
          ),

        /// SPACING
        if (profile != null)
          const Spacing(),

        /// ARROWS
        if (profile != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// LEFT ARROW
              BldrsBox(
                height: 30,
                icon: Iconz.arrowWhiteLeft,
                iconSizeFactor: 0.7,
                color: Colorz.white10,
                isDisabled: profile?.beforeCursor == null,
                onTap: onGoBack,
              ),

              const Spacing(),

              /// NUMBER
              Builder(
                builder: (context) {

                  final String _text = '$pageNumber/$totalPages';

                  return BldrsBox(
                    height: 30,
                    loading: loading,
                    icon: _text,
                    iconSizeFactor: 0.7,
                    color: Colorz.white10,
                    isDisabled: profile?.beforeCursor == null,
                    onTap: onGoBack,
                  );
                }
              ),

              const Spacing(),

              /// RIGHT ARROW
              BldrsBox(
                height: 30,
                icon: Iconz.arrowWhiteRight,
                iconSizeFactor: 0.7,
                color: Colorz.white10,
                isDisabled: profile?.afterCursor == null,
                onTap: onGoNext,
              ),


            ],
          ),

        /// MAP TREE
        if (instaMap != null && showMap == true)
          MapTree(
            map: instaMap,
            width: Bubble.bubbleWidth(context: context),
            keyWidth: 100,
            // searchValue: null,
            // initiallyExpanded: false,
            onLastNodeTap: (String? path) async {

              if (path != null){

                final String? _lastNode = Pathing.getLastPathNode(path);
                // final dynamic _value = MapPathing.getNodeValue(
                //   path: path,
                //   map: instaMap,
                // );
                //
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
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
