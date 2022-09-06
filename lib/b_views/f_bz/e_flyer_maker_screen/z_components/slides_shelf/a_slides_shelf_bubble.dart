import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_validator.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class SlidesShelfBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelfBubble({
    @required this.bzModel,
    @required this.draft,
    @required this.isEditingFlyer,
    @required this.canValidate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final ValueNotifier<DraftFlyerModel> draft;
  final ValueNotifier<bool> isEditingFlyer;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleColor: Colorizer.ValidatorColor(
        canErrorize: canValidate,
        validator: () => Formers.slidesValidator(
          draft: draft.value,
          canValidate: canValidate,
        ),
      ),
      headerViewModel: const BubbleHeaderVM(
        headlineVerse: 'phid_flyer_slides',
      ),
      screenWidth: Bubble.bubbleWidth(context: context, stretchy: false),
      columnChildren: <Widget>[

        /// SLIDES SHELF
        SlidesShelf(
          /// PLAN : ADD FLYER LOCATION SLIDE
          bzModel: bzModel,
          shelfNumber: 1,
          draft: draft,
          isEditingFlyer: isEditingFlyer,
        ),

        SuperValidator(
          width: Bubble.clearWidth(context),
          validator: () => Formers.slidesValidator(
            draft: draft.value,
            canValidate: canValidate,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
