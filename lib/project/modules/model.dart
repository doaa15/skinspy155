import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TfliteModelManager {
  static final TfliteModelManager _singleton = TfliteModelManager._internal();
  String? _modelPath;
  bool _isModelLoaded = false;

  factory TfliteModelManager() {
    return _singleton;
  }

  TfliteModelManager._internal();

  Future<void> loadModel() async {
    if (_isModelLoaded) return;

    try {
      final model = await FirebaseModelDownloader.instance.getModel(
        "model1",
        FirebaseModelDownloadType.localModelUpdateInBackground,
        FirebaseModelDownloadConditions(
          iosAllowsCellularAccess: true,
          iosAllowsBackgroundDownloading: false,
          androidChargingRequired: false,
          androidWifiRequired: false,
          androidDeviceIdleRequired: false,
        ),
      );

      final labelsPath = await _saveLabelsToFile();

      await Tflite.loadModel(
        model: model.file.path,
        labels: labelsPath,
        numThreads: 1,
        isAsset: false,
        useGpuDelegate: false,
      );

      _modelPath = model.file.path;
      _isModelLoaded = true;
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> unloadModel() async {
    if (!_isModelLoaded) return;

    try {
      await Tflite.close();
      _isModelLoaded = false;
    } catch (e) {
      print("Error unloading model: $e");
    }
  }

  Future<String> _saveLabelsToFile() async {
    String labelsContent =
        await rootBundle.loadString('assets/images/labels.txt');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/labels.txt';
    File labelsFile = File(filePath);
    await labelsFile.writeAsString(labelsContent);
    return filePath;
  }
}
