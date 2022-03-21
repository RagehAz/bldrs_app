import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/modules/translations_manager/widgets/translation_strip.dart';
import 'package:flutter/material.dart';

class TranslationsPage extends StatelessWidget {

  const TranslationsPage({
    @required this.enPhrases,
    @required this.arPhrases,
    @required this.scrollController,
    @required this.onCopyValue,
    @required this.onDeletePhrase,
    @required this.onEditPhrase,
    Key key
  }) : super(key: key);

  final List<Phrase> enPhrases;
  final List<Phrase> arPhrases;
  final ScrollController scrollController;
  final Function onCopyValue;
  /// passes phrase id
  final ValueChanged<String> onDeletePhrase;
  final ValueChanged<String> onEditPhrase;

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final bool _canBuildPhrases =
        canLoopList(enPhrases) == true
            &&
            canLoopList(arPhrases) == true;

    return Container(
      key: const ValueKey<String>('translations_page'),
      width: _screenWidth,
      height: _screenHeight,
      padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + 20),
      alignment: Alignment.topCenter,
      child: Container(
        width: Scale.appBarWidth(context),
        height: _screenHeight - Ratioz.appBarBigHeight - 30,
        decoration: BoxDecoration(
          color: Colorz.black255,
          borderRadius: superBorderAll(context, 30),
        ),
        padding: const EdgeInsets.all(10),
        child: _canBuildPhrases == false ? null :
        ClipRRect(
          borderRadius: superBorderAll(context, 20),
          child: Scroller(
            controller: scrollController,
            child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: arPhrases.length,
                itemBuilder: (_, index){

                  final int _number = index + 1;

                  final bool _canBuild = _number <= arPhrases.length && _number <= enPhrases.length;

                  final Phrase _enPhrase = _canBuild  ? enPhrases[index]  : null;
                  final Phrase _arPhrase = _canBuild  ? arPhrases[index] : null;

                  return TranslationStrip(
                    width: Scale.appBarWidth(context) - 20,
                    enPhrase: _enPhrase,
                    arPhrase: _arPhrase,
                    onCopyValue: onCopyValue,
                    onDelete: () => onDeletePhrase(_enPhrase.id),
                    onEdit: () => onEditPhrase(_enPhrase.id),
                  );


                }
            ),
          ),
        ),
      ),

    );
  }
}
