import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/screens/s20_search_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {

// -----------------------------------------------------------------------------
  void _searchButtonOnTap(BuildContext context){
    // print('search tapped');
    Nav.goToNewScreen(context, SearchScreen());
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: Ratioz.appBarButtonSize,
      width: Ratioz.appBarButtonSize,
      icon: Iconz.Search,
      boxMargins: EdgeInsets.symmetric(horizontal: (Ratioz.appBarSmallHeight - Ratioz.appBarButtonSize)/2),
      corners: Ratioz.appBarButtonCorner,
      iconSizeFactor:  0.5,
      iconRounded: false,
      boxFunction: () => _searchButtonOnTap(context),
    );

  }
}
