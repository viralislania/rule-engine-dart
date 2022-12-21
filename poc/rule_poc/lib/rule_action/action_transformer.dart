import 'action.dart';

class ActionTransformer {
  Action action = Action(actionType: ActionType.noAction);
  Action transform(String type, List<String> params) {
    if (type != 'Action') return action;

    for (var i = 0; i < params.length; i++) {
      switch (params[i]) {
        case "updatePayableAmount":
          action.actionType = ActionType.payableAmount;
          action.payableAmount = double.parse(params[i + 1]);
          break;
        case "editable":
          action.actionType = ActionType.editable;
          action.tenderId = params[i + 1];
          action.isEditable = params[i + 2] == "true";
          break;
        case "notAllowedCombination":
          action.actionType = ActionType.notAllowedCombination;
          action.tenderId = "${params[i + 1]} ${params[i + 2]}";
          action.message = params[i + 3];
          break;
      }
    }

    return action;
  }
}
