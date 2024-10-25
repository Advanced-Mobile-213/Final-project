import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:chatbot_agents/constants/constants.dart';

class AiBotCreateView extends StatefulWidget {
  const AiBotCreateView({super.key});

  @override
  State<AiBotCreateView> createState() => _AiBotCreateViewState();
}

class _AiBotCreateViewState extends State<AiBotCreateView> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Create AI Bot',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryBackground,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              return Column(
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
                  const Gap(16),
                  TextInput(
                    label: 'Description',
                    hintText: 'Enter description',
                    onChanged: (value) {},
                  ),
                  const Gap(16),
                  CustomDropdownButton(
                    dropdownWidth: availableWidth,
                    hint: 'Choose your model',
                    value: selectedItem,
                    dropdownItems: FakeData.aiBots,
                    onChanged: (value) => setState(() {
                      selectedItem = value;
                    }),
                  ),
                  const Gap(32),
                  WideButton(
                    text: 'CONFIRM',
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
