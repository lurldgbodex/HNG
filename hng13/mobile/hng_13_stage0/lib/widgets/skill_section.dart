import 'package:flutter/material.dart';
import 'package:hng_13_stage0/widgets/skill_item.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = {
      'Java/SpringBoot': 90,
      'Git & GitHub': 90,
      'REST APIs': 90,
      'Problem Solving': 90,
      'Javascript/React': 75,
      'Flutter/Dart': 70,
      'Devops': 70,
      'Cloud Computing': 70,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Expertise',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Here are some of my technical skills and proficiency levels',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          ...skills.entries.map((skill) {
            return SkillItem(skillName: skill.key, percentage: skill.value);
          }),
        ],
      ),
    );
  }
}
