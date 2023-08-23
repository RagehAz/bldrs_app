part of bldrs_app_bar;

class LineWithBackButtonOnly extends StatelessWidget {

  const LineWithBackButtonOnly({
    required this.onBack,
    required this.canGoBack,
    super.key
  });
  
  final Function onBack;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {

    if (canGoBack == false){
      return const SizedBox();
    }

    else {
      return LineBox(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          const SizedBox(width: Ratioz.appBarPadding),

          BackAndSearchButton(
            backAndSearchAction: BackAndSearchAction.goBack,
            onTap: onBack,
          ),

        ],
      );
    }

  }

}
