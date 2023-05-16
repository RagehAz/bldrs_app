part of bldrs_app_bar;

class LineWithBackButtonOnly extends StatelessWidget {

  const LineWithBackButtonOnly({
    @required this.onBack,
    Key key
  }) : super(key: key);

  final Function onBack;

  @override
  Widget build(BuildContext context) {

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
