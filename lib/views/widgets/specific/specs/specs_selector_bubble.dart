import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SpecSelectorBubble extends StatelessWidget {
  final SpecList specList;
  final List<Spec> selectedSpecs;
  final ValueChanged<KW> onSpecTap;
  final double bubbleHeight;

  const SpecSelectorBubble({
    @required this.specList,
    @required this.selectedSpecs,
    @required this.onSpecTap,
    @required this.bubbleHeight,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return Container(
      width: _screenWidth,
      height: bubbleHeight,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: BldrsAppBar.width(context),
        height: bubbleHeight - (2 * Ratioz.appBarMargin),
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner)
        ),
        child: ListView.builder(
            itemCount: specList.specChain.sons.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (ctx, index){

              final KW _kw = specList.specChain.sons[index];

              final bool _specsContainThis = Spec.specsContainThisSpec(
                specs: selectedSpecs,
                spec: Spec.getSpecFromKW(kw: _kw, specsListID: specList.id),
              );

              final Color _color = _specsContainThis == true ? Colorz.green255 : null;

              return

                DreamBox(
                  width: BldrsAppBar.width(context) - Ratioz.appBarMargin * 2,
                  height: BldrsAppBar.height(context, AppBarType.Basic),
                  margins: 5,
                  verse: Name.getNameByCurrentLingoFromNames(context, _kw.names),
                  verseWeight: VerseWeight.thin,
                  verseScaleFactor: 0.9,
                  color: _color,
                  onTap: () => onSpecTap(_kw),
                );

            }
        ),
      ),
    );
  }
}
