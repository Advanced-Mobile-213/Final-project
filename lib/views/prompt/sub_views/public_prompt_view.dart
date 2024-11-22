import 'package:chatbot_agents/views/prompt/widgets/add_prompt_pop_up.dart';
import 'package:chatbot_agents/views/prompt/widgets/confirm_delete_prompt_pop_up.dart';
import 'package:chatbot_agents/views/prompt/widgets/detail_prompt_pop_up.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/constants.dart';

class PublicPromptView extends StatefulWidget {
  const PublicPromptView({super.key});

  @override
  State<PublicPromptView> createState() => _PublicPromptViewState();
}

class _PublicPromptViewState extends State<PublicPromptView> {
  PromptCategory selectedCategory = PromptCategory.business;
  String query = '';

  void _showConfirmDeletePromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDeletePromptPopUpDialog(index: index);
        });
  }

  void _showAddPromptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddPromptPopUpDialog();
        });
  }

  void _showDetailPromptDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailPromptPopUpDialog(index: index);
        });
  }

  void onSearchChanged(String value) {
    setState(() {
      query = value;
    });
  }

  void onCategorySelected(PromptCategory category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: const EdgeInsets.symmetric(
    //       horizontal: 10.0,
    //       vertical: 10.0
    //   ),
    //   child:
    //     ListView.builder(
    //       physics: const BouncingScrollPhysics(),
    //       itemCount: 15,
    //       itemBuilder: (context, index){
    //         return Container(
    //           margin: const EdgeInsets.symmetric(
    //               horizontal: 10.0,
    //               vertical: 10.0
    //           ),
    //           padding: const EdgeInsets.all(2.0),
    //           decoration: BoxDecoration(
    //             color: AppColors.secondaryBackground,
    //             borderRadius: BorderRadius.circular(10.0),
    //             border: Border.all(
    //               color: AppColors.quaternaryBackground,
    //               width: 1.0,
    //             ),
    //           ),
    //           child: ListTile(
    //             onTap: () => _showDetailPromptDialog(context, index),
    //             title: Text(
    //               'Prompt ${index + 1}',
    //               style: const TextStyle(
    //                 color: AppColors.quaternaryText,
    //                 fontSize: 20.0,
    //               ),
    //             ),
    //             subtitle: Text(
    //               'This is a prompt',
    //               style: const TextStyle(
    //                 color: AppColors.quaternaryText,
    //                 fontSize: 15.0,
    //               ),
    //             ),
    //             trailing: Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 IconButton(
    //                   onPressed: (){},
    //                   icon: const Icon(
    //                     Icons.star,
    //                     color: AppColors.quaternaryText,
    //                   ),
    //                 ),
    //                 IconButton(
    //                   onPressed: (){
    //                     _showDetailPromptDialog(context, index);
    //                   },
    //                   icon: const Icon(
    //                     Icons.info,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),

    //           )
    //         );

    //       },
    //     ),
    //   );
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: PromptCategorySelector(
                  category: selectedCategory,
                  onChanged: onCategorySelected,
                  hasAllCategory: true,
                ),
              ),
              Expanded(
                flex: 3,
                child: SearchInput(
                  hintText: 'Keyword',
                  onChanged: onSearchChanged,
                ),
              ),
            ],
          ),
          Gap(spacing[3]),
          PromptList(
            category: selectedCategory,
            query: query,
          ),
        ],
      ),
    );
  }
}
