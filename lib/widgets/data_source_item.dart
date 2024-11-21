import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/models.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:gap/gap.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

final BoxDecoration _containerDecoration = BoxDecoration(
  color: AppColors.tertiaryBackground.withOpacity(0.3),
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(
    color: Colors.white,
    width: 1.0,
  ),
);

const _nameDecoration = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const _descriptionDecoration = TextStyle(
  color: Colors.white,
  fontSize: 14,
);

class DataSourceItem extends StatelessWidget {
  final DataSource dataSource;
  final bool isSelected;
  final void Function() onTap;

  const DataSourceItem(this.dataSource, this.isSelected, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: spacing[2],
            vertical: spacing[2],
          ),
          decoration: _containerDecoration.copyWith(
            color: isSelected
                ? AppColors.tertiaryBackground
                : AppColors.secondaryBackground,
          ),
          child: Row(
            children: [
              Image.asset(dataSource.imagePath, width: 40),
              Gap(spacing[2]),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataSource.name,
                      style: _nameDecoration,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dataSource.description,
                      style: _descriptionDecoration,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
