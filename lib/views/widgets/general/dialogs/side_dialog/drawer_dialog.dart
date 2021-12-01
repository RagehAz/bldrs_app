import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/models/kw/section_class.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/chain/chain_crafts.dart';
import 'package:bldrs/models/kw/chain/chain_designs.dart';
import 'package:bldrs/models/kw/chain/chain_equipment.dart';
import 'package:bldrs/models/kw/chain/chain_products.dart';
import 'package:bldrs/models/kw/chain/chain_properties.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/views/widgets/general/appbar/search_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/zebala/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerDialog extends StatefulWidget {
  final double width;

  const DrawerDialog({
    this.width = 350,
    Key key,
  }) : super(key: key);

  static const double drawerEdgeDragWidth = 15;
  static const bool drawerEnableOpenDragGesture = true;
  static const Color drawerScrimColor = Colorz.black125;

  @override
  State<DrawerDialog> createState() => _DrawerDialogState();
}

class _DrawerDialogState extends State<DrawerDialog> {
  KeywordsProvider _keywordsProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
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

    print('drawer receives text : ${text} : Length ${text.length}: _isSearching : ${_isSearching}');

    /// A - not searching
    if (_isSearching == false){

      /// A.1 starts searching
      if (text.length > 1){

        setState(() {
          _isSearching = true;
        });

      }

    }

    /// B - while searching
    else {

      /// B.1 ends searching
      if (text.length < 3){
        setState(() {
          _isSearching = false;
          _foundKeywords = [];
        });
      }

      /// B.2 keeps searching
      else {

        List<KW> _keywords = await _searchKeywords(text);

        /// found results
        if (Mapper.canLoopList(_keywords)){
          setState(() {
            _foundKeywords = _keywords;
            _noResultFound = false;
          });
        }
        else {
          setState(() {
            _foundKeywords = [];
            _noResultFound = true;
          });
        }

      }

    }

  }
// ---------------------------
  Future<void> _onSearchSubmit(String text) async {
    _searchKeywords(text);
  }
// -----------------------------------------------------------------------------
  List<KW> _foundKeywords = <KW>[];
  Future<List<KW>> _searchKeywords(String text) async {

    List<KW> _results = <KW>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
      searchValue: text,
      docName: LDBDoc.keywords,
      lingoCode: TextChecker.concludeEnglishOrArabicLingo(text)//Wordz.languageCode(context),
    );

    if (Mapper.canLoopList(_maps)){
      _results = KW.decipherKeywordsLDBMaps(maps: _maps);
    }

    return _results;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _drawerWidth = widget.width;
    final double _drawerHeight = Scale.superScreenHeight(context);

    final double _bubbleWidth = _drawerWidth - (Ratioz.appBarMargin * 2);
    // final double _tileWidth = _bubbleWidth - (Ratioz.appBarMargin * 2);

    const Chain _propertiesChain = ChainProperties.chain;
    const Chain _designsChain = ChainDesigns.chain;
    const Chain _craftsChain = ChainCrafts.chain;
    const Chain _productsChain = ChainProducts.chain;
    const Chain _equipmentChain = ChainEquipment.chain;

    return Container(
      width: _drawerWidth,
      child: Drawer(
        key: const ValueKey<String>('drawer'),
        elevation: 10,
        child: Container(
          width: _drawerWidth,
          height: _drawerHeight,
          color: Colorz.black255,
          alignment: Aligners.superTopAlignment(context),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// SEARCH BAR
              Container(
                width: _drawerWidth,
                height: 80,
                child: SearchBar(
                  searchController: null,
                  onSearchSubmit: (String val) => _onSearchSubmit(val),
                  historyButtonIsOn: false,
                  onSearchChanged: (String val) => _onSearchChanged(val),
                  boxWidth: _drawerWidth,
                  hintText: 'Search Sections Keywords',
                ),
              ),

              if (_isSearching == true)
                Column(
                  children: <Widget>[

                    if (Mapper.canLoopList(_foundKeywords))
                      ...List.generate(_foundKeywords.length, (int index){

                        final KW _keyword = _foundKeywords[index];

                        return
                          DreamBox(
                            height: 60,
                            width: _bubbleWidth,
                            color: Colorz.white20,
                            verse: Name.getNameByCurrentLingoFromNames(context, _keyword.names),
                            // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
                            icon: _keywordsProvider.getIcon(context: context, son: _keyword),
                            margins: const EdgeInsets.only(top: Ratioz.appBarPadding),
                            verseScaleFactor: 0.7,
                            verseCentered: false,
                            onTap: () async {},
                          );

                      }),

                    if (_noResultFound == true)
                      SuperVerse(
                        verse: 'No Keywords found',

                      ),


                  ],
                ),

                if (_isSearching == false)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SuperVerse(
                      verse: 'SELECT A SECTION',
                      weight: VerseWeight.black,
                      italic: true,
                      centered: false,
                      size: 3,
                      margin: Ratioz.appBarMargin,
                    ),

                    /// REAL ESTATE
                    SectionBubble(
                        title: 'RealEstate',
                        icon: Iconz.PyramidSingleYellow,
                        bubbleWidth: _bubbleWidth,
                        buttons: <Widget>[

                          SectionTile(
                            bubbleWidth: _bubbleWidth,
                            inActiveMode: false,
                            section: Section.properties,
                            chain: _propertiesChain,
                          ),

                        ]
                    ),

                    /// Construction
                    SectionBubble(
                        title: 'Construction',
                        icon: Iconz.PyramidSingleYellow,
                        bubbleWidth: _bubbleWidth,
                        buttons: <Widget>[

                          SectionTile(
                            bubbleWidth: _bubbleWidth,
                            inActiveMode: false,
                            section: Section.designs,
                            chain: _designsChain,
                          ),

                          MainLayout.spacer10,

                          SectionTile(
                            bubbleWidth: _bubbleWidth,
                            inActiveMode: false,
                            section: Section.crafts,
                            chain: _craftsChain,
                          ),

                        ]
                    ),

                    /// Supplies
                    SectionBubble(
                      title: 'Supplies',
                      icon: Iconz.PyramidSingleYellow,
                      bubbleWidth: _bubbleWidth,
                      buttons: <Widget>[

                        SectionTile(
                          bubbleWidth: _bubbleWidth,
                          inActiveMode: false,
                          section: Section.products,
                          chain: _productsChain,
                        ),

                        MainLayout.spacer10,

                        SectionTile(
                          bubbleWidth: _bubbleWidth,
                          inActiveMode: false,
                          section: Section.equipment,
                          chain: _equipmentChain,
                        ),

                      ],
                    ),

                  ],
                ),

              const PyramidsHorizon(heightFactor: 0.5,),

            ],
          ),
        ),
      ),
    );
  }
}
