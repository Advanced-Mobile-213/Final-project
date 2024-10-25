import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class FavoritesPromptView extends StatefulWidget {
  const FavoritesPromptView({Key? key}) : super(key: key);

  @override
  State<FavoritesPromptView> createState() => _FavoritesPromptViewState();
}

class _FavoritesPromptViewState extends State<FavoritesPromptView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0
      ),
      child:  ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0
              ),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.quaternaryBackground,
                  width: 1.0,
                ),
              ),
              child: ListTile(
                title: Text(
                  'Prompt ${index + 1}',
                  style: const TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  'This is a prompt',
                  style: const TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        //_showConfirmDeletePromptDialog(context, index);
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
          
              )
            );
            
          },
        ),
      );

  }
}