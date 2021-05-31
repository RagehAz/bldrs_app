import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/bldrs_expansion_tile.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/flyer_keyz.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {
  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {
  bool _isExpanded = false;
  final GlobalKey<BldrsExpansionTileState> _expansionTileKey = new GlobalKey();
  final GlobalKey<BldrsExpansionTileState> _expansionTileKey2 = new GlobalKey();
  String _subtitle;
  List<String> _keywords = new List();

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
    _keywords.addAll(Filterz.propertyType);
    _keywords.sort((a, b) => a.toString().compareTo(b.toString()));
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    String _filterName = 'property Type';
    String _subTitle = 'propertyType';
    String _icon = Iconz.Plus;
    double _iconSizeFactor = 0.6;




    return MainLayout(
      pageTitle: 'Keywords And Filters Manager',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      sky: Sky.Night,
      tappingRageh: (){
        if(_isExpanded){
          _expansionTileKey.currentState.collapse();
        } else {
          _expansionTileKey.currentState.expand();
        }

        setState(() {
          _isExpanded =! _isExpanded;
        });

      },
      layoutWidget: Container(
        width: 300, // this dictates overall width
        child: ListView(
          children: [

            Stratosphere(),

            BldrsExpansionTile(
              height: 270,
              key: _expansionTileKey,
              title: 'Property type',
              subTitle: _subtitle,
              icon: Iconz.XLarge,
              iconSizeFactor: 0.5,
              keywords: _keywords,
              onKeywordTap: (String selectedKeyword){
                setState(() {
                  _subtitle = selectedKeyword;
                });
                },
            ),

            BldrsExpansionTile(
              height: 270,
              key: _expansionTileKey2,
              title: 'Property type',
              subTitle: _subtitle,
              icon: Iconz.XLarge,
              iconSizeFactor: 0.5,
              keywords: _keywords,
              onKeywordTap: (String selectedKeyword){
                setState(() {
                  _subtitle = selectedKeyword;
                });
              },
            ),

            PyramidsHorizon(heightFactor: 5,),

          ],
        ),
      ),
    );
  }
}
