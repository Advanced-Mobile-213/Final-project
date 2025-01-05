import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/constants/spacing.dart';
import 'package:chatbot_agents/views/prompt/widgets/prompt_list.dart';
import 'package:chatbot_agents/widgets/search_input.dart';
import '../../../constants/prompt_category.dart';
import '../widgets/category_filter.dart';

class PublicPromptView extends StatefulWidget {
  const PublicPromptView({super.key});

  @override
  State<PublicPromptView> createState() => _PublicPromptViewState();
}

class _PublicPromptViewState extends State<PublicPromptView> {
  PromptCategory selectedCategory = PromptCategory.business;
  String query = '';

  // void _showConfirmDeletePromptDialog(BuildContext context, int index) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return ConfirmDeletePromptPopUpDialog(index: index);
  //       });
  // }

  // void _showAddPromptDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AddPromptPopUpDialog();
  //       });
  // }

  // void _showDetailPromptDialog(BuildContext context, int index) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return DetailPromptPopUpDialog(index: index);
  //       });
  // }

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
          SearchInput(
            hintText: 'Keyword',
            onChanged: onSearchChanged,
          ),
          Gap(spacing[3]),
          CategoryFilter(
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
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
