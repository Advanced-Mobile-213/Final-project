import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmDeletePromptPopUpDialog extends StatelessWidget{

  final int index;

  ConfirmDeletePromptPopUpDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Delete Prompt'),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children:  <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.warning,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text('Are you sure you want to delete this prompt ${this.index}?',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            // Define the action to be performed when the button is pressed
            Navigator.of(context).pop();
          },
          child: Text('No'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue, // Text color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: TextStyle(fontSize: 16), // Text style
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Define the action to be performed when the button is pressed
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue, // Text color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
            textStyle: TextStyle(fontSize: 16), // Text style
          ),
        ),
      ],
    );
  }

}