import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class StorageApp {
  Future<BoxCollection> initStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    // await Hive.initFlutter(directory.path);
    final collection = await BoxCollection.open(
      'collectOrderApp', // Name of your database
      {'history', 'settings'}, // Names of your boxes
      path:
          '${directory.path}/data', // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    return collection;
  }

//////////
////
  ///
  ///
  ///         PUT
  ///
  ///
  ///
  putData(String currentDate, Map<String, dynamic> data) async {
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('history');
    box.put(currentDate, data);
  }

  putSettingData(Map<String, dynamic> data) async {
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('settings');
    box.put('settings', data);
  }

  getSettingDate() async {
    BoxCollection storage = await initStorage();
    CollectionBox box = await storage.openBox('settings');
    dynamic data = await box.get('settings');
    if (data == null) {
      return {"currency": "EGP", "lang": "English"};
    } else {
      return data;
    }
  }

  Future<List<String>> getallKeys() async {
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('history');
    List<String> historyItem = await box.getAllKeys();
    return historyItem;
  }

  Future<List> getAllDatesTitles() async {
    List datesTitlesList = [];
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('history');
    List<String> historyItem = await box.getAllKeys();
    for (var item in historyItem) {
      dynamic historyItem = await box.get(item);
      var jsonData = json.decode(historyItem['data']);
      Map data = {
        "key": item,
        "date": jsonData['createedDate'],
        "title": jsonData['title']
      };
      datesTitlesList.add(data);
    }
    return datesTitlesList;
  }

  getOneDate(String orderKey) async {
    BoxCollection storage = await initStorage();
    CollectionBox box = await storage.openBox('history');

    dynamic historyItem = await box.get(orderKey);
    return historyItem['data'];
  }

  getTotalOfHistoryOrders() async {
    List<String> allKeys = await getallKeys();
    return allKeys.length + 1;
  }

  clearDataFromStorage(String key) async {
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('history');
    await box.delete(key);
  }

  clearALLDataFromStorage() async {
    BoxCollection storage = await initStorage();
    var box = await storage.openBox('history');
    await box.clear();
  }
}
