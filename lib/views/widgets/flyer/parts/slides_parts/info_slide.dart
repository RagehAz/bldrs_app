import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/record_bubble.dart';
import 'package:flutter/material.dart';

class InfoSlide extends StatelessWidget {
  final double flyerZoneWidth;
  final FlyerModel flyer;
  final Function onVerticalBack;

  InfoSlide({
    @required this.flyerZoneWidth,
    @required this.flyer,
    @required this.onVerticalBack,
});

  final List<TinyUser> _users = <TinyUser>[
    TinyUser(
      name: 'Ahmad Ali',
      pic: Iconz.DumAuthorPic,
      userID: '1',
      title: '',
    ),
    TinyUser(
      name: 'Morgan Darwish',
      pic: Dumz.XXabohassan_author,
      userID: '2',
      title: '',
    ),
    TinyUser(
      name: 'Zahi Fayez',
      pic: Dumz.XXzah_author,
      userID: '3',
      title: '',
    ),
    TinyUser(
      name: 'Hani Wani',
      pic: Dumz.XXhs_author,
      userID: '4',
      title: '',
    ),
    TinyUser(
      name: 'Nada Mohsen',
      pic: Dumz.XXmhdh_author,
      userID: '5',
      title: '',
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
            // physics: const BouncingScrollPhysics(),
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

              /// SAVES BUBBLE
              RecordBubble(
                  flyerZoneWidth: flyerZoneWidth,
                  bubbleTitle: 'Who Saved it',
                  bubbleIcon: Iconz.Save,
                  users: _users,
              ),

              /// SHARES BUBBLE
              RecordBubble(
                flyerZoneWidth: flyerZoneWidth,
                bubbleTitle: 'Who Shared it',
                bubbleIcon: Iconz.Share,
                users: _users,
              ),

              /// VIEWS BUBBLE
              RecordBubble(
                flyerZoneWidth: flyerZoneWidth,
                bubbleTitle: 'Who viewed it',
                bubbleIcon: Iconz.Views,
                users: _users,
              ),

              /// KEYWORDS
              KeywordsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _keywordsBubbleCorners,
                title: 'Flyer keywords',
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
