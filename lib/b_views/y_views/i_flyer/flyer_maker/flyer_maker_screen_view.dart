import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/add_new_flyer_button.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/add_new_flyer_paragraph.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/draft_shelf.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_box.dart';
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
  final List<ValueNotifier<ShelfUI>> shelvesUIs;
  final Function onCreateNewShelf;
  final BzModel bzModel;
  final ValueChanged<int> onDeleteShelf;
  final FlyerModel flyerInput;
// -----------------------------------------------------------------------------
  bool _addNewFlyerButtonIsDeactivated(){
    if (shelvesUIs.length < Standards.maxDraftsAtOnce){
      return false;
    }
    else {
      return true;
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
      itemCount: shelvesUIs.length + 2,
      itemBuilder: (_, int index){

        /// FIRST ITEM : INITIAL PARAGRAPH
        if (index == 0){
          return const AddNewFlyerParagraph();
        }

        /// LAST ITEM : ADD NEW FLYER BUTTON
        else if (index == shelvesUIs.length + 1){
          return AddNewDraftShelf(
            isDeactivated: _addNewFlyerButtonIsDeactivated(),
            onTap: onCreateNewShelf,
          );
        }

        /// SHELVES
        else {

          final int _shelfIndex = index - 1;
          // final double _shelfHeight = _shelfMaxHeight();

          return ShelfBox(
            shelfUI: shelvesUIs[_shelfIndex],
            child: DraftShelf(
              // chainKey: _chainsKeys[_chainIndex],
              bzModel: bzModel,
              flyerModel: flyerInput,
              shelfNumber: _shelfIndex + 1,
              onDeleteDraft: () => onDeleteShelf(_shelfIndex),
              // onAddPics: () => _getMultiImages(
              //   accountType: BzAccountType.Super,
              //   draftIndex: _chainIndex,
              // ),
              // onDeleteImage: (int imageIndex){
              //   setState(() {
              //     _draftFlyers[_chainIndex].assetsAsFiles.removeAt(imageIndex);
              //     _draftFlyers[_chainIndex].assets.removeAt(imageIndex);
              //   });
              // },
            ),
          );

          // return AnimatedContainer(
          //   // key: ValueKey<String>(_shelvesIndexes[_shelfIndex].id),
          //   duration: _animationDuration,
          //   curve: _animationCurve,
          //   height: _shelvesHeights[_shelfIndex],
          //   margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
          //   child: AnimatedOpacity(
          //     curve: _animationCurve,
          //     duration: _animationDuration,
          //     opacity: _shelvesOpacities[_shelfIndex],
          //     child: DraftShelf(
          //       // chainKey: _chainsKeys[_chainIndex],
          //       bzModel: widget.bzModel,
          //       flyerModel: _flyerInput,
          //       shelfNumber: _shelfIndex + 1,
          //       shelfHeight: _shelfHeight,
          //       onDeleteDraft: () => _deleteShelf(index: _shelfIndex),
          //       // onAddPics: () => _getMultiImages(
          //       //   accountType: BzAccountType.Super,
          //       //   draftIndex: _chainIndex,
          //       // ),
          //       // onDeleteImage: (int imageIndex){
          //       //   setState(() {
          //       //     _draftFlyers[_chainIndex].assetsAsFiles.removeAt(imageIndex);
          //       //     _draftFlyers[_chainIndex].assets.removeAt(imageIndex);
          //       //   });
          //       // },
          //     ),
          //   ),
          // );

        }

      },

      /// GIF THING
      // check this
      // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
      // https://pub.dev/packages/file_picker
      // Container(
      //   width: 200,
      //   height: 200,
      //   margin: EdgeInsets.all(30),
      //   color: Colorz.BloodTest,
      //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
      // ),

    );

  }
}
