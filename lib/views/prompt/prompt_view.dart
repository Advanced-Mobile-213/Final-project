import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class PromptView extends StatefulWidget {
  const PromptView({Key? key}) : super(key: key);

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: Text('Prompt Library',
            style: const TextStyle(
                color: AppColors.quaternaryText,
            )
        ),
        actions: [
          IconButton(
              onPressed: () {
                //_showAddPromptDialog(context);
              },
              icon: Icon(
                Icons.add_circle,
                color: AppColors.quaternaryText,
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
                    horizontal: 5.0,
                    vertical: 5.0
                ),
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'My Prompt',
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Public Prompt',
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Favorites Prompt',
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 20.0,
                          ),
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
                                        //_showConfirmDeletePromptDialog(context, index);
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
                                        //_showDetailPromptDialog(context, index);
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