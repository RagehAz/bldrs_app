import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

enum ProgressState {
  error,
  good,
  waiting,
  nothing,
}

class ProgressModel {
  // -----------------------------------------------------------------------------
  const ProgressModel({
    @required this.state,
    @required this.title,
    this.args,
  });
  // --------------------
  final ProgressState state;
  final String title;
  final Map<String, dynamic> args;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ProgressModel copyWith({
    ProgressState state,
    String title,
    Map<String, dynamic> args,
  }){
    return ProgressModel(
      state: state ?? this.state,
      title: title ?? this.title,
      args: args ?? this.args,
    );
  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------

  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color getProgressColor(ProgressState state){
    switch (state){
      case ProgressState.error: return Colorz.red255; break;
      case ProgressState.good: return Colorz.green255; break;
      case ProgressState.waiting: return Colorz.yellow125; break;
      case ProgressState.nothing: return Colorz.white10; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getProgressIcon(ProgressState state){
    switch (state){
      case ProgressState.error: return Iconz.xSmall; break;
      case ProgressState.good: return Iconz.check; break;
      case ProgressState.waiting: return Iconz.reload; break;
      case ProgressState.nothing: return Iconz.more; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getProgressString(ProgressState state){
    switch (state){
      case ProgressState.waiting: return 'Waiting';  break;
      case ProgressState.error:   return 'Error';  break;
      case ProgressState.nothing: return 'Non';  break;
      case ProgressState.good:    return 'Good';  break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

}
