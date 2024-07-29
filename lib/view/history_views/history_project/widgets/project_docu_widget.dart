import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../constants/apptheme/app_colors.dart';
import '../../../../constants/utiltis.dart';
import '../../../../models/dokumentation_models/docmentation_dm/documentation_dm.dart';

class ShowProjectDocumentation extends StatefulWidget {
  final List<DocumentationDM>? value;
  const ShowProjectDocumentation({super.key, required this.value});

  @override
  State<ShowProjectDocumentation> createState() => _ShowProjectDocumentationState();
}

class _ShowProjectDocumentationState extends State<ShowProjectDocumentation> {
  int currentIndex = 0;
  late final List<DocumentationDM>? value;
  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(context) => (value == null || value!.isEmpty)
      ? const SizedBox.expand(
          child: Center(
            child: Text('keine Dokumentationen gefunden'),
          ),
        )
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Material(
            child: Expanded(
              child: ListView.builder(
                  itemCount: value!.length,
                  itemBuilder: (context, index) {
                    List<Image> image =
                        value![index].imagesUrl.map((e) => Image.network(e)).toList();
                    return Container(
                      margin: const EdgeInsets.all(0.2),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.kTextfieldBorder),
                      ),
                      height: image.isEmpty ? 65 : 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value![index].description ?? 'Keine Beschreibung',
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          image.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CarouselSlider.builder(
                                    itemCount: image.length,
                                    itemBuilder: (context, i, _) => image[i],
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      height: 150,
                                      enableInfiniteScroll: false,
                                      // enlargeCenterPage: true,
                                      onPageChanged: (index, _) =>
                                          setState(() => currentIndex = index),
                                    ),
                                  ),
                                ),
                          image.length > 1
                              ? Utilits.buildIndicator(
                                  selectedIndex: currentIndex,
                                  length: image.length,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
}
