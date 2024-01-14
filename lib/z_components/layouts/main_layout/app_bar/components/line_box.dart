part of bldrs_app_bar;

class LineBox extends StatelessWidget {

  const LineBox({
    required this.mainAxisAlignment,
    required this.children,
    super.key
  });
  
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );

  }

}
