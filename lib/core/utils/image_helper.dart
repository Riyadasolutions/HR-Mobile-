import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

class ImageHelper {
  static Future<double> getImageHeight({
    required String imagePath,
    required double imgWidth,
  }) {
    final ImageProvider<Object> provider = imagePath.startsWith('http')
        ? NetworkImage(imagePath) as ImageProvider<Object>
        : FileImage(
      File(
        imagePath.startsWith('file://') ? imagePath.substring(7) : imagePath,
      ),
    ) as ImageProvider<Object>;

    final Completer<ui.Image> completer = Completer<ui.Image>();

    final stream = provider.resolve(const ImageConfiguration());
    final listener = ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image),
      onError: (error, stackTrace) => completer.completeError(error ?? 'Image load error'),
    );

    stream.addListener(listener);

    return completer.future.then((image) {
      stream.removeListener(listener);
      return (imgWidth * image.height) / image.width;
    }).catchError((error) {
      stream.removeListener(listener);
      throw error;
    });
  }
}
