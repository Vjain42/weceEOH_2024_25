import 'package:flutter/material.dart';
import 'theme.dart';

class RobotControlButton extends StatefulWidget {
  final Function onPressStart; // Callback for when the button is pressed
  final Function onPressEnd;   // Callback for when the button is released

  const RobotControlButton({
    Key? key,
    required this.onPressStart,
    required this.onPressEnd,
  }) : super(key: key);

  @override
  _RobotControlButtonState createState() => _RobotControlButtonState();
}

class _RobotControlButtonState extends State<RobotControlButton> {
  bool _isPressed = false; // Track button press state for feedback

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true); // Update visual feedback
        widget.onPressStart(); // Trigger the start action
      },
      onTapUp: (_) {
        setState(() => _isPressed = false); // Remove visual feedback
        widget.onPressEnd(); // Trigger the end action
      },
      onTapCancel: () {
        setState(() => _isPressed = false); // Remove visual feedback
        widget.onPressEnd(); // Trigger the end action if canceled
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100), // Smooth feedback transition
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.darkishPink : AppColors.pink, // Darker shade when pressed
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? [] // No shadow when pressed
              : [
                  BoxShadow(
                    color: AppColors.darkPink,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Move Forward',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
