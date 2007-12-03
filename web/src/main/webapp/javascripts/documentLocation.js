function insertNamespace()
{
  var template = new Template($F("namespaceTemplate"));
  var presentNamespaces = $$("li.nsForm");
  var context = {nsIndex: presentNamespaces.length};
  Element.insert($("nsInserter"), {before: template.evaluate(context)});
}