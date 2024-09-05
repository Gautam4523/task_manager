import 'package:flutter/material.dart';

final kTittle = TextStyle(color: Colors.white);
final kSubTittle = TextStyle(color: Colors.teal.shade900);
final kAddTasktittle =
    TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold);

final kAdd =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
final kAddTaskDecoration = BoxDecoration(
  color: Colors.teal,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  ),
);

final kAddTextFieldDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 2.0,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
);
