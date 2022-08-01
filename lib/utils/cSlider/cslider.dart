// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget cSlider(double height, List<Widget> widgets) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: CarouselSlider(
      options: CarouselOptions(
        height: height,
        aspectRatio: 16/9,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
      ),
      items: widgets
    ),
  );
  
}