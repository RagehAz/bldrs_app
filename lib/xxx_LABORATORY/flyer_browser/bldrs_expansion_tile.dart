import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BldrsExpansionTile extends StatefulWidget {
  final String icon;
  final double iconSizeFactor;
  final String title;
  final String subTitle;
  final List<String> keywords;
  final double height;
  final Function onKeywordTap;
  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;

  const BldrsExpansionTile({
    Key key,
    this.icon,
    this.iconSizeFactor = 1,
    @required this.title,
    this.subTitle,
    this.keywords,
    this.height,
    this.onKeywordTap,
    this.onExpansionChanged,
    this.initiallyExpanded: false,
  })
      : assert(initiallyExpanded != null),
        super(key: key);


  @override
  BldrsExpansionTileState createState() => new BldrsExpansionTileState();
}

class BldrsExpansionTileState extends State<BldrsExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _titleColorTween;
  ColorTween _tileColorTween;
  ColorTween _subtitleLabelColorTween;
  BorderRadiusTween _borderRadius;
  Animation<double> _iconTurns;
  bool _isExpanded = false;
  static const Duration _kExpand = const Duration(milliseconds: 200);
  final GlobalKey<BldrsExpansionTileState> _expansionTileKey = new GlobalKey();

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _titleColorTween = new ColorTween();
    _tileColorTween = new ColorTween();
    _subtitleLabelColorTween = new ColorTween();
    _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded)
      _controller.value = 1.0;
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void expand() {
    _setExpanded(true);
  }
// -----------------------------------------------------------------------------
  void collapse() {
    _setExpanded(false);
  }
// -----------------------------------------------------------------------------
  void toggle() {
    _setExpanded(!_isExpanded);
  }
// -----------------------------------------------------------------------------
  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded)
          _controller.forward();
        else
          _controller.reverse().then<void>((dynamic value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged(_isExpanded);
      }
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    _borderColor.end = Colorz.Green;

    _titleColorTween
      ..begin = Colorz.White
      ..end = Colorz.White;

    _tileColorTween
      ..begin = Colorz.WhiteAir
      ..end = Colorz.BabyBlueSmoke;

    _subtitleLabelColorTween
      ..begin = Colorz.WhiteAir
      ..end = Colorz.WhiteAir;

    _borderRadius
       ..begin = BorderRadius.circular(Ratioz.ddAppBarCorner - 5)
       ..end = BorderRadius.circular(Ratioz.ddAppBarCorner - 5);


    final bool closed = !_isExpanded && _controller.isDismissed;

    final double _buttonVerticalPadding = 5;
    final double _buttonHeight = 40;
    final double _buttonExtent = _buttonHeight + _buttonVerticalPadding * 2;

    return new AnimatedBuilder(
      animation: _controller.view,

      /// Collapsed Tile
      builder: (context, child){

        // final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final double _iconSize = 40;
        final Color _titleColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);
        final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);

        return

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: _tileColor,
              borderRadius: Borderers.superBorderAll(context, Ratioz.ddAppBarCorner),
            ),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                IconTheme.merge(
                  data: new IconThemeData(color: _tileColorTween.evaluate(_easeInAnimation)),
                  child: new ListTile(
                    onTap: toggle,
                    leading: widget.icon == null ? null : DreamBox(
                      height: _iconSize,
                      width: _iconSize,
                      icon: widget.icon,
                      iconSizeFactor: widget.iconSizeFactor,
                    ),
                    title: SuperVerse(
                      verse: widget.title,
                      color: _titleColor,
                      centered: false,
                      shadow: false,
                    ),

                    subtitle: SuperVerse(
                      verse: widget.subTitle,
                      color: _isExpanded ? Colorz.WhiteLingerie : Colorz.WhitePlastic,
                      weight: VerseWeight.thin,
                      italic: true,
                      size: 2,
                      centered: false,
                      labelColor: _subTitleLabelColor,
                    ),
                    trailing: new RotationTransition(
                      turns: _iconTurns,
                      child: DreamBox(
                        height: _iconSize,
                        width: _iconSize,
                        bubble: false,
                        icon: Iconz.ArrowDown,
                        iconSizeFactor: 0.3,
                        iconColor: _titleColor,
                      ),
                    ),
                  ),
                ),

                ClipRRect(
                  // borderRadius: _borderRadius.evaluate(_easeInAnimation),
                  child: new Align(
                    heightFactor: _easeInAnimation.value,
                    child: child,
                  ),
                ),

              ],
            ),
          );

      },

      /// Expanded tile children
      child: closed ? null
          :
      Container(
        height: widget.height == null ? (_buttonExtent * widget.keywords.length).toDouble() : widget.height,
        decoration: BoxDecoration(
          color: Colorz.WhiteAir,
          borderRadius: _borderRadius.evaluate(_easeInAnimation), //Borderers.superBorderAll(context, Ratioz.ddAppBarCorner - 5),
        ),
        margin: EdgeInsets.all(5),
        child: new ListView(
          itemExtent: _buttonExtent,
          children: <Widget>[

            ...List.generate(widget.keywords.length, (index){

              bool _isSelected = widget.subTitle == widget.keywords[index];

              return
                DreamBox(
                  height: _buttonHeight,
                  color: _isSelected ? Colorz.Yellow : Colorz.Nothing,
                  verse: widget.keywords[index],
                  verseColor: _isSelected ? Colorz.BlackBlack : Colorz.White,
                  verseWeight: _isSelected ? VerseWeight.bold : VerseWeight.thin,
                  verseItalic: false,
                  verseScaleFactor: 2,
                  icon: _isSelected ? Iconz.XLarge : null,
                  iconSizeFactor: 0.3,
                  iconColor: Colorz.BlackBlack,
                  boxMargins: EdgeInsets.symmetric(horizontal: 50, vertical: _buttonVerticalPadding),
                  boxFunction: (){

                    if (_isSelected){
                      widget.onKeywordTap(null);
                    } else {
                      widget.onKeywordTap(widget.keywords[index]);

                    }

                    // _expansionTileKey.currentState.collapse();
                  },
                );
            }
            ),

          ],
        ),
      ),

    );

  }
}