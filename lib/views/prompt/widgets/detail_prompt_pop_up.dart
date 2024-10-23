import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPromptPopUpDialog extends StatelessWidget{
  final int index;

  DetailPromptPopUpDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Detail Prompt'),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],

            ),
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
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text('Name:'),
                ),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter Prompt Name',
                    contentPadding: const EdgeInsets.all(5),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) {

                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text('Prompt:'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  child: TextField(
                    maxLines: 2,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Use square brackets [] to specify user input. Learn more',
                      hintMaxLines: 3,
                      contentPadding: const EdgeInsets.all(10),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'eg: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
                    hintMaxLines: 3,
                    contentPadding: const EdgeInsets.all(10),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) {

                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon:  const Icon(Icons.chat),
          label: const Text('Using this prompt'),
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