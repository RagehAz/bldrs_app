import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/sub_models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/super_flyer.dart';
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
  final SuperFlyer superFlyer;

  const InfoPage({
    @required this.superFlyer,
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

    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, superFlyer.flyerZoneWidth);

    double _bubbleWidth = superFlyer.flyerZoneWidth - (Ratioz.appBarPadding * 2);

    double _peopleBubbleBoxHeight = superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    double _peopleIconSize = superFlyer.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    double _headerAndProgressHeights = Scale.superHeaderAndProgressHeights(context, superFlyer.flyerZoneWidth);

    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _cornerSmall = superFlyer.flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (superFlyer.flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, superFlyer.flyerZoneWidth * Ratioz.xxflyerTopCorners);

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

    bool _editMode = superFlyer.editMode == true;

    String _flyerInfoParagraph =
    _editMode == true && superFlyer.infoController.text.length == 0 ? '...' :
    _editMode == true && superFlyer.infoController.text.length > 0 ? superFlyer.infoController.text :
    _editMode == false ? superFlyer.flyerInfo : superFlyer.flyerInfo;

    bool _flyerInfoExists = _flyerInfoParagraph == null ? false : _flyerInfoParagraph.length == 0 ? false : true;



    return NotificationListener(
      onNotification: (ScrollUpdateNotification details){

        double _offset = details.metrics.pixels;

        double _bounceLimit = _flyerZoneHeight * 0.2 * (-1);

        bool _canPageUp = _offset < _bounceLimit;

        bool _goingDown = Scrollers.isGoingDown(superFlyer.infoScrollController);

        if(_goingDown == true && _canPageUp == true){
          Sliders.slideToBackFrom(superFlyer.verticalController, 1, curve: Curves.easeOut);
        }

        return true;
        },
      child: ListView(
        key: PageStorageKey<String>('${Numberers.createUniqueIntFrom(existingValues: [1, 2])}'), // TASK : fix
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        controller: superFlyer.infoScrollController,
        children: <Widget>[

          /// HEADER FOOTPRINT ZONE
          Container(
            width: superFlyer.flyerZoneWidth,
            height: _headerAndProgressHeights,
          ),

          /// ALL STATS
          if (_editMode == false)
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              bubbleOnTap: null,
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
          if (_editMode == true)
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
          if (_editMode == true)
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

          /// FLYER INFO
          if (_flyerInfoExists)
          ParagraphBubble(
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            title: 'More info',
            maxLines: 3,
            centered: false,
            paragraph: _flyerInfoParagraph,
            editMode: superFlyer.editMode,
            onParagraphTap: superFlyer.onEditInfoTap,
          ),

          /// SAVES BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: superFlyer.flyerZoneWidth,
              bubbleTitle: 'Who Saved it',
              bubbleIcon: Iconz.Save,
              users: _users,
            ),

          /// SHARES BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: superFlyer.flyerZoneWidth,
              bubbleTitle: 'Who Shared it',
              bubbleIcon: Iconz.Share,
              users: _users,
            ),

          /// VIEWS BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: superFlyer.flyerZoneWidth,
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
            onTap: _editMode == true ? superFlyer.onEditKeywordsTap : null,
          ),

          SizedBox(
            height: Ratioz.appBarPadding,
          ),

        ],
      ),
    );
  }
}
