import 'package:rule_engine/rule_engine.dart';

class Compatible extends Fact {
  String? primary;
  String? secondary;
  Compatible(this.primary, this.secondary);

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    attributes["primary"] = primary;
    attributes["secondary"] = secondary;

    return attributes;
  }

  @override
  String toString() {
    return "$primary and $secondary";
  }
}

class Compatible2 extends Fact {
  List<String>? collection;
  Compatible2(this.collection);

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    attributes["collection"] = collection;

    return attributes;
  }

  @override
  String toString() {
    return collection.toString();
  }
}
