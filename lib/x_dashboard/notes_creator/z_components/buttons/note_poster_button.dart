import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class PosterTypeButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PosterTypeButton({
    @required this.note,
    @required this.posterType,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final PosterType posterType;
  final ValueChanged<PosterType> onTap;
  // -----------------------------------------------------------------------------
  ///
  static String getPosterTypeIcon({
  @required PosterType posterType,
}){

    switch (posterType){
      case PosterType.flyer :         return Iconz.flyer; break;
      case PosterType.bz :            return Iconz.bz; break;
      case PosterType.cameraImage :   return Iconz.camera; break;
      case PosterType.galleryImage :  return Iconz.phoneGallery; break;
      case PosterType.url :           return Iconz.comWebsite; break;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSelected = note?.poster?.type == posterType;

    return DreamBox(
      height: 40,
      isDeactivated: note?.poster == null,
      width: Scale.getUniformRowItemWidth(
        context: context,
        numberOfItems: 5,
        boxWidth: TileBubble.childWidth(context: context),
        spacing: 5,
      ),
      icon: getPosterTypeIcon(posterType: posterType),
      iconSizeFactor: 0.6,
      iconColor: _isSelected == true ? Colorz.black255 : null,
      color: _isSelected == true ? Colorz.yellow255 : null,
      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
      onTap: () => onTap(posterType),
    );

  }
  // -----------------------------------------------------------------------------
}
