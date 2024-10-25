import 'package:flutter/material.dart';
import 'package:chatbot_agents/constants/constants.dart';

class PublishCard extends StatelessWidget {
  const PublishCard({super.key, required this.name, required this.status});

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        side: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      color: AppColors.cardBackground,
      child: SizedBox(
        width: 300,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Configure',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
