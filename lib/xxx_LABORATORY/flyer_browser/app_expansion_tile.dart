import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    Key key,
    this.leading,
    @required this.title,
    this.subTitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.trailing,
    this.initiallyExpanded: false,
  })
      : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;
  final String title;
  final String subTitle;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Color backgroundColor;
  final Widget trailing;
  final bool initiallyExpanded;

  @override
  AppExpansionTileState createState() => new AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  static const Duration _kExpand = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _headerColor = new ColorTween();
    _iconColor = new ColorTween();
    _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _backgroundColor = new ColorTween();

    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded)
      _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

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

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
    final Color titleColor = _headerColor.evaluate(_easeInAnimation);

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        IconTheme.merge(
          data: new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
          child: new ListTile(
            onTap: toggle,
            leading: widget.leading,
            title: SuperVerse(
              verse: widget.title,
              color: _isExpanded ? Colorz.BlackBlack : Colorz.White,
              centered: false,
            ),
            subtitle: widget.subTitle == null ? null : SuperVerse(
              verse: widget.subTitle,
              color: _isExpanded ? Colorz.BlackLingerie : Colorz.WhiteLingerie,
              weight: VerseWeight.thin,
              italic: true,
              size: 2,
              centered: false,
            ),
            trailing: widget.trailing ?? new RotationTransition(
              turns: _iconTurns,
              child: const Icon(Icons.expand_more),
            ),
          ),
        ),

        new ClipRect(
          child: new Align(
            heightFactor: _easeInAnimation.value,
            child: child,
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = Colorz.Green;
    _headerColor
      ..begin = Colorz.White
      ..end = Colorz.DarkBlue;
    _iconColor
      ..begin = Colorz.Facebook
      ..end = Colorz.GoogleRed;
    _backgroundColor.end = Colorz.YellowGlass;

    final bool closed = !_isExpanded && _controller.isDismissed;

    return Container(
      width: 200,
      child: new AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed ? null
            :
        new Column(
            children: widget.children,
        ),

      ),
    );

  }
}