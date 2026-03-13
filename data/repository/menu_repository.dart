import 'package:flutter/services.dart';
import 'package:contactando_app_gs/configuration/app_logger.dart';

import '../models/menu.dart';

class MenuRepository {
  static final _log = AppLogger.getLogger("MenuRepository");

  MenuRepository();

  Future<List<Menu>> list() async {
    _log.debug("BEGIN:getMenus repository start");
    final json = await rootBundle.loadString('assets/mock/menus.json');
    final result = Menu.fromJsonStringList(json);
    _log.debug("END:getMenus successful - response.body: {}", [result.toString()]);
    return result;
  }
}
