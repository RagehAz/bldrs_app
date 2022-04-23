import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/c_add_new_flyer_button.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/a_add_new_flyer_paragraph.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:flutter/material.dart';

class FlyerMakerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreenView({
    @required this.scrollController,
    @required this.shelvesUIs,
    @required this.onCreateNewShelf,
    @required this.bzModel,
    @required this.onDeleteShelf,
    @required this.flyerInput,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ScrollController scrollController;
  final ValueNotifier<List<ValueNotifier<ShelfUI>>> shelvesUIs;
  final Function onCreateNewShelf;
  final BzModel bzModel;
  final ValueChanged<int> onDeleteShelf;
  final FlyerModel flyerInput;
// -----------------------------------------------------------------------------
  bool _addNewFlyerButtonIsDeactivated(){
    if (shelvesUIs.value.length < Standards.maxDraftsAtOnce){
      return false;
    }
    else {
      return true;
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('FlyerMakerScreenView'),
        valueListenable: shelvesUIs,
        builder: (_, List<ValueNotifier<ShelfUI>> _shelvesUIs, Widget child){

          return ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
            itemCount: _shelvesUIs.length + 2,
            itemBuilder: (_, int index){

              /// FIRST ITEM : INITIAL PARAGRAPH
              if (index == 0){
                return const AddNewFlyerParagraph();
              }

              /// LAST ITEM : ADD NEW FLYER BUTTON
              else if (index == _shelvesUIs.length + 1){
                return AddNewDraftShelf(
                  isDeactivated: _addNewFlyerButtonIsDeactivated(),
                  onTap: onCreateNewShelf,
                );
              }

              /// SHELVES
              else {

                final int _shelfIndex = index - 1;

                return ShelfBox(
                  shelfUI: _shelvesUIs[_shelfIndex],
                  child: DraftShelf(
                    // chainKey: _chainsKeys[_chainIndex],
                    bzModel: bzModel,
                    flyerModel: flyerInput,
                    shelfNumber: _shelfIndex + 1,
                    onDeleteDraft: () => onDeleteShelf(_shelfIndex),
                  ),
                );

              }

            },


          );

        }
    );

  }
}
