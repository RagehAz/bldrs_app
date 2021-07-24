import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class PublishButton extends StatelessWidget {
  final bool firstTimer;
  final bool loading;
  final Function onTap;

  PublishButton({
    @required this.firstTimer,
    @required this.loading,
    this.onTap,
});
// -----------------------------------------------------------------------------
  String _verse(){
    String _verse;

    /// IF CREATING NEW FLYER
    if (firstTimer){
      _verse = loading ? 'Uploading ..' : 'Publish flyer';
    }
    /// IF UPDATING EXISTING FLYER
    else {
      _verse = loading ? 'Updating ..' : 'Update flyer';
    }

    return _verse;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return
      DreamBox(
        height: Ratioz.appBarButtonSize,
        width: Ratioz.appBarButtonSize * 3.5,
        margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        verse: _verse(),
        verseColor: loading ? Colorz.White255 : Colorz.Black230,
        verseScaleFactor: 0.9,
        color: loading ? Colorz.Yellow125 : Colorz.Yellow255,
        icon: loading ? null : Iconz.AddFlyer,
        bubble: loading ? false : true,
        iconSizeFactor: 0.6,
        onTap: onTap,
        loading: loading,
      );
  }
}
