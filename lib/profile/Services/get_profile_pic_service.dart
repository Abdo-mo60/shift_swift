import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // Make sure this import is here

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/pic_model.dart';

class ProfilePicService {
  Future<PicModel> getProfilePic() async {
      Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      http.Response response = await http.get(
        Uri.parse('$accountBaseUrl/GetProfilePicture/$currentId'),
        headers: headers
      );
      print("picture response${response.body}");
      return PicModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      
      throw ('Picture Error${e.toString()}');
    }
  }
  
Future<void> uploadProfilePicture({required File imageFile}) async {
  final uri = Uri.parse('$accountBaseUrl/AddOrUpdateProfilePicture');

  // Create the request
  var request = http.MultipartRequest('POST', uri);

  // Add headers
  request.headers['Authorization'] = 'Bearer $token'; // Ensure you pass the correct token
  
  // Optional: Add other required form fields if needed (e.g., 'setting')
  request.fields['setting'] = 'name=value'; // Adjust key as needed
print("File path: ${imageFile.path}");

  // Add the file - ensure the field name matches what the server expects
  request.files.add(await http.MultipartFile.fromPath(
    'FormFile', // Update to correct field name
    imageFile.path,
    contentType: MediaType('image', 'png'), // Adjust MIME type as needed
  ));

  try {
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Upload success: $responseBody");
    } else {
      print("Upload failed with status ${response.statusCode}: $responseBody");
    }
  } catch (e) {
    print('Exception during upload: $e');
  }
}

}
