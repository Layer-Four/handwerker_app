import 'package:flutter/material.dart';

InputDecoration decorationTextfield = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(),
  ),
  filled: true,
);

const baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
