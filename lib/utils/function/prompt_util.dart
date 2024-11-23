

import 'package:flutter/material.dart';

import '../../models/prompt.dart';
import '../string_utils.dart';

class PromptUtil {
  get context => null;

   static void showDynamicInput(BuildContext context, Prompt prompt, TextEditingController _controller) {
    //print(prompt.content);
    List<String> placeholders = StringUtils.getAllPlacehoders(prompt.content);
    List<TextEditingController> controllers =
    placeholders.map((_) => TextEditingController()).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prompt.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      ...placeholders.asMap().entries.map((entry) {
                        int index = entry.key;
                        String placeholder = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              labelText: placeholder,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 16),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            List<String> inputValues = controllers
                                .map((controller) => controller.text)
                                .toList();
                            // Handle the collected input values here
                            String result = StringUtils.replacePlaceholders(
                                prompt.content, inputValues);
                            // Handle the result here
                            //print(result);
                            _controller.text = result;
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                          },
                          child: const Text('Send'),
                        ),
                      )
                      // Add other dynamic input fields here if needed
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}