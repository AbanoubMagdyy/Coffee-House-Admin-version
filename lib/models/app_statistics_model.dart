import 'package:flutter/material.dart';

class AppStatisticsModel {
  String title;
  IconData icon;
  int value;
  double percentageValue;

  AppStatisticsModel(
      {
        required this.title,
        required this.icon,
        required this.value,
        required this.percentageValue,
      });
}
