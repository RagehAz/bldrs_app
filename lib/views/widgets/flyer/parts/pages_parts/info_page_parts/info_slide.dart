import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/record_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoSlide extends StatelessWidget {
  final SuperFlyer superFlyer;

  // final double flyerZoneWidth;
  // final DraftFlyerModel draft;
  // final Function onVerticalBack;
  // final Function onFlyerTypeTap;
  // final Function onZoneTap;
  // final Function onAboutTap;
  // final Function onKeywordsTap;

  InfoSlide({
    @required this.superFlyer,
    // @required this.flyerZoneWidth,
    // @required this.draft,
    // @required this.onVerticalBack,
    // @required this.onFlyerTypeTap,
    // @required this.onZoneTap,
    // @required this.onAboutTap,
    // @required this.onKeywordsTap,
  });

  List<TinyUser> _getUsers(){

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


    return _users;
  }

  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = superFlyer.flyerZoneWidth;
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);

    double _bubbleWidth = _flyerZoneWidth - (Ratioz.appBarPadding * 2);

    double _peopleBubbleBoxHeight = _flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    double _peopleIconSize = _flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    double _headerAndProgressHeights = Scale.superHeaderAndProgressHeights(context, _flyerZoneWidth);

    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _cornerSmall = _flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (_flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, _flyerZoneWidth * Ratioz.xxflyerTopCorners);

    BorderRadius _keywordsBubbleCorners = Borderers.superBorderOnly(
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

    FlyerType _flyerType = superFlyer.flyerType == null ? FlyerTypeClass.concludeFlyerType(superFlyer.bzType) : superFlyer.flyerType;

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, superFlyer.flyerZone.countryID);
    String _cityNameRetrieved = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, superFlyer.flyerZone.cityID);
    String _cityName = _cityNameRetrieved == null ? '.....' : _cityNameRetrieved;

    List<TinyUser> _users = _getUsers();

    return Column(
      children: <Widget>[

        /// FLYER STATS ZONE
        Container(
          width: _flyerZoneWidth,
          // height: _flyerZoneHeight, //_flyerZoneHeight - _headerAndProgressHeights,
          alignment: Alignment.topCenter,
          // color: Colorz.BloodTest,
          child: Column(
            // physics: const BouncingScrollPhysics(),
            // shrinkWrap: true,

            children: <Widget>[

              /// HEADER FOOTPRINT ZONE
              Container(
                width: _flyerZoneWidth,
                height: _headerAndProgressHeights,
              ),

              /// ALL STATS
              if (superFlyer.flyerState != FlyerState.Draft)
              InPyramidsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _bubbleCorners,
                bubbleOnTap: (){print('all states in preview mode');},
                columnChildren: <Widget>[

                  /// Flyer Type
                  StatsLine(
                    verse: 'Flyer Type : ${TextGenerator.flyerTypeSingleStringer(context, _flyerType)}',
                    icon: Iconizer.flyerTypeIconOff(_flyerType),
                    iconSizeFactor: 1,
                    verseScaleFactor: 0.85 * 0.7,
                    bubbleWidth: _bubbleWidth,
                  ),

                  /// PUBLISH TIME
                  StatsLine(
                    verse: 'Published on Saturday 17 July 2021',
                    icon: Iconz.Calendar,
                    bubbleWidth: _bubbleWidth,
                  ),

                  /// ZONE
                  StatsLine(
                    verse: 'Targeting : ${_cityName} , ${_countryName}',
                    icon: Flagz.getFlagByIso3(superFlyer.flyerZone.countryID),
                    bubbleWidth: _bubbleWidth,
                  ),

                ],
              ),

              /// Flyer Type
              if (superFlyer.flyerState == FlyerState.Draft)
              InPyramidsBubble(
                bubbleWidth: _bubbleWidth,
                margins: _bubbleMargins,
                corners: _bubbleCorners,
                bubbleOnTap: superFlyer.onFlyerTypeTap,
                columnChildren: <Widget>[

                  StatsLine(
                    verse: 'Flyer Type : ${TextGenerator.flyerTypeSingleStringer(context, _flyerType)}',
                    icon: Iconizer.flyerTypeIconOff(_flyerType),
                    iconSizeFactor: 1,
                    verseScaleFactor: 0.85 * 0.7,
                    bubbleWidth: _bubbleWidth,
                  ),

                ],
              ),

              /// ZONE
              if (superFlyer.flyerState != FlyerState.Draft)
                InPyramidsBubble(
                  bubbleWidth: _bubbleWidth,
                  margins: _bubbleMargins,
                  corners: _bubbleCorners,
                  bubbleOnTap: superFlyer.onZoneTap,
                  columnChildren: <Widget>[
                    StatsLine(
                      verse: 'Targeting : ${_cityName} , ${_countryName}',
                      icon: Flagz.getFlagByIso3(superFlyer.flyerZone.countryID),
                      bubbleWidth: _bubbleWidth,
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
                paragraph: superFlyer.infoController.text.length == 0 ? '...' : superFlyer.infoController.text,
                onParagraphTap: superFlyer.onAboutTap,
              ),

              /// SAVES BUBBLE
              if (superFlyer.flyerState != FlyerState.Draft)
                RecordBubble(
                  flyerZoneWidth: _flyerZoneWidth,
                  bubbleTitle: 'Who Saved it',
                  bubbleIcon: Iconz.Save,
                  users: _users,
              ),

              /// SHARES BUBBLE
              if (superFlyer.flyerState != FlyerState.Draft)
                RecordBubble(
                flyerZoneWidth: _flyerZoneWidth,
                bubbleTitle: 'Who Shared it',
                bubbleIcon: Iconz.Share,
                users: _users,
              ),

              /// VIEWS BUBBLE
              if (superFlyer.flyerState != FlyerState.Draft)
                RecordBubble(
                flyerZoneWidth: _flyerZoneWidth,
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
                onTap: superFlyer.onKeywordsTap,
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
