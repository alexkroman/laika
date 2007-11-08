package org.projectlaika.validator.codesystem;

import java.util.HashMap;
import java.util.Map;

import javax.xml.namespace.QName;
import javax.xml.xpath.XPathFunction;
import javax.xml.xpath.XPathFunctionResolver;

public class Resolver implements XPathFunctionResolver {
	private Map<QName, XPathFunction> functions = new HashMap<QName, XPathFunction>();
	private static final QName name = new QName("http://", "valid-isbn");

	public XPathFunction resolveFunction(QName name, int arity) {

		return null;
	}

}
