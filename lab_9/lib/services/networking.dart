import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<Map<String, dynamic>?> getData() async {
    try {
      final response = await http.get(Uri.parse(url));

      // Kiểm tra mã trạng thái của response
      if (response.statusCode == 200) {
        // Parse JSON thành Map và trả về
        return jsonDecode(response.body);
      } else {
        // In thông báo lỗi nếu mã trạng thái không phải là 200
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Xử lý lỗi nếu có lỗi xảy ra trong quá trình gửi request
      print('Error occurred: $e');
      return null;
    }
  }
}
