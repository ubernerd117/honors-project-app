import 'package:flutter/material.dart';

class ExpandableTextButton extends StatefulWidget {
  final String buttonText; // The text for the button
  final String expandedText; // The text for the expanded content
  final Color? buttonTextColor; // Optional color for the button text
  final Color? containerColor; // Optional color for the expanded container

  const ExpandableTextButton({
    Key? key,
    required this.buttonText,
    required this.expandedText,
    this.buttonTextColor, // Optional parameter for button text color
    this.containerColor, // Optional parameter for container background color
  }) : super(key: key);

  @override
  _ExpandableTextButtonState createState() => _ExpandableTextButtonState();
}

class _ExpandableTextButtonState extends State<ExpandableTextButton> {
  bool isExpanded = false; // Track whether the text is expanded or not

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The TextButton that toggles the expanded content
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              widget.containerColor ??
                  Theme.of(context)
                      .primaryColor, // Use MaterialStateProperty.all for the background color
            ),
          ),
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded; // Toggle expansion
            });
          },
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color:
                  Colors.white, // Use passed color or default to primary color
            ),
          ),
        ),
        // The Container with the expanded text
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color:
                  Colors.grey[200], // Use passed color or default to grey[200]
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Text(
              widget.expandedText,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
      ],
    );
  }
}
