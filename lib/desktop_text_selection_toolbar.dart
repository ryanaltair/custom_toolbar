import 'package:flutter/material.dart';

const double _kToolbarScreenPadding = 8.0;
const double _kToolbarWidth = 222.0;
class DesktopTextSelectionToolbar extends StatelessWidget {
  /// Creates an instance of _DesktopTextSelectionToolbar.
  const DesktopTextSelectionToolbar({super.key, 
    required this.anchor,
    required this.children,
  }) : assert(children.length > 0);

  /// The point at which the toolbar will attempt to position itself as closely
  /// as possible.
  final Offset anchor;

  /// {@macro flutter.material.TextSelectionToolbar.children}
  ///
  /// See also:
  ///   * [DesktopTextSelectionToolbarButton], which builds a default
  ///     Material-style desktop text selection toolbar text button.
  final List<Widget> children;

  // Builds a desktop toolbar in the Material style.
  static Widget _defaultToolbarBuilder(BuildContext context, Widget child) {
    return SizedBox(
      width: _kToolbarWidth,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 1.0,
        type: MaterialType.card,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double paddingAbove = mediaQuery.padding.top + _kToolbarScreenPadding;
    final Offset localAdjustment = Offset(_kToolbarScreenPadding, paddingAbove);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _kToolbarScreenPadding,
        paddingAbove,
        _kToolbarScreenPadding,
        _kToolbarScreenPadding,
      ),
      child: CustomSingleChildLayout(
        delegate: DesktopTextSelectionToolbarLayoutDelegate(
          anchor: anchor - localAdjustment,
        ),
        child: _defaultToolbarBuilder(context, Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        )),
      ),
    );
  }
}
