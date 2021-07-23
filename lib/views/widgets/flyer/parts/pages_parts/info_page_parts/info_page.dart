import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/record_bubble.dart';

class InfoPage extends StatelessWidget {
  final double flyerZoneWidth;
  final DraftFlyerModel draft;
  final Function onVerticalBack;
  final Function onFlyerTypeTap;
  final Function onZoneTap;
  final Function onAboutTap;
  final Function onKeywordsTap;
  final ScrollController infoScrollController;
  final PageController verticalController;

  const InfoPage({
    @required this.flyerZoneWidth,
    @required this.draft,
    @required this.onVerticalBack,
    @required this.onFlyerTypeTap,
    @required this.onZoneTap,
    @required this.onAboutTap,
    @required this.onKeywordsTap,
    @required this.infoScrollController,
    @required this.verticalController,
    Key key,
  }) : super(key: key);

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

    FlyerType _flyerType = draft.flyerType == null ? FlyerTypeClass.concludeFlyerType(draft.bzModel.bzType) : draft.flyerType;

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, draft.flyerZone.countryID);
    String _cityNameRetrieved = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, draft.flyerZone.cityID);
    String _cityName = _cityNameRetrieved == null ? '.....' : _cityNameRetrieved;

    List<TinyUser> _users = _getUsers();

    return NotificationListener(
      onNotification: (ScrollUpdateNotification details){

        double _offset = details.metrics.pixels;

        double _bounceLimit = _flyerZoneHeight * 0.2 * (-1);

        bool _canPageUp = _offset < _bounceLimit;

        bool _goingDown = Scrollers.isGoingDown(infoScrollController);

        if(_goingDown && _canPageUp){
          Sliders.slideToBackFrom(verticalController, 1, curve: Curves.easeOut);
        }

        return true;
        },
      child: ListView(
        key: PageStorageKey<String>('${Numberers.createUniqueIntFrom(existingValues: [1, 2])}'), // TASK : fix
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        controller: infoScrollController,
        children: <Widget>[

          /// HEADER FOOTPRINT ZONE
          Container(
            width: flyerZoneWidth,
            height: _headerAndProgressHeights,
          ),

          /// ALL STATS
          if (draft.editMode == false)
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
                  icon: Flagz.getFlagByIso3(draft.flyerZone.countryID),
                  bubbleWidth: _bubbleWidth,
                ),

              ],
            ),

          /// Flyer Type
          if (draft.editMode == true)
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              bubbleOnTap: onFlyerTypeTap,
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
          if (draft.editMode == true)
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              bubbleOnTap: onZoneTap,
              columnChildren: <Widget>[

                StatsLine(
                  verse: 'Targeting : ${_cityName} , ${_countryName}',
                  icon: Flagz.getFlagByIso3(draft.flyerZone.countryID),
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
            paragraph: draft.infoController.text.length == 0 ? '...' : draft.infoController.text,
            onParagraphTap: onAboutTap,
          ),

          /// SAVES BUBBLE
          if (draft.editMode == false)
            RecordBubble(
              flyerZoneWidth: flyerZoneWidth,
              bubbleTitle: 'Who Saved it',
              bubbleIcon: Iconz.Save,
              users: _users,
            ),

          /// SHARES BUBBLE
          if (draft.editMode == false)
            RecordBubble(
              flyerZoneWidth: flyerZoneWidth,
              bubbleTitle: 'Who Shared it',
              bubbleIcon: Iconz.Share,
              users: _users,
            ),

          /// VIEWS BUBBLE
          if (draft.editMode == false)
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
            onTap: onKeywordsTap,
          ),

          SizedBox(
            height: Ratioz.appBarPadding,
          ),

        ],
      ),
    );
  }
}
