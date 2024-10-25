import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/widgets/widget.dart';
import 'package:gap/gap.dart';

class AiBotPublishView extends StatefulWidget {
  const AiBotPublishView({super.key});

  @override
  State<AiBotPublishView> createState() => _AiBotPublishViewState();
}

class _AiBotPublishViewState extends State<AiBotPublishView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Publish',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryBackground,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            return SingleChildScrollView(
              child: SizedBox(
                width: availableWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PublishCard(name: 'Slack', status: 'Configured'),
                    const Gap(32),
                    const PublishCard(name: 'Telegram', status: 'Configured'),
                    const Gap(32),
                    const PublishCard(name: 'Messenger', status: 'Configured'),
                    const Gap(32),
                    WideButton(
                      width: 150,
                      text: 'Publish',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
