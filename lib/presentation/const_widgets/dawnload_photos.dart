import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class DownloadPhotos extends StatefulWidget {
  final List<String> imageUrls;
  final String folderName;
  final String directoryPath;

  DownloadPhotos({
    required this.imageUrls,
    required this.folderName,
    required this.directoryPath,
  });

  @override
  _DownloadPhotosState createState() => _DownloadPhotosState();
}

class _DownloadPhotosState extends State<DownloadPhotos> {
  int _totalImagesDownloaded = 0;
  int _totalImages = 0; // عدد الصور الكلي
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    _totalImages = widget.imageUrls.length; // تعيين عدد الصور الكلي
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _downloading ? null : () => _downloadImages(context),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _downloading
              ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : _totalImagesDownloaded > 0
              ? Icon(Icons.check) // عرض علامة صح عند وجود صور محملة
              : Text('تحميل الصور'),
          SizedBox(width: 8),
          _totalImagesDownloaded > 0 // عرض عدد الصور المحملة إذا كانت أكثر من صورة واحدة محملة
              ? Text('$_totalImagesDownloaded / $_totalImages')
              : Container(),
        ],
      ),
    );
  }

  void _downloadImages(BuildContext context) async {
    setState(() {
      _downloading = true;
      _totalImagesDownloaded = 0;
    });

    String folderPath = '${widget.directoryPath}/${widget.folderName}';

    // Create folder if not exists
    if (!(await Directory(folderPath).exists())) {
      await Directory(folderPath).create(recursive: true);
    }

    // Download and save missing images
    for (int i = 0; i < widget.imageUrls.length; i++) {
      String imagePath = '$folderPath/${i + 1}.jpg';
      if (!(await File(imagePath).exists())) {
        await _downloadAndSaveImage(widget.imageUrls[i], imagePath);
        setState(() {
          _totalImagesDownloaded++;
        });
      }
    }

    // Display dialog with download status
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Complete'),
          content: Text(
              '$_totalImagesDownloaded photos downloaded out of $_totalImages.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    setState(() {
      _downloading = false;
    });
  }

  Future<void> _downloadAndSaveImage(String imageUrl, String imagePath) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    await File(imagePath).writeAsBytes(bytes);
  }
}