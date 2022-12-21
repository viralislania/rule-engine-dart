import 'package:rule_engine/rule_engine.dart';

enum ActionType {
  payableAmount,
  selection,
  editable,
  displayStatus,
  noAction,
  notAllowedCombination
}

class Action extends Fact {
  ActionType actionType = ActionType.noAction;
  String? tenderId;
  String? offerId;
  String? displayStatus;
  bool? isEditable;
  String? minValue;
  String? maxValue;
  String? message;
  String? isPreSelected;
  String? isPreferred;
  String? healthCheckStatus;
  String? restrictionMsg;
  double? payableAmount;

  Action(
      {required this.actionType,
      this.tenderId,
      this.offerId,
      this.displayStatus,
      this.isEditable,
      this.minValue,
      this.maxValue,
      this.message,
      this.isPreSelected,
      this.isPreferred,
      this.healthCheckStatus,
      this.restrictionMsg,
      this.payableAmount});

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = <String, dynamic>{};

    attributes["actionType"] = actionType;
    attributes["tenderId"] = tenderId;
    attributes["offerId"] = offerId;
    attributes["displayStatus"] = displayStatus;
    attributes["isEditable"] = isEditable;
    attributes["minValue"] = minValue;
    attributes["maxValue"] = maxValue;
    attributes["message"] = message;
    attributes["isPreSelected"] = isPreSelected;
    attributes["isPreferred"] = isPreferred;
    attributes["healthCheckStatus"] = healthCheckStatus;
    attributes["restrictionMsg"] = restrictionMsg;
    attributes["payableAmount"] = payableAmount;
    return attributes;
  }

  void takeAction() {
    switch (actionType) {
      case ActionType.payableAmount:
        updatePayableAmount(payableAmount);
        break;
      case ActionType.displayStatus:
        break;
      case ActionType.editable:
        makeEditable(tenderId, isEditable);
        break;
      case ActionType.selection:
        break;
      case ActionType.notAllowedCombination:
        notAllowedCombination(tenderId, message);
        break;
      case ActionType.noAction:
        break;
    }
  }

  void updatePayableAmount(amount) {
    print(amount);
  }

  void makeEditable(tenderId, isEditable) {
    print("make $tenderId editable $isEditable");
  }

  void notAllowedCombination(tenderId, message) {
    print("$tenderId  $message");
  }
}
