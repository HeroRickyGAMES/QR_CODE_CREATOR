import 'dart:typed_data';

import 'package:image_downloader_web/image_downloader_web.dart';

Future<void> downloadImage(Uint8List bytes, String name) {
  return WebImageDownloader.downloadImageFromUInt8List(
    uInt8List: bytes,
    name: name,
  );
}
