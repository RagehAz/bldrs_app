import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class PublishButton extends StatelessWidget {
  final bool firstTimer;

  PublishButton({
    @required this.firstTimer,
});

  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: 35,
      margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      verse: firstTimer ? 'Publish flyer' : 'update flyer',
      verseColor: Colorz.BlackBlack,
      verseScaleFactor: 0.8,
      color: Colorz.Yellow,
      icon: Iconz.AddFlyer,
      iconSizeFactor: 0.6,
      // onTap: widget.firstTimer ? _createNewFlyer : _updateExistingFlyer,
    );
  }
}
