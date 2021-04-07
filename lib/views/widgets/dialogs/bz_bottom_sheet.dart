import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/flyer/bz_card_preview.dart';
import 'package:flutter/cupertino.dart';
import 'bottom_sheet.dart';

void slideBzBottomSheet({BuildContext context, BzModel bz, AuthorModel author}) {
  BottomSlider.slideBottomSheet(
      context: context,
      height: superScreenHeight(context) - 100,
      draggable: true,
      child: Center(
        child: BzCardPreview(
          flyerSizeFactor: 0.71,
          bz: bz,
          author: author,
        ),
      ));
}
