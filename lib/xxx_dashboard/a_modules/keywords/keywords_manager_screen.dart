import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_equipment.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {

  const KeywordsManager({
    Key key
  }) : super(key: key);

  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    const Chain _chain = ChainEquipment.chain;

    return MainLayout(
      pageTitle: 'All Keywords',
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      layoutWidget: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        itemCount: _chain.sons.length,
          itemBuilder: (_, index){

          final Chain _son = _chain.sons[index];

          return DataTreeChain(
            chain: _son,
          );

          }
      ),
    );
  }
}

class DataTreeChain extends StatefulWidget {

  const DataTreeChain({
    @required this.chain,
    this.initialLevel = 1,
    Key key
  }) : super(key: key);

  final Chain chain;
  final int initialLevel;

  @override
  State<DataTreeChain> createState() => _DataTreeChainState();
}

class _DataTreeChainState extends State<DataTreeChain> {

  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  void _triggerExpansion(){
    _expanded.value = !_expanded.value;
  }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    final int _numberOfSons = widget.chain.sons.length;
    final bool _sonsAreChain = Chain.sonsAreChains(widget.chain.sons);

    return SizedBox(
      width: _screenWidth,
      child: ValueListenableBuilder(
        valueListenable: _expanded,
        child: Column(
          // physics: const NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          children: <Widget>[

            /// WHEN  CHAIN SONS ARE CHAINS
            if (_sonsAreChain == true)
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _numberOfSons,
                  shrinkWrap: true,
                  itemBuilder: (_, index){
                    final Chain son = widget.chain.sons[index];
                    return DataTreeChain(
                      chain: son,
                      initialLevel: widget.initialLevel + 1,

                    );
                  }
              ),

            /// WHEN CHAIN SONS ARE STRINGS (PHRASES IDS)
            if (_sonsAreChain == false) // its a List<String>
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _numberOfSons,
                  shrinkWrap: true,
                  itemBuilder: (_, index){
                    final String keywordID = widget.chain.sons[index];
                    return DataTreeStrip(
                      level: widget.initialLevel + 1,
                      secondLine: keywordID,
                      firstLine: superPhrase(context, keywordID),
                      onTriggerExpansion: (){},
                    );

                  }
              ),

          ],
        ),
        builder: (_, bool _isExpanded, Widget sonsWidgets){

          return Column(

            children: <Widget>[

              /// chain title
              DataTreeStrip(
                level: widget.initialLevel,
                secondLine: widget.chain.id,
                firstLine: superPhrase(context, widget.chain.phraseID),
                expanded: _isExpanded,
                onTriggerExpansion: _triggerExpansion,
              ),

              if (_isExpanded)
                sonsWidgets,

            ],

          );

        },

      ),
    );
  }
}


class DataTreeStrip extends StatelessWidget {

  const DataTreeStrip({
    @required this.level,
    @required this.secondLine,
    @required this.firstLine,
    @required this.onTriggerExpansion,
    this.expanded,
    Key key
  }) : super(key: key);

  final int level;
  final String secondLine;
  final String firstLine;
  final Function onTriggerExpansion;
  final bool expanded;

  static const double stripHeight = 35;

  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    const Color _stripColor = Colorz.black255;

    return Container(
      width: _screenWidth,
      color: Color.fromRGBO(_stripColor.red, _stripColor.green, _stripColor.blue, (90 - (20 * level)) / 100),
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[

          /// LEVEL PADDING + ARROW BOX
          GestureDetector(
            onTap: onTriggerExpansion,
            child: Container(
              width: stripHeight * level,
              height: stripHeight,
              alignment: superInverseCenterAlignment(context),
              child:
              expanded == null ?
              const SizedBox()
              :
              DreamBox(
                width: stripHeight,
                height: stripHeight,
                icon: expanded ? Iconz.arrowDown : superArrowENRight(context),
                iconSizeFactor: 0.3,
                bubble: false,
              ),
            ),
          ),

          /// STRINGS
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SuperVerse(
                verse: firstLine,
                size: 2,
                weight: VerseWeight.bold,
                italic: true,
              ),

              SuperVerse(
                verse: '$level : $secondLine',
                size: 1,
                weight: VerseWeight.thin,
              ),

            ],
          ),

        ],
      ),
    );
  }
}
