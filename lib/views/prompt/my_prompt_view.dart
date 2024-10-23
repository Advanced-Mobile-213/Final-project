import 'package:chatbot_agents/views/prompt/widgets/detail_prompt_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyPromptView extends StatelessWidget {
  MyPromptView({Key? key}) : super(key: key);

  void _showAddPromptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailPromptPopUpDialog(index: 1,);
        }
    );
  }

  void _showConfirmDeletePromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailPromptPopUpDialog(index: 1,);
        }
    );
  }

  void _showDetailPromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailPromptPopUpDialog(index: index);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Prompt Library',
            style: const TextStyle(
                color: Colors.white
            )
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showAddPromptDialog(context);
              },
              icon: Icon(
                Icons.add_circle,
                color: Colors.white,
              )
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0
                ),
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Prompt 1',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Description 1',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Prompt 2',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Description 2',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Prompt 3',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Description 3',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Prompt 4',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Description 4',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Prompt 5',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Description 5',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 5.0
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.grey,
                            hintText: 'Search prompt here ...',
                            contentPadding: const EdgeInsets.only(top: 2),
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),

                            ),
                          ),
                          onSubmitted: (searchTerm){

                          },
                        )
                    )

                ),
              ],
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0
                  ),
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index){
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Prompt ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        _showConfirmDeletePromptDialog(context, index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        _showDetailPromptDialog(context, index);
                                      },
                                      icon: Icon(
                                        Icons.info,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    );

  }

}

