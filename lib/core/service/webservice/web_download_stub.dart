import 'dart:typed_data';

// Stub implementation for non-web platforms
void downloadFile(Uint8List bytes, String fileName) {
  // This should never be called on non-web platforms
  throw UnsupportedError('Web download is only supported on web platform');
}
