import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class SlidesShelfBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelfBubble({
    @required this.bzModel,
    @required this.draftNotifier,
    @required this.canValidate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final ValueNotifier<DraftFlyer> draftNotifier;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleColor: Formers.validatorBubbleColor(
        canErrorize: canValidate,
        validator: () => Formers.slidesValidator(
          context: context,
          draftFlyer: draftNotifier.value,
          canValidate: canValidate,
        ),
      ),
      headerViewModel: const BubbleHeaderVM(
        headlineVerse: Verse(
          text: 'phid_flyerSlides',
          translate: true,
        ),
      ),
      width: Bubble.bubbleWidth(context),
      columnChildren: <Widget>[

        /// SLIDES SHELF
        SlidesShelf(
          /// PLAN : ADD FLYER LOCATION SLIDE
          bzModel: bzModel,
          shelfNumber: 1,
          draftNotifier: draftNotifier,
        ),


        SuperValidator(
          width: Bubble.clearWidth(context),
          validator: () => Formers.slidesValidator(
            context: context,
            draftFlyer: draftNotifier.value,
            canValidate: canValidate,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
