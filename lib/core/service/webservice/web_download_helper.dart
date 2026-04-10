import 'package:flutter/foundation.dart';

// Conditional import for web
import 'web_download_stub.dart'
    if (dart.library.html) 'web_download_web.dart'
    as download_impl;

class WebDownloadHelper {
  static void downloadFile(Uint8List bytes, String fileName) {
    download_impl.downloadFile(bytes, fileName);
  }
}
