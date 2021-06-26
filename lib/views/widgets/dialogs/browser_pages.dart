import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BrowserPages extends StatefulWidget {
  final double browserZoneHeight;
  final bool browserIsOn;
  final Function closeBrowser;

  BrowserPages({
    @required this.browserZoneHeight,
    @required this.browserIsOn,
    @required this.closeBrowser,
});


  @override
  _BrowserPagesState createState() => _BrowserPagesState();
}

class _BrowserPagesState extends State<BrowserPages> {
  int _numberOfPages = 3;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    double _clearWidth = widget.browserIsOn == true ? Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2 - Ratioz.appBarPadding * 2 : 0;
    double _clearHeight = widget.browserZoneHeight - Ratioz.appBarPadding * 2;
    double _titleZoneHeight = widget.browserIsOn == true ? _clearHeight * 0.2 : 0;
    double _progressBarHeight = _clearWidth * Ratioz.xxProgressBarHeightRatio;
    double _pagesZoneHeight = widget.browserIsOn == true ? _clearHeight - _titleZoneHeight - _progressBarHeight : 0;

    double _titleIconSize = 40;

    return Center(
      child: AnimatedContainer(
        duration: Ratioz.slidingTransitionDuration,
        width: _clearWidth,
        height: _clearHeight,
        decoration: BoxDecoration(
          borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
          // color: Colorz.BloodRed,
        ),
        alignment: Alignment.center,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[

            /// TITLE ZONE
            Container(
                // duration: Ratioz.slidingTransitionDuration,
                width: _clearWidth,
                height: _titleZoneHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    Container(
                      width: _titleIconSize,
                      height: _titleIconSize,
                      child: DreamBox(
                        height: _titleIconSize,
                        width: _titleIconSize,
                        icon: Iconz.FlyerGrid,
                        iconSizeFactor: 0.8,
                        bubble: true,
                        // color: Colorz.LinkedIn
                      ),
                    ),

                    Flexible(
                      flex: 12,
                      child: Container(
                        // color: Colorz.BabyBlue,
                        margin: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                        // constraints: BoxConstraints(minWidth: 0, maxWidth: _clearWidth - Ratioz.appBarPadding * 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            /// TITLE
                            SuperVerse(
                              verse: 'Browse & Add keywords to your search',
                              centered: false,
                            ),

                            /// FILTER KEYWORD PATH
                            SuperVerse(
                              verse: 'The - filter - path',
                              size: 2,
                              italic: true,
                              color: Colorz.Yellow,
                              centered: false,
                            ),

                          ],
                        ),
                      ),
                    ),

                    /// SPACER
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),

                    /// EXIT
                    Flexible(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: _titleIconSize,
                          height: _titleIconSize,
                          // color: Colorz.BloodTest,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              DreamBox(
                                height: _titleIconSize,
                                width: _titleIconSize,
                                icon: Iconz.XLarge,
                                iconSizeFactor: 0.5,
                                boxFunction: (){
                                  widget.closeBrowser();
                                  print('exit browser');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
            ),

            Container(
              width: _clearWidth,
              height: _progressBarHeight,
              // color: Colorz.Yellow,
              child: ProgressBar(
                flyerZoneWidth: _clearWidth,
                numberOfSlides: _numberOfPages,
                barIsOn: true,
                currentSlide: _currentPage,
                margins: EdgeInsets.zero,
              ),
            ),

            /// Lists
            AnimatedContainer(
              duration: Ratioz.slidingTransitionDuration,
              width: _clearWidth,
              height: _pagesZoneHeight,
              decoration: BoxDecoration(
                borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
                // color: Colorz.YellowGlass,
              ),
              child: widget.browserIsOn == true ?
              ClipRRect(
                borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
                child: PageView.builder(
                    itemCount: _numberOfPages,
                    onPageChanged: (index){
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index){

                      List<Color> _colors = [Colorz.BloodTest, Colorz.YellowGlass, Colorz.WhiteGlass];

                      return
                        Container(
                          width: 20,
                          height: 20,
                          color: _colors[index],
                        );
                    }
                ),
              ) : null,
            ),

          ],
        ),
      ),
    );
  }
}
