import 'package:rule_engine/rule_engine.dart';

class CombinationRules extends Fact {
  String? tenderId;
  String? offerId;
  int? payableAmount;
  int? actualAmount;
  CombinationRules(this.tenderId, this.offerId, this.payableAmount, this.actualAmount);

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = Map<String, dynamic>();
    attributes["tenderId"] = tenderId;
    attributes["offerId"] = offerId;
    attributes["payableAmount"] = payableAmount;
    attributes["actualAmount"] = actualAmount;

    return attributes;
  }

  @override
  String toString() {
    return "$tenderId";
  }
}
