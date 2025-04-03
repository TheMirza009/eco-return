import 'package:flutter/material.dart';
import 'package:eco_return/core/theme/theme_constants.dart';

class OTPField extends StatefulWidget {
  final List<TextEditingController> controllers;
  final ValueNotifier<bool> isCompleteNotifier;

  const OTPField({
    super.key,
    required this.controllers,
    required this.isCompleteNotifier,
  });

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(4, (_) => FocusNode());
    // Request focus for the first field when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () => focusNodes[0].requestFocus());
    });
  }

  @override
  void dispose() {
    // Dispose all focus nodes
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 70,
              child: Center(
                child: TextField(
                  controller: widget.controllers[index],
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  textInputAction: index < 3
                      ? TextInputAction.next
                      : TextInputAction.done,
                  style: const TextStyle(fontSize: 40),
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                        color: widget.controllers[index].text.isNotEmpty
                            ? ThemeConstants.ecoGreen
                            : const Color.fromARGB(255, 230, 230, 230),
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(
                        color: ThemeConstants.ecoGreen,
                        width: 3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                   onChanged: (value) {
                    // Ensure existing logic is preserved
                    widget.controllers.every((controller) =>
                            controller.text.isNotEmpty)
                        ? FocusScope.of(context).unfocus()
                        : null;

                    if (value.isNotEmpty) {
                      // Move to the next field if available
                      if (index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    } else if (value.isEmpty) {
                      // Reset the current field
                      widget.controllers[index].clear();

                      // Move to the previous field if available
                      if (index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    }

                    // Update the ValueNotifier for completeness
                    widget.isCompleteNotifier.value = widget.controllers
                        .every((controller) => controller.text.isNotEmpty);
                  },
                  onSubmitted: (_) {
                    // Trigger complete status update on submit
                    widget.isCompleteNotifier.value = widget.controllers
                        .every((controller) => controller.text.isNotEmpty);
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
