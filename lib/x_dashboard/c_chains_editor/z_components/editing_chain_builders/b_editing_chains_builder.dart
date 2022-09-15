import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/z_components/editing_chain_builders/a_editing_chain_splitter.dart';
import 'package:flutter/material.dart';

class EditingChainsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditingChainsBuilder({
    @required this.sons,
    @required this.previousPath,
    @required this.width,
    @required this.level,
    @required this.onPhidTap,
    @required this.selectedPhids,
    @required this.initiallyExpanded,
    @required this.onAddToPath,
    @required this.secondLinesType,
    @required this.onDoubleTap,
    @required this.onReorder,
    this.searchText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic sons;
  final String previousPath;
  final double width;
  final int level;
  final Function(String path, String phid) onPhidTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<String> searchText;
  final Function(String path) onAddToPath;
  final ChainSecondLinesType secondLinesType;
  final ValueChanged<String> onDoubleTap;
  final Function({int oldIndex, int newIndex, List<dynamic> sons, String previousPath, int level}) onReorder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentWidth: width,
      level: level,
    );

    return SizedBox(
      key: const ValueKey<String>('EditingChainsBuilder'),
      width: width,
      child: ReorderableListView.builder(
        itemCount: sons.length + 1,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: level == 0 ? Stratosphere.getStratosphereSandwich(
          context: context,
          appBarType: AppBarType.search,
          // withHorizon: true,
        )
            :
        const EdgeInsets.symmetric(
          vertical: Ratioz.appBarPadding,
        ),
        onReorder: (oldIndex, newIndex) {

          int _newIndex = newIndex;
          if (newIndex > oldIndex) {
            _newIndex = newIndex - 1;
          }

          onReorder(
            newIndex: _newIndex,
            oldIndex: oldIndex,
            sons: sons,
            level: level,
            previousPath: previousPath,
          );

        },
        onReorderStart: (int oldIndex){},
        onReorderEnd: (int newIndex){},
        itemBuilder: (_, int index){

          final bool _isLastObject = index == sons?.length;

          if (_isLastObject == false){

            final dynamic son = sons[index];

            final String _key = Phider.getPossibleID(son);

            return Container(
              key: ValueKey<String>('son_$_key'),
              width: _sonWidth,
              margin: const EdgeInsets.only(
                bottom: Ratioz.appBarPadding,
                left: Ratioz.appBarPadding,
                right: Ratioz.appBarPadding,
              ),
              child: EditingChainSplitter(
                previousPath: previousPath,
                chainOrChainsOrSonOrSons: son,
                width: _sonWidth,
                onSelectPhid: onPhidTap,
                selectedPhids: selectedPhids,
                initiallyExpanded: initiallyExpanded,
                level: level+1,
                searchText: searchText,
                onAddToPath: onAddToPath,
                secondLinesType: secondLinesType,
                onDoubleTap: onDoubleTap,
                onReorder: onReorder,
              ),
            );

          }

          /// ADD TO PATH BUTTON
          else {

            return DreamBox(
              key: const ValueKey<String>('add_button'),
              height: 60,
              width: _sonWidth,
              verse:  const Verse(text: 'Add to path :', translate: false),
              secondLine: Verse.plain('$previousPath/...'),
              icon: Iconz.plus,
              iconSizeFactor: 0.5,
              verseScaleFactor: 1.2,
              secondLineScaleFactor: 1.1,
              secondLineColor: Colorz.black255,
              secondVerseMaxLines: 2,
              verseCentered: false,
              verseColor: Colorz.black255,
              color: Colorz.yellow255,
              margins: const EdgeInsets.only(
                bottom: Ratioz.appBarPadding,
                left: Ratioz.appBarPadding,
                right: Ratioz.appBarPadding,
              ),
              onTap: () => onAddToPath(previousPath),
            );

          }

        },
      ),
    );

    // return SizedBox(
    //   key: const ValueKey<String>('ChainSonsBuilder'),
    //   width: width,
    //   child: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     padding: const EdgeInsets.symmetric(
    //       vertical: Ratioz.appBarPadding,
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: <Widget>[
    //
    //         ...List.generate(sons?.length ?? 0, (index){
    //
    //           final dynamic son = sons[index];
    //
    //           return Container(
    //             width: _sonWidth,
    //             margin: const EdgeInsets.only(
    //               bottom: Ratioz.appBarPadding,
    //               left: Ratioz.appBarPadding,
    //               right: Ratioz.appBarPadding,
    //             ),
    //             child: ChainSplitter(
    //               previousPath: previousPath,
    //               chainOrChainsOrSonOrSons: son,
    //               width: _sonWidth,
    //               onSelectPhid: onPhidTap,
    //               selectedPhids: selectedPhids,
    //               initiallyExpanded: initiallyExpanded,
    //               level: level+1,
    //               searchText: searchText,
    //               onAddToPath: onAddToPath,
    //               secondLinesType: secondLinesType,
    //               editMode: true,
    //               onLongPress: onLongPress,
    //             ),
    //           );
    //
    //         }),
    //
    //         if (onAddToPath != null)
    //         DreamBox(
    //           height: 60,
    //           width: _sonWidth,
    //           verse:  'Add to path :',
    //           secondLine: '$previousPath/...',
    //           icon: Iconz.plus,
    //           iconSizeFactor: 0.5,
    //           verseScaleFactor: 1.2,
    //           secondLineScaleFactor: 1.1,
    //           secondLineColor: Colorz.black255,
    //           secondVerseMaxLines: 2,
    //           verseCentered: false,
    //           verseColor: Colorz.black255,
    //           color: Colorz.yellow255,
    //           margins: const EdgeInsets.only(
    //             bottom: Ratioz.appBarPadding,
    //             left: Ratioz.appBarPadding,
    //             right: Ratioz.appBarPadding,
    //           ),
    //           onTap: () => onAddToPath(previousPath),
    //         ),
    //
    //       ],
    //     ),
    //
    //   ),
    //
    // );

  }
  // -----------------------------------------------------------------------------
}
