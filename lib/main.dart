// Flutter 平台通道
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  final result = await MethodChannel('com.example/native').invokeMethod('getNativeData');
  print(result);
}
