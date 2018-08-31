import 'package:rule_engine/src/fact.dart';
import 'package:rule_engine/rule_engine.dart';
import 'package:test/test.dart';

void _basicTest() {
  String code = r"""
rule "Bob saved some money"
  when
    not Achievement( title ==  $ruleName )
    Expense( amount > 10, $amount: amount )
  then
    publish Achievement( "01", $ruleName, $amount )
end
""";
  var ruleEngine = new RuleEngine(code);

  var results = new List();
  ruleEngine.registerListener((t, a) {
    if (t == "Achievement") results.add(new Achievement(a[0], a[1], a[2]));
  });

  ruleEngine.insertFact(new Expense("Bob", 1000, "Cheese", new DateTime.now()));
  expect(results.length, equals(1));
  expect(results[0].attributeMap()["title"], "Bob saved some money");
  ruleEngine.insertFact(new Achievement("01", "Bob saved some money", 100));

  ruleEngine.insertFact(new Expense("Bob", 2000, "Cheese", new DateTime.now()));
  expect(results.length, equals(1));
}

void main() {
  test('Test symbol of rule name', _basicTest);
}

class Expense extends Fact {
  Map<String, dynamic> attributes = new Map<String, dynamic>();

  Expense(name, amount, category, created) {
    attributes["name"] = name;
    attributes["amount"] = amount;
    attributes["category"] = category;
    attributes["created"] = created;
  }

  @override
  Map<String, dynamic> attributeMap() {
    return attributes;
  }
}

class Achievement extends Fact {
  Map<String, dynamic> attributes = new Map<String, dynamic>();

  Achievement(badge, title, descr) {
    attributes["badge"] = badge;
    attributes["title"] = title;
    attributes["descr"] = descr;
  }

  @override
  Map<String, dynamic> attributeMap() {
    return attributes;
  }
}
