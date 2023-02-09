// ignore_for_file: non_constant_identifier_names
part of bubbles;

class TileBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TileBubble({
    this.bubbleHeaderVM,
    this.bubbleWidth,
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.onTileTap,
    this.secondLine,
    this.secondLineColor = const Color.fromARGB(200, 255, 255, 255),
    this.secondLineTextHeight = 15,
    this.iconIsBubble = true,
    this.insideDialog = false,
    this.moreBtOnTap,
    this.child,
    this.bulletPoints,
    this.bubbleColor = const Color.fromARGB(10, 255, 255, 255),
    this.validator,
    this.autoValidate = true,
    this.textDirection = TextDirection.ltr,
    this.appIsLTR = true,
    this.focusNode,
    this.font,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final BubbleHeaderVM bubbleHeaderVM;
  final Color textColor;
  final Function onTileTap;
  final String secondLine;
  final Color secondLineColor;
  final double secondLineTextHeight;
  final bool iconIsBubble;
  final bool insideDialog;
  final Function moreBtOnTap;
  final Widget child;
  final List<String> bulletPoints;
  final Color bubbleColor;
  final String Function() validator;
  final bool autoValidate;
  final bool appIsLTR;
  final TextDirection textDirection;
  final String font;
  final FocusNode focusNode;
  /// --------------------------------------------------------------------------
  static const double iconBoxWidth = 30; /// delete me 5alas (im in BubbleHeader class)
  // -----------------------------------------------------------------------------

  /// COLOR CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color decipherColor(String colorString) {
    Color _color;

    if (colorString != null) {
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      final String _a = TextMod.removeTextAfterFirstSpecialCharacter(colorString, '*');
      final int _alpha = Numeric.transformStringToInt(_a);

      /// RED
      final String _rX_gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(colorString, '*');
      final String _r = TextMod.removeTextAfterFirstSpecialCharacter(_rX_gX_b, '*');
      final int _red = Numeric.transformStringToInt(_r);

      /// GREEN
      final String _gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(_rX_gX_b, '*');
      final String _g = TextMod.removeTextAfterFirstSpecialCharacter(_gX_b, '*');
      final int _green = Numeric.transformStringToInt(_g);

      /// BLUE
      final String _b = TextMod.removeTextBeforeFirstSpecialCharacter(_gX_b, '*');
      final int _blue = Numeric.transformStringToInt(_b);

      _color = Color.fromARGB(_alpha, _red, _green, _blue);
    }

    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherColor(Color color) {

    final Color _color = color ?? const Color.fromARGB(0, 255, 255, 255);

    final int _alpha = _color.alpha;
    final int _r = _color.red;
    final int _g = _color.green;
    final int _b = _color.blue;

    /// PLAN : CREATE FUNCTION THAT VALIDATES THIS REGEX PATTERN ON DECIPHER COLOR METHOD
    final String _string = '$_alpha*$_r*$_g*$_b';
    return _string;
  }
  // -----------------------------------------------------------------------------

  /// COLOR CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color validatorBubbleColor({
    @required String Function() validator,
    Color defaultColor = const Color.fromARGB(10, 255, 255, 255),
    bool canErrorize = true,
  }){

    bool _errorIsOn = false;
    Color _errorColor;
    if (validator != null){
      // ------
      /// MESSAGE
      final String _validationMessage = validator();
      // ------
      /// ERROR IS ON
      _errorIsOn = _validationMessage != null;
      // ------
      /// BUBBLE COLOR OVERRIDE
      final bool _colorAssigned = TextCheck.stringContainsSubString(string: _validationMessage, subString: 'Δ');
      if (_colorAssigned == true){
        final String _colorCode = TextMod.removeTextAfterFirstSpecialCharacter(_validationMessage, 'Δ');
        _errorColor = decipherColor(_colorCode);
      }
      // ------
    }

    if (_errorIsOn == true && canErrorize == true){
      return _errorColor ?? const Color.fromARGB(150, 94, 6, 6);
    }
    else {
      return defaultColor;
    }

  }
  // -----------------------------------------------------------------------------

  /// COLOR CYPHERS

  // --------------------
  static double childWidth({
    @required BuildContext context,
    double bubbleWidthOverride,
  }) {

    final double _bubbleWidth = Bubble.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );

    return _bubbleWidth - iconBoxWidth - (2 * 10);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidth,
    );
    final double _clearWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );
    final double _childWidth = childWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );

    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(),
      width: _bubbleWidth,
      onBubbleTap: onTileTap,
      bubbleColor: validatorBubbleColor(
        // canErrorize: true,
        defaultColor: bubbleColor,
        validator: validator,
      ),
      columnChildren: <Widget>[

        /// BUBBLE HEADER
        if (bubbleHeaderVM != null)
        BubbleHeader(
          viewModel: bubbleHeaderVM.copyWith(
            headerWidth: _clearWidth,
            font: font,
            textDirection: textDirection,
            appIsLTR: appIsLTR,
          ),
        ),

        /// BULLET POINTS
        Padding(
          padding: Scale.superInsets(
            context: context,
            appIsLTR: appIsLTR,
            enLeft: iconBoxWidth,
          ),
          child: BulletPoints(
            bulletPoints: bulletPoints,
            boxWidth: _childWidth,
            appIsLTR: appIsLTR,
            textDirection: textDirection,
            font: font,
          ),
        ),

        /// SECOND LINE
        if (secondLine != null)
          SizedBox(
            width: _bubbleWidth,
            child: Row(
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// SECOND LINE
                SizedBox(
                  width: _childWidth,
                  child: SuperText(
                    text: secondLine,
                    textColor: secondLineColor,
                    textHeight: secondLineTextHeight,
                    // scaleFactor: 1,
                    italic: true,
                    maxLines: 100,
                    centered: false,
                    weight: FontWeight.w100,
                    margins: 5,
                    textDirection: textDirection,
                    appIsLTR: appIsLTR,
                    font: font,
                  ),
                ),

              ],
            ),
          ),

        /// CHILD
        if (child != null)
          SizedBox(
            width: _bubbleWidth,
            // height: 200,
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            // color: Colorz.Yellow255,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// CHILD
                Container(
                  width: childWidth(context: context, bubbleWidthOverride: _bubbleWidth),
                  // decoration: BoxDecoration(
                  //     color: Colorz.white10,
                  //     borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue)
                  // ),
                  alignment: Alignment.center,
                  child: child,
                ),

              ],
            ),
          ),

        if (validator != null)
          SuperValidator(
            width: _clearWidth,
            validator: validator,
            autoValidate: autoValidate,
            font: bubbleHeaderVM.font,
            focusNode: focusNode,
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
