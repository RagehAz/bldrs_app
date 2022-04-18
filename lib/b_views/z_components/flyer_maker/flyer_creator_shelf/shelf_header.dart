import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_creator_shelf/shelf_header.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_creator_shelf/shelf_slide.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/c_controllers/i_flyer_publisher_controllers/flyer_publisher_controller.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:bldrs/x_dashboard/bldrs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ShelfHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfHeader({
    @required this.draft,
    @required this.shelfNumber,
    @required this.titleLength,
    @required this.formKey,
    @required this.onMoreTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyerModel draft;
  final int shelfNumber;
  final ValueNotifier<int> titleLength;
  final GlobalKey<FormState> formKey;
  final Function onMoreTap;
  /// --------------------------------------------------------------------------
  static const double height = 80;
// -----------------------------------------------------------------------------
  String _firstHeadlineValidator(String val){

    if(val.length >= Standards.flyerTitleMaxLength){

      // if(_counterColor != Colorz.red255){
      //   setState(() {
      //     _counterColor = Colorz.red255;
      //   });
      // }

      return 'Only ${Standards.flyerTitleMaxLength} characters allowed for the flyer title';
    }

    else {

      // if(_counterColor != Colorz.white80){
      //   setState(() {
      //     _counterColor = Colorz.white80;
      //   });
      // }

      return null;
    }
  }
// -----------------------------------------------------------------------------
  void _firstHeadlineOnChanged(String val){
    formKey.currentState.validate();
    titleLength.value = val.length;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _shelfTitle = DraftFlyerModel.generateShelfTitle(
      context: context,
      times: draft.times,
      flyerState: draft.flyerState,
      shelfNumber: shelfNumber,
    );
    final bool _isPublished = draft.flyerState == FlyerState.published;
    final bool _hasSlides = canLoopList(draft.mutableSlides);
    // HEIGHT ----------------------------------------------------------------------------
    const double _shelfNumberZoneHeight = 20;
    const double _headlineTextZoneHeight = height - _shelfNumberZoneHeight;
    const double _textFieldHeight = _headlineTextZoneHeight;
    // WIDTH ----------------------------------------------------------------------------
    final double _shelfWidth = Scale.superScreenWidth(context);
    const double _spacing = Ratioz.appBarMargin;
    const double _controlPanelWidth = _textFieldHeight * 0.7;
    const double _moreButtonSize = _textFieldHeight * 0.7;
    final double _headlineZoneWidth = _shelfWidth - _controlPanelWidth - (_spacing * 3);


    return Container(
      // key: const ValueKey<String>('ShelfHeader'),
      width: _shelfWidth,
      height: height,
      alignment: Aligners.superCenterAlignment(context),
      // color: Colorz.bloodTest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          /// SPACER
          const SizedBox(width: _spacing,),

          /// SHELF HEADLINE
          SizedBox(
            width: _headlineZoneWidth,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// SHELF NUMBER + COUNTER
                SizedBox(
                  width: _headlineZoneWidth,
                  height: _shelfNumberZoneHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      /// CHAIN NUMBER
                      SuperVerse(
                        verse: _shelfTitle,
                        size: 1,
                        italic: true,
                        color: _isPublished ? Colorz.green255: Colorz.white80,
                        weight: VerseWeight.thin,
                      ),

                      /// TEXT FIELD COUNTER
                      if  (_isPublished == false && _hasSlides)
                        ValueListenableBuilder(
                            valueListenable: titleLength,
                            builder: (_, int _titleLength, Widget child){

                              final Color _color = _titleLength >= Standards.flyerTitleMaxLength ?
                              Colorz.red255
                                  :
                              Colorz.white80;

                              return SuperVerse(
                                verse: '$_titleLength / ${Standards.flyerTitleMaxLength}',
                                size: 1,
                                italic: true,
                                color: _color,
                                weight: VerseWeight.thin,
                              );

                            }
                        ),

                    ],
                  ),
                ),

                /// FIRST HEADLINE TEXT FIELD
                if  (_isPublished == false && _hasSlides)
                  SizedBox(
                    width: _headlineZoneWidth,
                    height: _headlineTextZoneHeight,
                    child: Form(
                      key: key,
                      child: SuperTextField(
                        // onTap: (){},
                        fieldIsFormField: true,
                        height: height,
                        width: _textFieldHeight,
                        maxLines: 1,
                        counterIsOn: false,
                        validator: (val) => _firstHeadlineValidator(val),
                        // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                        hintText: 'Flyer Headline ...',
                        textController: draft.mutableSlides[0].headline,
                        // maxLength: Standards.flyerTitleMaxLength,
                        onChanged: (value) => _firstHeadlineOnChanged(value),

                      ),
                    ),
                  ),

                // /// FIRST HEADLINE AS SUPER VERSE
                // if (_isPublished == true && _hasSlides)
                //   Container(
                //     width: _flyerTitleZoneWidth,
                //     height: _deleteFlyerButtonSize,
                //     decoration: BoxDecoration(
                //       color: Colorz.white10,
                //       borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12),
                //     ),
                //     alignment: Aligners.superCenterAlignment(context),
                //     padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                //     child: SuperVerse(
                //       verse: draft.mutableSlides[0].headline.text,
                //       centered: false,
                //       size: 3,
                //     ),
                //   ),

              ],
            ),
          ),

          /// SPACER
          const SizedBox(width: _spacing,),

          /// CONTROL PANEL
          Container(
            width: _controlPanelWidth,
            height: height,
            alignment: Alignment.center,
            // color: Colorz.blue20,
            child: DreamBox(
                height: _moreButtonSize,
                width: _moreButtonSize,
                icon: Iconz.more,
                iconSizeFactor: 0.5,
                onTap: onMoreTap
            ),

          ),

          /// SPACER
          const SizedBox(width: _spacing,),

        ],
      ),
    );
  }
}
