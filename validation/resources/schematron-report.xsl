<?xml version="1.0" ?>
<!-- Preprocessor for the Schematron XML Schema Language.
	http://www.ascc.net/xml/resource/schematron/schematron.html
 
 Copyright (c) 1999 Rick Jelliffe and Academia Sinica Computing Center, Taiwan

 This software is provided 'as-is', without any express or implied warranty. 
 In no event will the authors be held liable for any damages arising from 
 the use of this software.

 Permission is granted to anyone to use this software for any purpose, 
 including commercial applications, and to alter it and redistribute it freely,
 subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not claim
 that you wrote the original software. If you use this software in a product, 
 an acknowledgment in the product documentation would be appreciated but is 
 not required.

 2. Altered source versions must be plainly marked as such, and must not be 
 misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.
    1999-10-25  Version for David Carlisle's schematron-report error browser
    1999-11-5   Beta for 1.2 DTD
    1999-12-26  Add code for namespace: thanks DC
    1999-12-28  Version fix: thanks Uche Ogbuji
    2000-03-27  Generate version: thanks Oliver Becker
    2000-10-20  Fix '/' in do-all-patterns: thanks Uche Ogbuji
-->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
  xmlns:node="http://www.jclark.com/xt/java/com.jclark.xsl.om"
  extension-element-prefixes="node"
>

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

<!-- Category: top-level-element -->
<xsl:output
  method="xml" 
  omit-xml-declaration="no"
  standalone="yes" 
  indent="yes" />

<xsl:template match="schema">
	<axsl:stylesheet version="1.0">

                <xsl:for-each select="ns">
                <xsl:attribute
                        name="{concat(@prefix,':dummy-for-xmlns')}"
                        namespace="{@uri}"/>
                </xsl:for-each>
                <xsl:attribute name="version">1.0</xsl:attribute>

        <xsl:apply-templates mode="do-keys" />
        <axsl:output method="html" />
		<axsl:template match='/'>
<html>
<style>
A:link {color: black}
A:visited {color: gray}
A:active {color: #FF0088}
h3 { background-color:black; color:white; 
	font-family:Arial Black; font-size:12pt; }
h3.linked { background-color:black; color:white; 
	font-family:Arial Black; font-size:12pt; }
</style>
<h2 title="Schematron contact-information is at the end of this page"
><font color="#FF0080" >Schematron</font> Report</h2>
<h1 title="{@ns} {@fpi}"><xsl:value-of select="title" /></h1>
<div class="errors">
<ul>
			<xsl:apply-templates mode="do-all-patterns" />
</ul>
</div>
<hr color="#FF0080" />
			<p><font size="2">Schematron Report by David Carlisle.  
<a 
	href="http://www.ascc.net/xml/resource/schematron/schematron.html"
	title="Link to the home page of the Schematron, 
a tree-pattern schema language"
	><font color="#FF0080" >The Schematron</font></a> by 
	<a href="mailto:ricko@gate.sinica.edu.tw"
	title="Email to Rick Jelliffe (pronounced RIK JELIF)"
	>Rick Jelliffe</a>,
	<a href="http://www.sinica.edu.tw"
	title="Link to home page of Academia Sinica"
	>Academia Sinica Computing Centre</a>. 
</font></p>
	</html>
		</axsl:template>


		<xsl:apply-templates />

       		<axsl:template match="text()" priority="-1">
       			<!-- strip characters -->
       		</axsl:template>
	</axsl:stylesheet>

</xsl:template>


<xsl:template match="pattern" mode="do-all-patterns">
<xsl:choose>
	<xsl:when test="@see">
		<a href="{@see}" target="SRDOCO" title="Link to User Documentation. "
		><h3 class="linked"
		><xsl:value-of select="@name"/></h3></a>
	</xsl:when>
	<xsl:otherwise>		
		<h3><xsl:value-of select="@name"/></h3>
	</xsl:otherwise>
</xsl:choose>
<axsl:apply-templates select='/' mode='M{count(preceding-sibling::*)}' />
</xsl:template>

<xsl:template match="pattern">
        <xsl:comment>#### PATTERN STARTS #####</xsl:comment>
	<xsl:apply-templates />

       	<axsl:template match="text()" priority="-1" mode="M{count(preceding-sibling::*)}">
       		<!-- strip characters -->
        </axsl:template>
</xsl:template>

<xsl:template match="rule">
        <xsl:comment>#### RULE STARTS #####</xsl:comment>
	<axsl:template match='{@context}' priority='{4000 - count(preceding-sibling::*)}' mode='M{count(../preceding-sibling::*)}'>
		<xsl:apply-templates />
        	<axsl:apply-templates mode='M{count(../preceding-sibling::*)}'/>
	</axsl:template>

</xsl:template>

<xsl:template match="assert">
	<axsl:choose> 
		<axsl:when test='{@test}'/>
		<axsl:otherwise>
<li><a href="schematron-out.html#{{generate-id(.)}}" target="out"
         title="Link to where this pattern was expected"
>
			<xsl:apply-templates mode="text"/>
</a>
<!-- Something like this code will get line numbers working eventually :-) -->
 <xsl:if test="function-available('node:getLineNumber') ">
      <xsl:value-of select="node:getLineNumber()"/>
    </xsl:if>
   
</li> 
		</axsl:otherwise>
	</axsl:choose> 

</xsl:template>

<xsl:template match="report">
	<axsl:if test='{@test}'>
<li><a href="schematron-out.html#{{generate-id(.)}}" target="out"
         title="Link to where this pattern was found"
>
			<xsl:apply-templates mode="text"/>
</a></li>
	</axsl:if> 
</xsl:template>

<xsl:template match="name" mode="text">
 	<xsl:choose>
 		<xsl:when test='@path' >
 			<tt><axsl:value-of select="name({@path})" /></tt>
 		</xsl:when>
 		<xsl:otherwise>
 			<tt><axsl:value-of select="name(.)" /></tt>
 		</xsl:otherwise>
 	</xsl:choose>
</xsl:template>


<xsl:template match="rule/key" mode="do-keys">
	<axsl:key match="{../@context}" name="@name" path="@use" />
</xsl:template>

<xsl:template match="text()" priority="-1" mode="do-keys" >
	<!-- strip characters -->
</xsl:template>

<xsl:template match="text()" priority="-1" mode="do-all-patterns">
	<!-- strip characters -->
</xsl:template>

<xsl:template match="text()" priority="-1">
	<!-- strip characters -->
</xsl:template>

<!-- Note: there is a mode=text available, to allow overriding of 
this default. -->


</xsl:stylesheet>
