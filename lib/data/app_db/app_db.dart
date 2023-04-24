// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:developer';

import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

class ObjectBox {
  static final ObjectBox instance = ObjectBox._();

  ObjectBox._();

  factory ObjectBox() => instance;
  late final Store store;

  static initialize() async {
    try {
      await getApplicationDocumentsDirectory().then((directory) async {
        String path = directory.path;
        if (Store.isOpen(path)) {
          instance.store = Store.attach(
            getObjectBoxModel(),
            path,
          );
        } else {
          instance.store = await openStore(
            directory: path,
          );
        }
      });
    } on ObjectBoxException catch (e) {
      log("ERROR: Database: ${e.message}");
    }
  }
}
