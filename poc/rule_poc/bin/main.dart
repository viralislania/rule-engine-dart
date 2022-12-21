import 'package:rule_engine/rule_engine.dart';
import 'package:rule_poc/rule_action/action_transformer.dart';
import 'package:rule_poc/rule_action/combination_rules.dart';
import 'package:rule_poc/rule_action/compatible.dart';


void main() {
  _ruleActionExecution();
}

void _ruleActionExecution() {
  String code = r"""
rule "payable amount"
  when
      CombinationRules(tenderId == "coin", offerId=="Citi xyz",$payableAmount: actualAmount, actualAmount > 1000 )
  then
      publish Action("updatePayableAmount","900")
end

rule "disable coin"
  when
      CombinationRules(tenderId == "Citi abc", offerId=="offerId90", $payableAmount:payableAmount, actualAmount > 50)
  then
      publish Action("editable", "coin", "false")
end

rule "payable amount unchanged"
  when
      CombinationRules(tenderId == "coin", offerId=="Citi xyz",$payableAmount: actualAmount, actualAmount < 1000 )
  then
      publish updatePayableAmount($payableAmount)
end
""";

  String code2 = r"""
rule "disable coin"
  when
      CombinationRules(tenderId == "Citi abc", offerId=="offerId90", $payableAmount:payableAmount, $actualAmount:actualAmount)
  then
      publish Action("editable", "#N001", "false")
end

""";

  String applicable_tender_test = r"""
rule "coin not allowed with"
  when
      Compatible(primary == "coin", secondary == "Citi", $primary:primary, $secondary:secondary)
  then
      publish Action("notAllowedCombination","$primary", "$secondary", "These combination are not allowed")
end

""";
  String applicable_tender_test2 = r"""
rule "coin not allowed with"
  when
      Compatible(collection in ("coin","Citi"))
  then
      publish Action("notAllowedCombination","$primary", "$secondary", "These combination are not allowed")
end

""";
  final ruleEngine = RuleEngine(code);

  final results = [];
  ruleEngine.registerListener((t, a) {
    ActionTransformer at = ActionTransformer();
    var action = at.transform(t, a);
    action.takeAction();
    results.add(t);
  });

  // ruleEngine.insertFact(Compatible2(["coin", "Citi"]));
  ruleEngine.insertFact(Compatible("coin", "Citi"));
  // assert(results.length == 1);
  ruleEngine.insertFact(CombinationRules("Citi abc", "offerId90", 100, 1100));
  // assert(results.length == 1);

  ruleEngine.insertFact(CombinationRules("HDFC 12", "10% xyz", 0, 800));
  // assert(results.length == 1);

  ruleEngine.insertFact(CombinationRules("coin", "Citi xyz", 0, 1100));
  // assert(results.length == 2);
}
