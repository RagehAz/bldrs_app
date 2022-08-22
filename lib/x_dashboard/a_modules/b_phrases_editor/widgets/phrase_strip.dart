import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class PhraseStrip extends StatelessWidget {
// -----------------------------------------------------------------------------
  const PhraseStrip({
    @required this.width,
    @required this.enPhrase,
    @required this.arPhrase,
    @required this.onDelete,
    @required this.onEdit,
    @required this.onCopyValue,
    @required this.searchController,
    Key key
  }) : super(key: key);
// -----------------------------------------------------------------------------
  final double width;
  final Phrase enPhrase;
  final Phrase arPhrase;
  final Function onDelete;
  final Function onEdit;
  final ValueChanged<String> onCopyValue;
  final TextEditingController searchController;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _idsAreTheSame = enPhrase?.id == arPhrase?.id;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: Borderers.superBorderAll(context, 20),
        color: _idsAreTheSame ? Colorz.white20 : Colorz.red255,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: <Widget>[

          if (_idsAreTheSame == false)
            const SuperVerse(
              verse: 'CAUTION : IDs Are Not The Same !!',
            ),

          SizedBox(
            width: width,
            height: 30,
            child: Row(
              children: <Widget>[

                /// PHRASE ID
                SizedBox(
                  width: width - 30 - 15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      SuperVerse(
                        verse: 'en ID : ${enPhrase?.id}',
                        highlight: searchController,
                        labelColor: Colorz.white20,
                        size: 1,
                        scaleFactor: 1.1,
                        italic: true,
                        centered: false,
                        weight: VerseWeight.thin,
                        onTap: () => onCopyValue(enPhrase?.id),
                      ),
                    ],
                  ),
                ),

                const Expander(),

                /// EDIT PHRASE BUTTON
                DreamBox(
                  height: 30,
                  width: 30,
                  icon: Iconz.star,
                  iconSizeFactor: 0.6,
                  onTap: () async {

                    final String title = enPhrase?.id == arPhrase?.id ?
                    arPhrase?.id
                        :
                    'enID : ${enPhrase?.id} : arID ${arPhrase?.id}';

                    await BottomDialog.showBottomDialog(
                        context: context,
                        draggable: true,
                        title: title,
                        child: Column(
                          children: <Widget>[

                            SuperVerse(
                              verse: enPhrase?.value,
                              maxLines: 5,
                              color: Colorz.yellow255,
                              weight: VerseWeight.thin,
                              margin: 5,
                            ),

                            SuperVerse(
                              verse: arPhrase.value,
                              maxLines: 5,
                              color: Colorz.yellow255,
                              weight: VerseWeight.thin,
                              margin: 5,
                            ),

                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),

                            DreamBox(
                              width: BottomDialog.clearWidth(context),
                              height: 40,
                              verse: 'Edit',
                              margins: const EdgeInsets.only(bottom: 5),
                              onTap: onEdit,
                            ),

                            DreamBox(
                              width: BottomDialog.clearWidth(context),
                              height: 40,
                              verse: 'Delete',
                              margins: const EdgeInsets.only(bottom: 5),
                              onTap: onDelete,
                            ),

                          ],

                        ),
                    );

                  },
                ),

              ],
            ),
          ),

          SizedBox(
            width: width,
            height: 35,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[

                /// EN VALUE
                SuperVerse(
                  verse: enPhrase?.value,
                  labelColor: Colorz.white20,
                  highlight: searchController,
                  onTap: () => onCopyValue(enPhrase?.value),
                ),

                /// AR VALUE
                SuperVerse(
                  verse: arPhrase?.value,
                  labelColor: Colorz.white20,
                  highlight: searchController,
                  onTap: () => onCopyValue(arPhrase?.value),
                ),

              ],
            ),
          ),

        ],
      ),
    );

  }
}
