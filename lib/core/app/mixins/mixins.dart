import 'package:flutter/material.dart';

class AppMixin { 
  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  } 
}