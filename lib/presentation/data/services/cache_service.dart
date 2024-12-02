import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<void> cacheDataWithExpiration(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final expirationTime = DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch;
    
    final cacheData = {
      'data': data,
      'expirationTime': expirationTime,
    };

    prefs.setString(key, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getCachedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      final decodedData = json.decode(cachedData);
      final expirationTime = decodedData['expirationTime'];

      
      if (expirationTime != null && expirationTime < DateTime.now().millisecondsSinceEpoch) {
        print('Cache expired');
        await prefs.remove(key); 
        return null;
      }

      return decodedData['data'];
    }

    return null;  
  }
}
