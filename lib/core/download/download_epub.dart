import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadEpub {
  static DownloadEpub? _instance;

  DownloadEpub._();

  static DownloadEpub get instance {
    _instance ??= DownloadEpub._();
    return _instance!;
  }

  Function(double progress)? downloadProgress;

  Future<void> downloadEpub(String url) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await _startDownload(url);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await _fetchAndroidVersion(url);
    } else {
      PlatformException(code: '500');
    }
  }

  Future<void> _fetchAndroidVersion(String url) async {
    final String? version = await _getAndroidVersion();
    if (version != null) {
      int v = int.parse(version);
      if (v >= 13) {
        await _startDownload(url);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await _startDownload(url);
        } else {
          await Permission.storage.request();
        }
      }
    }
  }

  Future<String?> _getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    } on PlatformException {
      return null;
    }
  }

  _startDownload(String url) async {
    Dio dio = Dio();

    String path = await filePathByUrl(url);
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        url,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          debugPrint('Download --- ${(receivedBytes / totalBytes) * 100}');
          if (downloadProgress != null) {
            downloadProgress!((receivedBytes / totalBytes) * 100);
          }
        },
      ).whenComplete(() {
        return;
      });
    }
  }

  Future<bool> epubIsAlreadyDownloaded(String url) async =>
      File(await filePathByUrl(url)).existsSync();

  Future<String> filePathByUrl(String url) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String? docName = _extractEbookId(url);
    return '${appDocDir!.path}/$docName.epub';
  }

  String? _extractEbookId(String url) {
    RegExp regExp = RegExp(r'ebooks/(\d+)\.(epub|epub3)');
    Match? match = regExp.firstMatch(url);

    if (match != null && match.groupCount == 2) {
      return match.group(1);
    } else {
      return null;
    }
  }
}
