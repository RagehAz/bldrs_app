import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SpecListTile extends StatelessWidget {
  final Function onTap;
  final SpecList specList;
  final List<SpecList> sourceSpecsLists;
  final List<Spec> selectedSpecs;
  final Function onDeleteSpec;

  const SpecListTile({
    @required this.onTap,
    @required this.specList,
    @required this.sourceSpecsLists,
    @required this.selectedSpecs,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);

// -----------------------------------------------------------------------------
  static double height(){
    return 70;
  }
// -----------------------------------------------------------------------------
  static double width(BuildContext context){
    final double _specTileWidth = BldrsAppBar.width(context);
    return _specTileWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    double _specTileHeight = height();
    final double _specTileWidth = width(context);
    final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
// -----------------------------------------------------------------------------

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: _specTileWidth,
          // height: _specTileHeight,
          margin: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
          decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _tileBorders,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// SPECS LIST ROW
              Container(
                width: _specTileWidth,
                child: Row(
                  children: <Widget>[

                    /// - ICON
                    DreamBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      color: Colorz.white10,
                      corners: _tileBorders,
                      bubble: false,
                    ),

                    /// - LIST NAME
                    Expanded(
                      child: Container(
                        height: _specTileHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              width: _specNameBoxWidth,
                              child: SuperVerse(
                                verse: Name.getNameByCurrentLingoFromNames(context, specList.names),
                                centered: false,
                                margin: 10,
                                maxLines: 2,
                                redDot: specList.isRequired,
                              ),
                            ),

                            // SuperVerse(
                            //   verse: Name.getNameByCurrentLingoFromNames(context, _chain.names),
                            //   centered: false,
                            // ),

                          ],
                        ),

                      ),
                    ),

                    /// - ARROW
                    DreamBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      corners: _tileBorders,
                      icon: Iconizer.superArrowENRight(context),
                      iconSizeFactor: 0.15,
                      bubble: false,
                    ),

                  ],
                ),
              ),

              /// SELECTED SPECS ROW
              if (selectedSpecs.length != 0)
                Container(
                  width: _specTileWidth,
                  child: Row(
                    children: <Widget>[

                      /// FAKE SPACE UNDER ICON
                      Container(
                        width: _specTileHeight,
                        height: 10,
                      ),

                      /// SELECTED SPECS BOX
                      Container(
                        width: _specTileWidth - _specTileHeight,
                        padding: const EdgeInsets.all(Ratioz.appBarMargin),
                        child: Wrap(
                          spacing: Ratioz.appBarPadding,
                          children: <Widget>[

                            ...List<Widget>.generate(
                                selectedSpecs.length,
                                    (int index){

                                  final Spec _spec = selectedSpecs[index];

                                  final String _specName = Spec.getSpecNameFromSpecsLists(
                                    context: context,
                                    spec: _spec,
                                    specsLists: sourceSpecsLists,
                                  );

                                  return
                                    DreamBox(
                                      height: 30,
                                      icon: Iconz.XLarge,
                                      margins: const EdgeInsets.symmetric(vertical: 2.5),
                                      verse: _specName,
                                      verseColor: Colorz.white255,
                                      verseWeight: VerseWeight.thin,
                                      verseItalic: true,
                                      verseScaleFactor: 1.5,
                                      verseShadow: false,
                                      iconSizeFactor: 0.4,
                                      color: Colorz.black255,
                                      bubble: false,
                                      onTap: () => onDeleteSpec(_spec),
                                    );

                                }
                            ),

                          ],
                        ),
                      ),

                    ],

                  ),
                ),

            ],

          ),
        ),
      ),
    );
  }
}
