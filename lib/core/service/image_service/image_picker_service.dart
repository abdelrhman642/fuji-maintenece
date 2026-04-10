import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_color.dart';

abstract class ImagePickerService {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  Future<File?> cropImage(File imageFile);
  Future<List<File>?> pickMultipleImages();
}

class ImagePickerServiceImpl implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      return null;
    }
  }

  @override
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
      return null;
    }
  }

  @override
  Future<File?> cropImage(File imageFile) async {
    try {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image'.tr,
            toolbarColor: AppColor.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            statusBarColor: AppColor.primaryDark,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: AppColor.primary,
          ),
          IOSUiSettings(minimumAspectRatio: 1.0, title: 'Crop Image'),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  @override
  Future<List<File>?> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        return images.map((xFile) => File(xFile.path)).toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      return null;
    }
  }

  /// Pick image with options dialog
  Future<File?> pickImageWithOptions(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final file = await pickImageFromGallery();
                  if (context.mounted && file != null) {
                    Navigator.of(context).pop(file);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final file = await pickImageFromCamera();
                  if (context.mounted && file != null) {
                    Navigator.of(context).pop(file);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Pick and crop image in one operation
  Future<File?> pickAndCropImage({ImageSource? source}) async {
    File? imageFile;

    if (source == ImageSource.gallery) {
      imageFile = await pickImageFromGallery();
    } else if (source == ImageSource.camera) {
      imageFile = await pickImageFromCamera();
    } else {
      // Let user choose
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        imageFile = File(image.path);
      }
    }

    if (imageFile != null) {
      return await cropImage(imageFile);
    }

    return null;
  }

  /// Validate image file size and format
  bool validateImage(File imageFile, {int maxSizeMB = 5}) {
    // Check file size
    final fileSizeInBytes = imageFile.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    if (fileSizeInMB > maxSizeMB) {
      debugPrint('Image file size exceeds $maxSizeMB MB');
      return false;
    }

    // Check file extension
    final fileName = imageFile.path.toLowerCase();
    final validExtensions = ['.jpg', '.jpeg', '.png', '.webp'];

    bool hasValidExtension = false;
    for (final extension in validExtensions) {
      if (fileName.endsWith(extension)) {
        hasValidExtension = true;
        break;
      }
    }

    if (!hasValidExtension) {
      debugPrint('Invalid image file format');
      return false;
    }

    return true;
  }
}
