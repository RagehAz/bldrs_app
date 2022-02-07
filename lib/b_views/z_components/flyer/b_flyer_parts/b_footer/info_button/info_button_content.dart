import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/discount_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_graphic.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_page_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/installment_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/normal_price_tag.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:flutter/material.dart';

class InfoButtonContent extends StatelessWidget {

  const InfoButtonContent({
    @required this.flyerBoxWidth,
    @required this.infoButtonType,
    @required this.buttonIsExpanded,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final InfoButtonType infoButtonType;
  final ValueNotifier<bool> buttonIsExpanded;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;

  @override
  Widget build(BuildContext context) {

    final double _cornerValue = InfoButton.expandedCornerValue(context: context, flyerBoxWidth: flyerBoxWidth);
    final BorderRadius _borders = Borderers.superBorderAll(context, _cornerValue);


    return ListView(
      key: const ValueKey<String>('InfoButtonContent'),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ClipRRect(
          borderRadius: _borders,
          child: Container(
            width: InfoButton.expandedWidth(context: context, flyerBoxWidth: flyerBoxWidth),
            height: InfoButton.expandedHeight(flyerBoxWidth: flyerBoxWidth),
            alignment: Alignment.center,
            child: Scroller(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero, /// ENTA EBN WES5A
                children: <Widget>[

                  if (infoButtonType == InfoButtonType.info)
                    InfoGraphic(
                      flyerBoxWidth: flyerBoxWidth,
                    ),

                  if (infoButtonType == InfoButtonType.price)
                    NormalPriceTag(
                        flyerBoxWidth: flyerBoxWidth
                    ),

                  if (infoButtonType == InfoButtonType.discount)
                    DiscountPriceTag(
                        flyerBoxWidth: flyerBoxWidth
                    ),

                  if (infoButtonType == InfoButtonType.installments)
                    InstallmentsPriceTag(
                      flyerBoxWidth: flyerBoxWidth,
                    ),

                  ValueListenableBuilder(
                    valueListenable: buttonIsExpanded,
                    builder: (_, bool buttonExpanded, Widget infoPagePart){

                      return AnimatedOpacity(
                        opacity: buttonExpanded == true ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: infoPagePart,
                      );

                    },

                    child: InfoPagePart(
                      flyerBoxWidth: flyerBoxWidth,
                      flyerModel: flyerModel,
                      flyerZone: flyerZone,
                    ),

                  ),



                ],

              ),
            ),
          ),
        ),

      ],
    );
  }
}
