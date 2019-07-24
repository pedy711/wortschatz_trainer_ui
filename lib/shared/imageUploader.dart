import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:path/path.dart';


class ImageUploader{
  static final ImageUploader _imageUploader = ImageUploader._internal();
  File _image;

  ImageUploader._internal();

  factory ImageUploader() {
    return _imageUploader;
  }

  Future upload(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    var uri = Uri.parse(Constants.IMAGE_UPLOAD);

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if(response.statusCode == 200) {
      print("Image uploaded");
    } else {
      print("Upload Failed");
    }

  }
}