import 'package:get_storage/get_storage.dart';

void setData(String key, dynamic value) => GetStorage().write(key, value);

int? getInt(String key) => GetStorage().read(key);

String? getString(String key) => GetStorage().read(key);

bool? getBool(String key) => GetStorage().read(key);

double? getDouble(String key) => GetStorage().read(key);

dynamic getData(String key) => GetStorage().read(key);

dynamic deleteData(String key) => GetStorage().remove(key);

void clearData() async => GetStorage().erase();
