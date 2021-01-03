import 'package:flutter/material.dart';

    // TO MINIMIZE KEYBOARD WHEN TAPPING OUTSIDE
    // USE THIS TO CALL THE FUNCTION TO PASS THE context
    //  onTap: () => minimizeKeyboardOnTapOutSite(context),

void minimizeKeyboardOnTapOutSide (BuildContext context){
FocusScope.of(context).requestFocus(FocusNode());
}
