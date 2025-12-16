/*
HOW TO USE HIVE STORAGE

1. Setup:
   Ensure `initHive()` is called in `main.dart` before `runApp`.

2. Save Data:
   await HiveStorage.putData('myBox', 'username', 'JohnDoe');

3. Fetch Data:
   String? username = await HiveStorage.getData('myBox', 'username');

4. Delete Data:
   await HiveStorage.deleteData('myBox', 'username');

EXMAPLE USAGE IN A WIDGET:

void _saveUser() async {
  await HiveStorage.putData('user_data', 'name', 'Alice');
}

void _loadUser() async {
  var name = await HiveStorage.getData('user_data', 'name', defaultValue: 'Guest');
  print(name);
}

*/
