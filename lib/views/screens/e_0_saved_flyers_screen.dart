import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/flyer/stacks/sliver_flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
/// then we need to handle this situation


class SavedFlyersScreen extends StatefulWidget {

  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen> {
  Section _currentSection;
  List<Section> _sectionsList;
  List<TinyFlyer> _allTinyFlyers;
  List<TinyFlyer> _filteredTinyFlyers;

  @override
  void initState() {
     _sectionsList = addAllButtonToSections();

     _currentSection = Section.All;

     final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

     _allTinyFlyers =  _prof.getSavedTinyFlyers;

     _filteredTinyFlyers = TinyFlyer.filterTinyFlyersBySection(
       tinyFlyers : _allTinyFlyers,
       section: _currentSection,
     );

     super.initState();
  }
// -----------------------------------------------------------------------------
  List<Section> addAllButtonToSections(){
    List<Section> _originalList = SectionClass.SectionsList;
    List<Section> _newListWithAddButton = <Section>[Section.All,..._originalList];
    return _newListWithAddButton;
  }
// -----------------------------------------------------------------------------
  void _setSection(Section section){
    setState(() {
      _currentSection = section;
      _filteredTinyFlyers = TinyFlyer.filterTinyFlyersBySection(
        tinyFlyers : _allTinyFlyers,
        section: _currentSection,
      );

    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);


    double _sectionBarHeight = Ratioz.appBarButtonSize + Ratioz.appBarPadding;


    return MainLayout(
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: 'Chosen Flyers',
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: GoHomeOnMaxBounce(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          slivers: <Widget>[

            SliverAppBar(
              collapsedHeight: Ratioz.stratosphere + _sectionBarHeight,
              backgroundColor: Colorz.BlackSemi230,
              // title: SuperVerse(verse: 'thing'),
              leadingWidth: 0,
              floating: true,
              leading: Container(),
              flexibleSpace: Container(
                width: _screenWidth,
                height: Ratioz.stratosphere + _sectionBarHeight,
                // color: Colorz.BloodTest,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      width: _screenWidth,
                      height: _sectionBarHeight,
                      alignment: Alignment.center,
                      // color: Colorz.Yellow50,
                      child: ListView.separated(
                        separatorBuilder: (xxx, index){
                          return
                            SizedBox(width: Ratioz.appBarPadding,);
                        },
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        itemCount: _sectionsList.length,
                        padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                        itemBuilder: (ctx, index){

                          Section _section = _sectionsList[index];

                          Color _buttonColor = _currentSection == _section ? Colorz.Yellow255 : null;

                          return
                            Padding(
                              padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                              child: DreamBox(
                                height: Ratioz.appBarButtonSize,
                                icon: Iconizer.sectionIconOff(_section),
                                iconSizeFactor: 0.8,
                                verse: TextGenerator.sectionStringer(context, _section),
                                color: _buttonColor,
                                verseMaxLines: 1,
                                verseCentered: false,
                                bubble: true,
                                verseScaleFactor: 0.7,
                                onTap: () => _setSection(_section),
                              ),
                            );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),

            SliverPadding(
                padding: EdgeInsets.only(bottom: Ratioz.stratosphere),
                sliver: SliverFlyersGrid(
                  tinyFlyers: _filteredTinyFlyers,
                )
            ),

          ],
        ),
      ),
    );
  }
}
