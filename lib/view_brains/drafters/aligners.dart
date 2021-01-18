import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:flutter/material.dart';

Alignment superTopAlignment(BuildContext context){
  return
      // Alignment.centerLeft ;
  getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.topLeft : Alignment.topRight;
}

Alignment superCenterAlignment(BuildContext context){
  return
      // Alignment.centerLeft ;
  getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;
}

Alignment superInverseCenterAlignment(BuildContext context){
  return
      // Alignment.centerLeft ;
  getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerRight : Alignment.centerLeft;
}

Alignment superInverseTopAlignment(BuildContext context){
  return
    // Alignment.centerLeft ;
    getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.topRight : Alignment.topLeft;
}
