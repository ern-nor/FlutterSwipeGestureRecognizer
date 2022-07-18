import 'package:flutter/widgets.dart';

class SwipeGestureRecognizer extends StatefulWidget {
  SwipeGestureRecognizer({
    Key? key,
    required this.child,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
  }) : super(key: key);

  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  final Function()? onSwipeUp;
  final Function()? onSwipeDown;
  final Widget child;

  @override
  _SwipeGestureRecognizerState createState() => _SwipeGestureRecognizerState();
}

class _SwipeGestureRecognizerState extends State<SwipeGestureRecognizer> {
  Offset _horizontalSwipeStartingOffset = Offset(0, 0);
  Offset _verticalSwipeStartingOffset = Offset(0, 0);

  bool _isSwipeLeft = false;
  bool _isSwipeRight = false;
  bool _isSwipeUp = false;
  bool _isSwipeDown = false;

  @override
  void initState() {
    super.initState();
    _isSwipeDown = _isSwipeUp = _isSwipeRight = _isSwipeLeft = false;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.onSwipeLeft != null || widget.onSwipeRight != null) &&
            (widget.onSwipeDown != null || widget.onSwipeUp != null)
        ? GestureDetector(
            child: widget.child,
            onHorizontalDragStart: (details) {
              _horizontalSwipeStartingOffset = details.localPosition;
            },
            onHorizontalDragUpdate: (details) {
              if (_horizontalSwipeStartingOffset.dx >
                  details.localPosition.dx) {
                _isSwipeLeft = true;
                _isSwipeRight = false;
              } else {
                _isSwipeRight = true;
                _isSwipeLeft = false;
              }
            },
            onHorizontalDragEnd: (details) {
              if (_isSwipeLeft) {
                if (widget.onSwipeLeft != null) {
                  widget.onSwipeLeft!();
                }
              } else if (_isSwipeRight) {
                if (widget.onSwipeRight != null) {
                  widget.onSwipeRight!();
                }
              }
            },
            onVerticalDragStart: (details) {
              _verticalSwipeStartingOffset = details.localPosition;
            },
            onVerticalDragUpdate: (details) {
              if (_verticalSwipeStartingOffset.dy > details.localPosition.dy) {
                _isSwipeUp = true;
                _isSwipeDown = false;
              } else {
                _isSwipeDown = true;
                _isSwipeUp = false;
              }
            },
            onVerticalDragEnd: (details) {
              if (_isSwipeUp && widget.onSwipeUp != null) {
                widget.onSwipeUp!();
              } else if (_isSwipeDown && widget.onSwipeDown != null) {
                widget.onSwipeDown!();
              }
            },
          )
        : (widget.onSwipeLeft != null || widget.onSwipeRight != null)
            ? GestureDetector(
                child: widget.child,
                onHorizontalDragStart: (details) {
                  _horizontalSwipeStartingOffset = details.localPosition;
                },
                onHorizontalDragUpdate: (details) {
                  if (_horizontalSwipeStartingOffset.dx >
                      details.localPosition.dx) {
                    _isSwipeLeft = true;
                    _isSwipeRight = false;
                  } else {
                    _isSwipeRight = true;
                    _isSwipeLeft = false;
                  }
                },
                onHorizontalDragEnd: (details) {
                  if (_isSwipeLeft && widget.onSwipeLeft != null) {
                    widget.onSwipeLeft!();
                  } else if (_isSwipeRight && widget.onSwipeRight != null) {
                    widget.onSwipeRight!();
                  }
                },
              )
            : (widget.onSwipeDown != null || widget.onSwipeUp != null)
                ? GestureDetector(
                    child: widget.child,
                    onVerticalDragStart: (details) {
                      _verticalSwipeStartingOffset = details.localPosition;
                    },
                    onVerticalDragUpdate: (details) {
                      if (_verticalSwipeStartingOffset.dy >
                          details.localPosition.dy) {
                        _isSwipeUp = true;
                        _isSwipeDown = false;
                      } else {
                        _isSwipeDown = true;
                        _isSwipeUp = false;
                      }
                    },
                    onVerticalDragEnd: (details) {
                      if (_isSwipeUp && widget.onSwipeUp != null) {
                        widget.onSwipeUp!();
                      } else if (_isSwipeDown && widget.onSwipeDown != null) {
                        widget.onSwipeDown!();
                      }
                    },
                  )
                : SizedBox.shrink();
  }
}
