import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/sliders.dart' show SwipeDirection, Sliders;
import 'package:bldrs/controllers/drafters/imagers.dart' ;
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/xx_flyer_on_map.dart';
import 'package:bldrs/views/screens/x2_old_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/PersonButton.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/info_slide.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:bldrs/controllers/theme/colorz.dart';

class InfoSlide extends StatelessWidget {
  final double flyerZoneWidth;
  final FlyerModel flyer;
  final Function onVerticalBack;

  InfoSlide({
    @required this.flyerZoneWidth,
    @required this.flyer,
    @required this.onVerticalBack,
});

  List<UserModel> _users = <UserModel>[
    UserModel(
      name: 'Meshmesh abo halawa',
      pic: Iconz.DumAuthorPic,
      userID: '1',
    ),
    UserModel(
      name: 'Batates maganes',
      pic: Dumz.XXabohassan_author,
      userID: '2',
    ),
    UserModel(
      name: 'Zaha Fashikh',
      pic: Dumz.XXzah_author,
      userID: '3',
    ),
    UserModel(
      name: 'Hani Wani',
      pic: Dumz.XXhs_author,
      userID: '4',
    ),

  ];

  @override
  Widget build(BuildContext context) {

    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, flyerZoneWidth);

    double _bubbleWidth = flyerZoneWidth - (Ratioz.appBarPadding * 2);

    double _peopleBubbleBoxHeight = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    double _peopleIconSize = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    double _headerAndProgressHeights = Scale.superHeaderAndProgressHeights(context, flyerZoneWidth);

    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _cornerSmall = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, flyerZoneWidth * Ratioz.xxflyerTopCorners);

    BorderRadius _keywordsBubbleCorners = Borderers.superBorders(
      context: context,
      enTopLeft: _cornerSmall,
      enTopRight: _cornerSmall,
      enBottomLeft: _cornerBig,
      enBottomRight: _cornerBig,
    );

    List<Keyword> _keywords = <Keyword>[
      Keyword.bldrsKeywords()[100],
      Keyword.bldrsKeywords()[120],
      Keyword.bldrsKeywords()[205],
      Keyword.bldrsKeywords()[403],
      Keyword.bldrsKeywords()[600],
    ];


    return Column(
      children: <Widget>[

        /// FLYER STATS ZONE
        Container(
          width: flyerZoneWidth,
          // height: _flyerZoneHeight, //_flyerZoneHeight - _headerAndProgressHeights,
          alignment: Alignment.topCenter,
          // color: Colorz.BloodTest,
          child: Column(
            // physics: BouncingScrollPhysics(),
            // shrinkWrap: true,

            children: <Widget>[

              /// HEADER FOOTPRINT ZONE
              Container(
                width: flyerZoneWidth,
                height: _headerAndProgressHeights,
              ),

              /// STATS BUBBLE
              InPyramidsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _bubbleCorners,
                bubbleOnTap: (){
                  print('bitch');
                  onVerticalBack();
                },
                columnChildren: <Widget>[

                  /// Flyer Type
                  StatsLine(
                    verse: '${TextGenerator.flyerTypeSingleStringer(context, flyer.flyerType)}',
                    icon: Iconizer.flyerTypeIconOff(flyer.flyerType),
                  ),

                  /// PUBLISH TIME
                  StatsLine(
                    verse: 'Published on Saturday 17 July 2021',
                    icon: Iconz.Calendar,
                  ),

                  /// ZONE
                  StatsLine(
                    verse: 'Published ${TextGenerator.cityCountryStringer(context: context, zone: flyer.flyerZone)}',
                    icon: Flagz.getFlagByIso3(flyer.flyerZone.countryID),
                  ),


                ],
              ),

              /// SAVES BUBBLE
              InPyramidsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _bubbleCorners,
                title: 'People who saved this flyer',
                leadingIcon: Iconz.Save,
                LeadingAndActionButtonsSizeFactor: 1,
                columnChildren: <Widget>[

                  /// PEOPLE BOX
                  Container(
                      width: _bubbleWidth,
                      height: _peopleBubbleBoxHeight,
                      color: Colorz.Yellow80,
                      alignment: Alignment.center,
                      child:
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: _users.length,
                          itemBuilder: (ctx, index){
                            return
                              PersonButton(
                                totalHeight: _peopleBubbleBoxHeight,
                                image: _users[index].pic,
                                id: _users[index].userID,
                                name: _users[index].name,
                                onTap: (userID){
                                  print('id is : $userID');
                                },
                              );
                          }
                      )
                  ),


                ],
              ),

              /// ABOUT FLYER
              ParagraphBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _bubbleCorners,
                title: 'About this flyer',
                maxLines: 3,
                centered: false,
                paragraph: 'This is the paragraph here to wrote things and '
                    'more things about the flyer as much as you can you know,,'
                    ' and it depends on the author while making the flyer in'
                    ' the flyer editor here should be able to open uo a text'
                    ' field and enter the stuff he want in several lines to'
                    ' be expandable like this one here,, and to be able to '
                    'write as much as he can and add new lines likes this'
                    '\nThe he we start here an new pargraph and still going'
                    '\nThat would be very cool though',
              ),

              /// KEYWORDS
              KeywordsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _keywordsBubbleCorners,
                title: 'Keywords',
                keywords: _keywords,
                selectedWords: <Keyword>[Keyword.bldrsKeywords()[403],],
              ),

              SizedBox(
                height: Ratioz.appBarPadding,
              ),

            ],
          ),
          // color: Colorz.BloodTest,
        ),

      ],
    );
  }
}
