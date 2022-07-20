class CupertinoOptions {

  const CupertinoOptions({
    this.backgroundColor,
    this.doneButtonTitle,
    this.selectionFillColor,
    this.selectionShadowColor,
    this.selectionStrokeColor,
    this.selectionTextColor,
    this.selectionCharacter,
    this.takePhotoIcon,
    this.autoCloseOnSelectionLimit,
  });
  final String backgroundColor;
  final String doneButtonTitle;
  final String selectionShadowColor;
  final String selectionStrokeColor;
  final String selectionFillColor;
  final String selectionTextColor;
  final String selectionCharacter;
  final String takePhotoIcon;
  final bool autoCloseOnSelectionLimit;

  Map<String, String> toJson() {
    return {
      'backgroundColor': backgroundColor ?? '',
      'doneButtonTitle': doneButtonTitle ?? '',
      'selectionFillColor': selectionFillColor ?? '',
      'selectionShadowColor': selectionShadowColor ?? '',
      'selectionStrokeColor': selectionStrokeColor ?? '',
      'selectionTextColor': selectionTextColor ?? '',
      'selectionCharacter': selectionCharacter ?? '',
      'takePhotoIcon': takePhotoIcon ?? '',
      'autoCloseOnSelectionLimit':
      autoCloseOnSelectionLimit == true ? 'true' : 'false'
    };
  }
}

class MaterialOptions {

  const MaterialOptions({
    this.actionBarColor,
    this.actionBarTitle,
    this.lightStatusBar,
    this.statusBarColor,
    this.actionBarTitleColor,
    this.allViewTitle,
    this.startInAllView,
    this.useDetailsView,
    this.selectCircleStrokeColor,
    this.selectionLimitReachedText,
    this.textOnNothingSelected,
    this.backButtonDrawable,
    this.okButtonDrawable,
    this.autoCloseOnSelectionLimit,
  });
  final String actionBarColor;
  final String statusBarColor;
  final bool lightStatusBar;
  final String actionBarTitleColor;
  final String allViewTitle;
  final String actionBarTitle;
  final bool startInAllView;
  final bool useDetailsView;
  final String selectCircleStrokeColor;
  final String selectionLimitReachedText;
  final String textOnNothingSelected;
  final String backButtonDrawable;
  final String okButtonDrawable;
  final bool autoCloseOnSelectionLimit;

  Map<String, String> toJson() {
    return {
      'actionBarColor': actionBarColor ?? '',
      'actionBarTitle': actionBarTitle ?? '',
      'actionBarTitleColor': actionBarTitleColor ?? '',
      'allViewTitle': allViewTitle ?? '',
      'lightStatusBar': lightStatusBar == true ? 'true' : 'false',
      'statusBarColor': statusBarColor ?? '',
      'startInAllView': startInAllView == true ? 'true' : 'false',
      'useDetailsView': useDetailsView == true ? 'true' : 'false',
      'selectCircleStrokeColor': selectCircleStrokeColor ?? '',
      'selectionLimitReachedText': selectionLimitReachedText ?? '',
      'textOnNothingSelected': textOnNothingSelected ?? '',
      'backButtonDrawable': backButtonDrawable ?? '',
      'okButtonDrawable': okButtonDrawable ?? '',
      'autoCloseOnSelectionLimit':
      autoCloseOnSelectionLimit == true ? 'true' : 'false'
    };
  }
}
