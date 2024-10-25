import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'ai_bot_publish_view.dart';

class AiBotDetailView extends StatefulWidget {
  const AiBotDetailView({super.key});

  @override
  State<AiBotDetailView> createState() => _AiBotDetailViewState();
}

class _AiBotDetailViewState extends State<AiBotDetailView> {
  String? selectedBot;
  String? selectedPrompt;
  String? selectedKnowledge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'AI Bot Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryBackground,
        actions: [
          WideButton(
            width: 150,
            text: 'Publish',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AiBotPublishView(),
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/empty_image.png',
                      width: 200,
                    ),
                    const Gap(32),
                    TextInput(
                      label: 'Name',
                      hintText: 'Enter name',
                      onChanged: (value) {},
                    ),
                    const Gap(32),
                    TextInput(
                      label: 'Description',
                      hintText: 'Enter description',
                      onChanged: (value) {},
                    ),
                    const Gap(32),
                    CustomDropdownButton(
                      dropdownWidth: availableWidth,
                      hint: 'Choose your model',
                      value: selectedBot,
                      dropdownItems: FakeData.aiBots,
                      onChanged: (value) => setState(() {
                        selectedBot = value;
                      }),
                    ),
                    const Gap(32),
                    CustomDropdownButton(
                      dropdownWidth: availableWidth,
                      hint: 'Choose your prompt',
                      value: selectedPrompt,
                      dropdownItems: FakeData.prompts,
                      onChanged: (value) => setState(() {
                        selectedPrompt = value;
                      }),
                    ),
                    const Gap(32),
                    CustomDropdownButton(
                      dropdownWidth: availableWidth,
                      hint: 'Choose your knowledge',
                      value: selectedKnowledge,
                      dropdownItems: FakeData.knowledges,
                      onChanged: (value) => setState(() {
                        selectedKnowledge = value;
                      }),
                    ),
                    const Gap(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WideButton(
                          width: 150,
                          text: 'DELETE',
                          onPressed: () {},
                        ),
                        const Gap(56),
                        WideButton(
                          width: 150,
                          text: 'UPDATE',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
