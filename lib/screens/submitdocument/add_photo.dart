import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AddPhotoWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool isImage;

  final String? url;
  final File? filePath;
  final bool isUploading;
  final double? progress;
  final IconData? icon;
  final VoidCallback? onTapCancel;

  const AddPhotoWidget({
    required this.onTap,
    required this.isImage,
    this.url,
    this.filePath,
    required this.isUploading,
    this.progress,
    this.icon,
    this.onTapCancel,
  });

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? thumb;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(alignment: Alignment.topCenter, child: Text('data')),
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 60,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(1, 1), // ch
                ),
              ],
            ),
            child: widget.filePath != null
                ? Image.file(
                    widget.filePath!,
                    fit: BoxFit.cover,
                  )
                : !widget.isImage
                    ? !widget.isUploading
                        ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: const Text(
                                    'upload',
                                    style: TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.w200),
                                  ),
                                ),
                                Icon(
                                  widget.icon ??
                                      Icons.add_photo_alternate_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ],
                            ),
                        )
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 3.0,
                                  percent: widget.progress!,
                                  progressColor: AppColors.app_color,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: widget.onTapCancel ?? () {},
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                    : Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: CachedNetworkImage(
                                  imageUrl: widget.url!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: widget.onTap,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
        widget.filePath != null
            ? Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: InkWell(
                    onTap: widget.onTapCancel,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
