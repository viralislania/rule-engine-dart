import 'package:rule_engine/rule_engine.dart';

import 'action.dart';

class OneClickTender extends Fact {
  String id;
  Action action;
  OneClickTender(this.id, this.action);

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = Map<String, dynamic>();
    attributes["id"] = id;
    attributes["action"] = action;

    return attributes;
  }

  @override
  String toString() {
    return id;
  }
}
