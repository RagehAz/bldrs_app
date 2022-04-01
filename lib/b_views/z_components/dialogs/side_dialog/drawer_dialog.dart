import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/chain/chain_designs.dart';
import 'package:bldrs/a_models/kw/chain/chain_equipment.dart';
import 'package:bldrs/a_models/kw/chain/chain_products.dart';
import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/side_dialog/section_tile.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerDialog extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DrawerDialog({
    this.width,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  /// --------------------------------------------------------------------------
  static const double drawerEdgeDragWidth = 15;
  static const bool drawerEnableOpenDragGesture = true;
  static const Color drawerScrimColor = Colorz.black125;
  /// --------------------------------------------------------------------------
  @override
  State<DrawerDialog> createState() => _DrawerDialogState();
  /// --------------------------------------------------------------------------
}

class _DrawerDialogState extends State<DrawerDialog> {
  KeywordsProvider _keywordsProvider;
  GeneralProvider _generalProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
    _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    // TextChecker.disposeControllerIfNotEmpty(_searchController);
  }
// -----------------------------------------------------------------------------
//   TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _noResultFound = false;
// ---------------------------
  Future<void> _onSearchChanged(String text) async {
    blog('drawer receives text : $text : Length ${text.length}: _isSearching : $_isSearching');

    /// A - not searching
    if (_isSearching == false) {
      /// A.1 starts searching
      if (text.length > 1) {
        setState(() {
          _isSearching = true;
        });
      }
    }

    /// B - while searching
    else {
      /// B.1 ends searching
      if (text.length < 3) {
        setState(() {
          _isSearching = false;
          _foundKeywords = <KW>[];
        });
      }

      /// B.2 keeps searching
      else {
        final List<KW> _keywords = await _searchKeywords(text);

        /// found results
        if (Mapper.canLoopList(_keywords)) {
          setState(() {
            _foundKeywords = _keywords;
            _noResultFound = false;
          });
        } else {
          setState(() {
            _foundKeywords = <KW>[];
            _noResultFound = true;
          });
        }
      }
    }
  }
// ---------------------------
  Future<void> _onSearchSubmit(String text) async {
    await _searchKeywords(text);
  }
// -----------------------------------------------------------------------------
  List<KW> _foundKeywords = <KW>[];
  Future<List<KW>> _searchKeywords(String text) async {
    List<KW> _results = <KW>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
        searchValue: text,
        docName: LDBDoc.keywords,
        lingoCode: TextChecker.concludeEnglishOrArabicLingo(
            text) //Wordz.languageCode(context),
        );

    if (Mapper.canLoopList(_maps)) {
      _results = KW.decipherKeywordsLDBMaps(maps: _maps);
    }

    return _results;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _drawerWidth = widget.width ?? Scale.superScreenWidth(context) * 0.9;
    final double _drawerHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final double _bubbleWidth = _drawerWidth - (Ratioz.appBarMargin * 2);
    // final double _tileWidth = _bubbleWidth - (Ratioz.appBarMargin * 2);

    const Chain _propertiesChain = ChainProperties.chain;
    const Chain _designsChain = ChainDesigns.chain;
    const Chain _craftsChain = ChainCrafts.chain;
    const Chain _productsChain = ChainProducts.chain;
    const Chain _equipmentChain = ChainEquipment.chain;

    return SizedBox(
      width: _drawerWidth,
      child: Drawer(
        key: const ValueKey<String>('drawer'),
        elevation: 10,
        child: Container(
          width: _drawerWidth,
          height: _drawerHeight,
          color: Colorz.black255,
          alignment: Aligners.superTopAlignment(context),
          child: Column(
            children: <Widget>[

              /// SEARCH BAR
              Container(
                width: _drawerWidth,
                height: Ratioz.appBarButtonSize,
                margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin + Ratioz.appBarPadding
                ),

                child: Row(
                  children: <Widget>[

                    const BackAndSearchButton(
                      backAndSearchAction: BackAndSearchAction.goBack,
                    ),

                    SearchBar(
                      height: Ratioz.appBarButtonSize,
                      boxWidth: _drawerWidth - 40,
                      onSearchSubmit: (String val) => _onSearchSubmit(val),
                      historyButtonIsOn: false,
                      onSearchChanged: (String val) => _onSearchChanged(val),
                      hintText: 'Search Keywords',
                    ),

                  ],
                ),
              ),

              Expanded(
                child: SizedBox(
                  width: _drawerWidth,
                  // height: _drawerHeight - Ratioz.appBarButtonSize - ((Ratioz.appBarMargin + Ratioz.appBarPadding) * 2),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[

                      if (_isSearching == true)
                        Column(
                          children: <Widget>[

                            if (Mapper.canLoopList(_foundKeywords))
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _foundKeywords.length,
                                  itemBuilder: (_, index) {
                                    final KW _keyword = _foundKeywords[index];

                                    return DreamBox(
                                      height: 60,
                                      width: _bubbleWidth,
                                      color: Colorz.white20,
                                      verse:
                                      Phrase.getPhraseByCurrentLangFromPhrases(
                                          context: context,
                                          phrases: _keyword.names
                                      )?.value,
                                      // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
                                      icon: _keywordsProvider.getKeywordIcon(
                                          context: context,
                                          son: _keyword
                                      ),
                                      margins: const EdgeInsets.only(
                                          top: Ratioz.appBarPadding
                                      ),
                                      verseScaleFactor: 0.7,
                                      verseCentered: false,
                                      onTap: () async {},
                                    );
                                  }
                                  ),

                            if (_noResultFound == true)
                              const SuperVerse(
                                verse: 'No Keywords found',
                              ),
                          ],
                        ),

                      if (_isSearching == false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            const SuperVerse(
                              verse: 'SELECT A SECTION',
                              weight: VerseWeight.black,
                              italic: true,
                              centered: false,
                              size: 3,
                              margin: Ratioz.appBarMargin,
                            ),

                            /// REAL ESTATE
                            if (_generalProvider.sectionIsOnline(BzSection.realestate))
                            SectionBubble(
                                title: 'RealEstate',
                                icon: Iconz.pyramidSingleYellow,
                                bubbleWidth: _bubbleWidth,
                                buttons: <Widget>[

                                  SectionTile(
                                    bubbleWidth: _bubbleWidth,
                                    inActiveMode: false,
                                    flyerType: FlyerType.property,
                                    chain: _propertiesChain,
                                  ),

                                ]
                            ),

                            /// Construction
                            if (_generalProvider.sectionIsOnline(BzSection.construction))
                              SectionBubble(
                                title: 'Construction',
                                icon: Iconz.pyramidSingleYellow,
                                bubbleWidth: _bubbleWidth,
                                buttons: <Widget>[

                                  SectionTile(
                                    bubbleWidth: _bubbleWidth,
                                    inActiveMode: false,
                                    flyerType: FlyerType.design,
                                    chain: _designsChain,
                                  ),

                                  MainLayout.spacer10,

                                  SectionTile(
                                    bubbleWidth: _bubbleWidth,
                                    inActiveMode: false,
                                    flyerType: FlyerType.craft,
                                    chain: _craftsChain,
                                  ),

                                ]
                            ),

                            /// Supplies
                            if (_generalProvider.sectionIsOnline(BzSection.supplies))
                              SectionBubble(
                                title: 'Supplies',
                                icon: Iconz.pyramidSingleYellow,
                                bubbleWidth: _bubbleWidth,
                                buttons: <Widget>[

                                  SectionTile(
                                    bubbleWidth: _bubbleWidth,
                                    inActiveMode: false,
                                    flyerType: FlyerType.product,
                                    chain: _productsChain,
                                  ),

                                  MainLayout.spacer10,

                                  SectionTile(
                                    bubbleWidth: _bubbleWidth,
                                    inActiveMode: false,
                                    flyerType: FlyerType.equipment,
                                    chain: _equipmentChain,
                                  ),
                                ],
                              ),

                          ],
                        ),

                      const Horizon(
                        heightFactor: 4,
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
