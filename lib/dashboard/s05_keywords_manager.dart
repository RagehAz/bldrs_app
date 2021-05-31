import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/dream_list.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/app_expansion_tile.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/flyer_keyz.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {
  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  bool _isExpanded = false;

  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String foos = 'One';

// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    String _filterName = 'property Type';
    String _subTitle = 'propertyType';
    String _icon = Iconz.Plus;
    double _iconSizeFactor = 0.6;
    List<String> _keywords = Filterz.propertyType;

    return MainLayout(
      pageTitle: 'Keywords And Filters Manager',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      sky: Sky.Night,
      tappingRageh: (){
        if(_isExpanded){
          expansionTile.currentState.collapse();
        } else {
          expansionTile.currentState.expand();
        }

        setState(() {
          _isExpanded =! _isExpanded;
        });

      },
      layoutWidget: Container(
        width: 300,
        child: ListView(
          children: [

            Stratosphere(),

            Container(
              width: Scale.superScreenWidth(context) *0.6,
              color: Colorz.WhiteAir,
              child: ExpansionTile(
                title: SuperVerse(
                  verse: _filterName,
                  color: _isExpanded ? Colorz.BlackBlack : Colorz.White,
                  centered: false,
                ),
                subtitle: SuperVerse(
                  verse: _subTitle,
                  color: _isExpanded ? Colorz.BlackLingerie : Colorz.WhiteLingerie,
                  weight: VerseWeight.thin,
                  italic: true,
                  size: 2,
                  centered: false,
                ),
                maintainState: false,
                backgroundColor: Colorz.Yellow,
                expandedAlignment: Alignment.center,
                expandedCrossAxisAlignment: CrossAxisAlignment.center,
                initiallyExpanded: false,
                leading: DreamBox(
                  height: 40,
                  width: 40,
                  icon: _icon,
                  iconSizeFactor: _iconSizeFactor,
                ),
                onExpansionChanged: (value){
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                  print('expansion is changing to $value');
                },
                tilePadding: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin, vertical: 0),
                childrenPadding: EdgeInsets.all(10),
                children: <Widget>[

                  ...List.generate(_keywords.length, (index) => DreamBox(
                    height: 40,
                    verse: _keywords[index],
                    verseColor: Colorz.BlackBlack,
                    verseWeight: VerseWeight.thin,
                    verseScaleFactor: 0.6,
                    boxMargins: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  ),

                  ),

                ],

                // trailing: DreamBox(
                //   height: 40,
                //   width: 40,
                //   icon: _isExpanded ? Iconz.ArrowUp : Iconz.ArrowDown,
                //   iconColor: _isExpanded ? Colorz.BlackBlack : Colorz.White,
                //   iconSizeFactor: 0.35,
                //   bubble: false,
                //   boxFunction: (){
                //     setState(() {
                //       _isExpanded = !_isExpanded;
                //     });
                //   },
                // ),

              ),
            ),

            Container(
              width: 200,
              color: _isExpanded ? Colorz.Yellow : Colorz.WhiteAir,
              child: AppExpansionTile(
                  key: expansionTile,
                  title: this.foos,
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                  children: <Widget>[

                    ...List.generate(_keywords.length, (index) => DreamBox(
                      height: 40,
                      verse: _keywords[index],
                      verseColor: Colorz.BlackBlack,
                      verseWeight: VerseWeight.thin,
                      verseScaleFactor: 0.6,
                      boxMargins: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      boxFunction: (){
                        setState(() {
                          this.foos = _keywords[index];
                          expansionTile.currentState.collapse();
                        });
                      },

                    ),
                    ),

                        // new ListTile(
                    //   title: const Text('One'),
                    //   onTap: () {
                    //     setState(() {
                    //       this.foos = 'One';
                    //       expansionTile.currentState.collapse();
                    //     });
                    //     },
                    // ),
                    //
                    // new ListTile(
                    //   title: const Text('Two'),
                    //   onTap: () {
                    //     setState(() {
                    //       this.foos = 'Two';
                    //       expansionTile.currentState.collapse();
                    //     });
                    //     },
                    // ),
                    //
                    // new ListTile(
                    //   title: const Text('Three'),
                    //   onTap: () {
                    //     setState(() {
                    //       this.foos = 'Three';
                    //       expansionTile.currentState.collapse();
                    //     });
                    //     },
                    // ),

                  ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
