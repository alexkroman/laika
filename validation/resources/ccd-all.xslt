<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:sch="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                xmlns:cda="urn:hl7-org:v3"
                version="1.0"
                cda:dummy-for-xmlns="">
   <xsl:output method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>
   <xsl:template match="*|@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:if test="count(. | ../@*) = count(../@*)">@</xsl:if>
      <xsl:value-of select="name()"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="/">
      <svrl:schematron-output title="Schematron schema for validating conformance to CCD documents"
                              schemaVersion="">
         <marker/>
         <svrl:phase id="errors"/>
         <svrl:phase id="warning"/>
         <svrl:phase id="manual"/>
      </svrl:schematron-output>
   </xsl:template>
   <svrl:phase id="errors"/>
   <svrl:phase id="warning"/>
   <svrl:phase id="manual"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]" priority="3999"
                 mode="M5">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:ClinicalDocument"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:ClinicalDocument">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a CCD document must be ClinicalDocument in the HL7 namespace</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='34133-9'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='34133-9'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The ClinicalDocument/code element SHALL be present, and SHALL be valued with LOINC code 34133-9 (SUMMARIZATION OF EPISODE NOTE).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:documentationOf/cda:serviceEvent"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:documentationOf/cda:serviceEvent">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A CCD SHALL contain exactly one ClinicalDocument / documentationOf / serviceEvent.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:documentationOf/cda:serviceEvent/@classCode='PCPR'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:documentationOf/cda:serviceEvent/@classCode='PCPR'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "ClinicalDocument / documentationOf / serviceEvent / classCode" SHALL be "PCPR" "Care provision" 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime/cda:low"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime/cda:low">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>ClinicalDocument / documentationOf / serviceEvent SHALL contain exactly one serviceEvent / effectiveTime / low and exactly one serviveEvent / effectiveTime / high.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime/cda:high"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime/cda:high">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>ClinicalDocument / documentationOf / serviceEvent SHALL contain exactly one serviceEvent / effectiveTime / low and exactly one serviveEvent / effectiveTime / high.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:languageCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:languageCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHALL contain exactly one ClinicalDocument / languageCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId)&gt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId)&gt;=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHALL contain one or more ClinicalDocument / templateId.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:templateId[@root='2.16.840.1.113883.10.20.1' and not(@extension)]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:templateId[@root='2.16.840.1.113883.10.20.1' and not(@extension)]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>At least one ClinicalDocument / templateId SHALL value ClinicalDocument / templateId / @root with "2.16.840.1.113883.10.20.1", and SHALL NOT contain ClinicalDocument / templateId / @extension.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="string-length(cda:effectiveTime/@value) &gt; 18"/>
         <xsl:otherwise>
            <svrl:failed-assert test="string-length(cda:effectiveTime/@value) &gt; 18">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>ClinicalDocument / effectiveTime SHALL be expressed with precision to include seconds.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:effectiveTime/@value,&#34;+-&#34;,&#34;ZZ&#34;),&#34;Z&#34;)"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:effectiveTime/@value,&#34;+-&#34;,&#34;ZZ&#34;),&#34;Z&#34;)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>ClinicalDocument / effectiveTime SHALL include an explicit time zone offset.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:recordTarget)&lt;=2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:recordTarget)&lt;=2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD shall contain one to two ClinicalDocument / recordTarget.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:author/cda:assignedAuthor/cda:assignedPerson | cda:author/cda:assignedAuthor/cda:representedOrganization"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:author/cda:assignedAuthor/cda:assignedPerson | cda:author/cda:assignedAuthor/cda:representedOrganization">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHALL contain one or more ClinicalDocument / author / assignedAuthor / assignedPerson and/or ClinicalDocument / author / assignedAuthor / representedOrganization.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD MAY contain exactly one and SHALL NOT contain more than one Purpose section (templateId 2.16.840.1.113883.10.20.1.13).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.9&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Payers section (templateId 2.16.840.1.113883.10.20.1.9).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.1&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Advance directives section (templateId 2.16.840.1.113883.10.20.1.1).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Problem section (templateId 2.16.840.1.113883.10.20.1.11).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.7&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Medical Equipment section (templateId 2.16.840.1.113883.10.20.1.7).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.6&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Immunizations section (templateId 2.16.840.1.113883.10.20.1.6).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.9&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Payers section (templateId 2.16.840.1.113883.10.20.1.9).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.1&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Advance directives section (templateId 2.16.840.1.113883.10.20.1.1).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.5&#34;])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Functional status section (templateId 2.16.840.1.113883.10.20.1.5).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.14']) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.14']) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Results section (templateId 2.16.840.1.113883.10.20.1.14).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.12']) &lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.12']) &lt;=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Procedures section (templateId 2.16.840.1.113883.10.20.1.12).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.3'])  &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(.//cda:templateId[@root='2.16.840.1.113883.10.20.1.3']) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>CCD SHOULD contain exactly one and SHALL NOT contain more than one Encounters section (templateId 2.16.840.1.113883.10.20.1.3).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]" priority="3999"
                 mode="M6">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]" priority="3999"
                 mode="M7">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]" priority="3999"
                 mode="M8">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of an Advance Directives section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Advance Directives section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='42348-3'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='42348-3'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Section / code SHALL be '42348-3' 'Advance directives' 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Advance Directives section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]" priority="3999"
                 mode="M9">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Purpose section SHOULD include one or more advance directive observations (templateId 2.16.840.1.113883.10.20.1.17)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]/cda:code[@code=&#34;304251008&#34;][@codeSystem=&#34;2.16.840.1.113883.6.96&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]/cda:code[@code=&#34;304251008&#34;][@codeSystem=&#34;2.16.840.1.113883.6.96&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>There SHOULD be an advance directive observation whos value for Observation / code is '304251008' 'Resuscitation status' 2.16.840.1.113883.6.96 SNOMED CT STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'advance directives')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'advance directives')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “advance directives”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]" priority="3999"
                 mode="M10">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]" priority="3999"
                 mode="M11">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Alerts section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Alerts section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The alert section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The alert section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]" priority="3999"
                 mode="M12">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Alerts section SHOULD include one or more problem acts (templateId 2.16.840.1.113883.10.20.1.27).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'alert') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'allergies and adverse reactions')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'alert') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'allergies and adverse reactions')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “alert” and/or “allergies and adverse reactions”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M12"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27'][ancestor::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.2']]"
                 priority="3998"
                 mode="M12">
      <svrl:fired-rule context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27'][ancestor::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.2']]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.18']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.18']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act SHOULD include one or more alert observations (templateId 2.16.840.1.113883.10.20.1.18).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]" priority="3999"
                 mode="M13">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]" priority="3999"
                 mode="M14">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Encounters section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='46240-8'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='46240-8'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Section / code” SHALL be “46240-4” “History of encounters” 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>encounters section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]" priority="3999"
                 mode="M15">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.21']"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.21']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Encounters SHOULD include one or more encounter activities (templateId 2.16.840.1.113883.10.20.1.21).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'encounters')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'encounters')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “encounters”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]" priority="3999"
                 mode="M16">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]" priority="3999"
                 mode="M17">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@code='10157-6'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='10157-6'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The family history section SHALL contain Section / code. The value for "Section / code" SHALL be "10157-6" "History of family member diseases" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The family history section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="not(cda:subject)"/>
         <xsl:otherwise>
            <svrl:failed-assert test="not(cda:subject)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The family history section SHALL NOT contain Section / subject.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]" priority="3999"
                 mode="M18">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]"/>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'family history')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'family history')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “family history”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]" priority="3999"
                 mode="M19">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]" priority="3999"
                 mode="M20">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Functional Status section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Functional Status section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='47420-5'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='47420-5'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Section / code SHALL be '47420-5' 'Functional status assessment' 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Functional Status section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]" priority="3999"
                 mode="M21">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;] | descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;] | descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Functional Status section SHOULD include one or more problem acts (templateId 2.16.840.1.113883.10.20.1.27) and/or result organizers (templateId 2.16.840.1.113883.10.20.1.32).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'functional status')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'functional status')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “functional status”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]" priority="3999"
                 mode="M22">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]" priority="3999"
                 mode="M23">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of an Immunizations section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Immunizations section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The immunizations section SHALL contain Section / code</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='11369-6'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='11369-6'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Section / code” SHALL be “11369-6” “History of immunizations” 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The immunizations section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]" priority="3999"
                 mode="M24">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]|descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]|descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Immunizations section SHOULD include one or more medication activities (templateId 2.16.840.1.113883.10.20.1.24) and/or supply activities (templateId 2.16.840.1.113883.10.20.1.34).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'immunization')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'immunization')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “immunization”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]" priority="3999"
                 mode="M25">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]" priority="3999"
                 mode="M26">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a medical equipment section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medical equipment section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medical equipment section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='46264-8'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='46264-8'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for 'Section / code' SHALL be '46264-8' 'History of medical device use' 2.16.840.1.113883.6.1 LOINC STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medical equipment section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]" priority="3999"
                 mode="M27">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medical equipment section SHOULD include one or more supply activities (templateId 2.16.840.1.113883.10.20.1.34)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'equipment')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'equipment')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “equipment”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]" priority="3999"
                 mode="M28">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]" priority="3999"
                 mode="M29">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Medications section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Medications section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medications section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='10160-0'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='10160-0'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Section / code” SHALL be “10160-0” “History of medication use” 2.16.840.1.113883.6.1 LOINC STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The medications section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]" priority="3999"
                 mode="M30">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.24' or cda:templateId/@root='2.16.840.1.113883.10.20.1.34' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.24' or cda:templateId/@root='2.16.840.1.113883.10.20.1.34' ]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Medications section SHOULD include one or more medication activities (templateId 2.16.840.1.113883.10.20.1.24) and/or supply activities (templateId 2.16.840.1.113883.10.20.1.34)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'medication')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'medication')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “medication”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]" priority="3999"
                 mode="M31">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]" priority="3999"
                 mode="M32">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Payers section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Payers section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='48768-6'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='48768-6'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Section / code in a Payers section SHALL be "35525-5" "Financing and insurance" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Payers section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]" priority="3999"
                 mode="M33">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Payers section SHOULD include one or more coverage activities (templateId 2.16.840.1.113883.10.20.1.20).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'insurance') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'payers')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'insurance') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'payers')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “insurance” or “payers”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]" priority="3999"
                 mode="M34">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]" priority="3999"
                 mode="M35">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Plan of care section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Plan of Care section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='18776-5'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='18776-5'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The plan of care section SHALL contain Section / code. The value for “Section / code” SHALL be “18776-5” “Treatment plan” 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The plan of care section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]" priority="3999"
                 mode="M36">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.25']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.25']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Plan of Care SHOULD contain clinical statements. Clinical statements SHALL include one or more plan of care activities (templateId 2.16.840.1.113883.10.20.1.25)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'plan')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'plan')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “plan”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]" priority="3999"
                 mode="M37">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]" priority="3999"
                 mode="M38">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Problem section SHALL contain a narrative block</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='11450-4'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='11450-4'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The problem section SHALL contain Section / code. The value for “Section / code” SHALL be “11450-4” “Problem list” 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The problem section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]" priority="3999"
                 mode="M39">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.27']"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.27']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Clinical statements SHOULD include one or more problem acts (templateId 2.16.840.1.113883.10.20.1.27).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'problem')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'problem')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “problem”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]" priority="3999"
                 mode="M40">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]" priority="3999"
                 mode="M41">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Procedures section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='47519-4'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='47519-4'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The procedure section SHALL contain Section / code. The value for "Section / code" SHALL be "47519-4" "History of procedures" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The procedure section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M41"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]" priority="3998"
                 mode="M41">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Procedures section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]" priority="3999"
                 mode="M42">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.29']"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.29']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The procedure section SHOULD contain clinical statements, which SHOULD include one or more procedure activities (templateId 2.16.840.1.113883.10.20.1.29).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'procedures')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'procedures')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “procedures”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]" priority="3999"
                 mode="M43">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]" priority="3999"
                 mode="M44">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a purpose section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Purpose section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='48764-5'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='48764-5'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Section / code SHALL be "48764-5" "Summary purpose" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Purpose section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text>PURPOSE SECTION LOINC CODE NEEDS UPDATING WHEN FINAL SPEC IS RELEASED.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]" priority="3999"
                 mode="M45">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Purpose section SHOULD include one or more purpose activities (templateId 2.16.840.1.113883.10.20.1.30).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'purpose')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'purpose')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “purpose”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]" priority="3999"
                 mode="M46">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]" priority="3999"
                 mode="M47">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Results section shall be section in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Results section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The result section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='30954-2'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='30954-2'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Section / code SHALL be 30954-2 Relevant diagnostic tests and/or laboratory data 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The results section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]" priority="3999"
                 mode="M48">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Results section SHOULD include one or more result organizers (templateId 2.16.840.1.113883.10.20.1.32).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'results')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'results')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “results”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]" priority="3999"
                 mode="M49">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]" priority="3999"
                 mode="M50">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Social history section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Social history section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The social history section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='29762-2'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='29762-2'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Section / code” SHALL be “29762-2” “Social history” 2.16.840.1.113883.6.1 LOINC STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The social history section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]" priority="3999"
                 mode="M51">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.33']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.33']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Social history section SHOULD include one or more social history observations (templateId 2.16.840.1.113883.10.20.1.33)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'social history')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'social history')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “social history”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]" priority="3999"
                 mode="M52">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]" priority="3999"
                 mode="M53">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:section"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:section">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The root of a Vital Signs section shall be 'section' in the HL7 namespace.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:text"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:text">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Vital Signs section SHALL contain a narrative block.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The vital signs section SHALL contain Section / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='8716-3'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='8716-3'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Section / code” SHALL be “8716-3” “Vital signs” 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:title"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:title">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The vital signs section SHALL contain Section / title.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]/descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]/descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Each vital signs organizers SHALL contain one or more result observations (templateId 2.16.840.1.113883.10.20.1.31)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]" priority="3999"
                 mode="M54">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The Vital Signs section SHOULD include one or more vital signs organizers (templateId 2.16.840.1.113883.10.20.1.35)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'vital signs')"/>
         <xsl:otherwise>
            <svrl:failed-assert test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'vital signs')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “vital signs”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]" priority="3999"
                 mode="M55">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]" priority="3999"
                 mode="M56">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive observation (templateId 2.16.840.1.113883.10.20.1.17) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / classCode in an advance directive observation SHALL be 'OBS' 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / moodCode in an advance directive observation SHALL be 'EVN' 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive observation SHALL contain at least one Observation / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive observation SHALL contain exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / statusCode in an advance directive observation SHALL be 'completed' 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;])=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive observation SHALL contain exactly one advance directive status observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;])&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;])&lt;=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive observation MAY contain exactly one advance directive reference.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]" priority="3999"
                 mode="M57">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]" priority="3999"
                 mode="M58">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]" priority="3999"
                 mode="M59">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An alert observation (templateId 2.16.840.1.113883.10.20.1.18) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in an alert observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An alert observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / statusCode” in an alert observation SHALL be “completed” 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participant//cda:playingEntity)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participant//cda:playingEntity)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An agent participation in an alert observation SHALL contain exactly one participant / participantRole / playingEntity.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participant[@typeCode='CSM']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant[@typeCode='CSM']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>value for Observation / participant / typeCode in an agent participation SHALL be “CSM” “Consumable” 2.16.840.1.113883.5.90 ParticipationType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participant/cda:participantRole[@classCode='MANU']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant/cda:participantRole[@classCode='MANU']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / participant / participantRole / classCode in an agent participation SHALL be “MANU” “Manufactured” 2.16.840.1.113883.5.110 RoleClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participant /cda:participantRole/cda:playingEntity[@classCode='MMAT']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant /cda:participantRole/cda:playingEntity[@classCode='MMAT']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / participant / participantRole / playingEntity / classCode in an agent participation SHALL be “MMAT” “Manufactured material” 2.16.840.1.113883.5.41 EntityClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participant//cda:playingEntity//cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participant//cda:playingEntity//cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An agent participation in an alert observation SHALL contain exactly one participant / participantRole / playingEntity / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M59"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"
                 priority="3998"
                 mode="M59">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:choose>
         <xsl:when test="parent::*[cda:entryRelationship/@typeCode='MFST']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::*[cda:entryRelationship/@typeCode='MFST']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship between an alert observation and reaction observation SHALL be “MFST” “Is manifestation of” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]" priority="3999"
                 mode="M60">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participant"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An alert observation SHOULD contain at least one Observation / participant, representing the agent that is the cause of the allergy or adverse reaction.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participant/cda:participantRole/cda:playingEntity/cda:code[@codeSystem='2.16.840.1.113883.6.88' or @codeSystem='2.16.840.1.113883.6.59' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant/cda:participantRole/cda:playingEntity/cda:code[@codeSystem='2.16.840.1.113883.6.88' or @codeSystem='2.16.840.1.113883.6.59' ]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “participant / participantRole / playingEntity / code” in an agent participation SHOULD be selected from the RxNorm (2.16.840.1.113883.6.88) code system for medications, and from the CDC Vaccine Code (2.16.840.1.113883.6.59) code system for immunizations.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]" priority="3999"
                 mode="M61">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]" priority="3999"
                 mode="M62">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An authorization activity (templateId 2.16.840.1.113883.10.20.1.19) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='ACT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='ACT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / classCode in an authorization activity SHALL be 'ACT' 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An authorization activity SHALL contain at least one Act / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / moodCode in an authorization activity SHALL be 'EVN' 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An authorization activity SHALL contain one or more Act / entryRelationship.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M62"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.19']/cda:entryRelationship"
                 priority="3998"
                 mode="M62">
      <svrl:fired-rule context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.19']/cda:entryRelationship"/>
      <xsl:choose>
         <xsl:when test="@typeCode='SUBJ'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@typeCode='SUBJ'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / entryRelationship / typeCode in an authorization activity SHALL be 'SUBJ' 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="*[@moodCode='PRMS']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="*[@moodCode='PRMS']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of an authorization activity with Act / entryRelationship / @typeCode='SUBJ' SHALL be a clinical statement with moodCode = 'PRMS' (Promise).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]" priority="3999"
                 mode="M63">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]" priority="3999"
                 mode="M64">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]" priority="3999"
                 mode="M65">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A coverage activity (templateId 2.16.840.1.113883.10.20.1.20) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@classCode='ACT']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@classCode='ACT']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / classCode in a coverage activity SHALL be 'ACT' 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@moodCode='DEF']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@moodCode='DEF']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / moodCode in a coverage activity SHALL be "DEF" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A coverage activity SHALL contain at least one Act / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A coverage activity SHALL contain exactly one Act / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / statusCode in a coverage activity SHALL be 'completed' 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='35525-5'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='35525-5'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / code in a coverage activity SHALL be "35525-5" "Financing and insurance" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A coverage activity SHALL contain one or more Act / entryRelationship.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="not(cda:entryRelationship[cda:sequenceNumber[position()=2]])"/>
         <xsl:otherwise>
            <svrl:failed-assert test="not(cda:entryRelationship[cda:sequenceNumber[position()=2]])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An entryRelationship in a coverage activity MAY contain exactly one entryRelationship / sequenceNumber, which serves to order the payment sources.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="not(cda:entryRelationship[not(@typeCode='COMP')])"/>
         <xsl:otherwise>
            <svrl:failed-assert test="not(cda:entryRelationship[not(@typeCode='COMP')])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / entryRelationship / typeCode in a coverage activity SHALL be "COMP" 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M65"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.20']/cda:entryRelationship[@typeCode='COMP']"
                 priority="3998"
                 mode="M65">
      <svrl:fired-rule context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.20']/cda:entryRelationship[@typeCode='COMP']"/>
      <xsl:choose>
         <xsl:when test="*/cda:templateId[@root='2.16.840.1.113883.10.20.1.26']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="*/cda:templateId[@root='2.16.840.1.113883.10.20.1.26']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of a coverage activity with Act / entryRelationship / @typeCode='COMP' SHALL be a policy activity (templateId 2.16.840.1.113883.10.20.1.26).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]" priority="3999"
                 mode="M66">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]" priority="3999"
                 mode="M67">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]" priority="3999"
                 mode="M68">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:encounter"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:encounter">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An encounter activity (templateId 2.16.840.1.113883.10.20.1.21) SHALL be represented with Encounter.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='ENC'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='ENC'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Encounter / classCode" in an encounter activity SHALL be “ENC” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Encounter / moodCode" in an encounter activity SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An encounter activity SHALL contain at least one Encounter / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An encounter activity MAY contain exactly one Encounter / effectiveTime, to indicate date, time, and/or duration of an encounter.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M68"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]/cda:entryRelationship"
                 priority="3998"
                 mode="M68">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]/cda:entryRelationship"/>
      <xsl:choose>
         <xsl:when test="@typeCode='RSON'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@typeCode='RSON'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An encounter activity MAY contain one or more Encounter / entryRelationship, whose value for “entryRelationship / typeCode” SHALL be “RSON” “Has reason” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC, where the target of the relationship represents the indication for the activity.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M68"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]/cda:performer"
                 priority="3997"
                 mode="M68">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]/cda:performer"/>
      <xsl:choose>
         <xsl:when test="count(./cda:assignedEntity/cda:code) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(./cda:assignedEntity/cda:code) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Encounter / performer MAY contain exactly one Encounter / performer / assignedEntity / code, to define the role of the practioner.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]" priority="3999"
                 mode="M69">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:code) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An encounter activity SHOULD contain exactly one Encounter / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]" priority="3999"
                 mode="M70">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]" priority="3999"
                 mode="M71">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history observation (templateId 2.16.840.1.113883.10.20.1.22) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / moodCode" in a family history observation SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history observation SHALL contain at least one Observation / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / statusCode" in a family history observation SHALL be "completed" 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]" priority="3999"
                 mode="M72">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:effectiveTime">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history observation SHOULD include Observation / effectiveTime.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]" priority="3999"
                 mode="M73">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]" priority="3999"
                 mode="M74">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:organizer"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:organizer">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history organizer (templateId 2.16.840.1.113883.10.20.1.23) SHALL be represented with Organizer.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='CLUSTER'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='CLUSTER'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Organizer / classCode" in a family history organizer SHALL be "CLUSTER" 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Organizer / moodCode" in a family history organizer SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history organizer SHALL contain exactly one Organizer / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Organizer / statusCode" in a family history organizer SHALL be "completed" 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:component"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:component">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history organizer SHALL contain one or more Organizer / component.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history organizer SHALL contain exactly one subject participant, representing the family member who is the subject of the family history observations.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject/cda:relatedSubject)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A subject participant SHALL contain exactly one RelatedSubject, representing the relationship of the subject to the patient.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:subject/cda:relatedSubject/@classCode='PRS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:subject/cda:relatedSubject/@classCode='PRS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "RelatedSubject / classCode" SHALL be "PRS" "Personal relationship" 2.16.840.1.113883.5.110 RoleClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject/cda:relatedSubject/cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>RelatedSubject SHALL contain exactly one RelatedSubject / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]" priority="3999"
                 mode="M75">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:component[cda:observation/cda:templateId/@root='2.16.840.1.113883.10.20.1.22']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:component[cda:observation/cda:templateId/@root='2.16.840.1.113883.10.20.1.22']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of a family history organizer Organizer / component relationship SHOULD be a family history observation, but MAY be some other clinical statement.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject/cda:relatedSubject/cda:subject)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>RelatedSubject SHOULD contain exactly one RelatedSubject / subject.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject/cda:administrativeGenderCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject/cda:relatedSubject/cda:subject/cda:administrativeGenderCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>RelatedSubject / subject SHOULD contain exactly one RelatedSubject / subject / administrativeGenderCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:subject/cda:relatedSubject/cda:subject/cda:birthTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:subject/cda:relatedSubject/cda:subject/cda:birthTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>RelatedSubject / subject SHOULD contain exactly one RelatedSubject / subject / birthTime.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]" priority="3999"
                 mode="M76">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]" priority="3999"
                 mode="M77">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:substanceAdministration"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:substanceAdministration">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity (templateId 2.16.840.1.113883.10.20.1.24) SHALL be represented with SubstanceAdministration</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN' or @moodeCode='INT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN' or @moodeCode='INT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “SubstanceAdministration / moodCode” in a medication activity SHALL be “EVN” or “INT” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity SHALL contain at least one SubstanceAdministration / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M77"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"
                 priority="3998"
                 mode="M77">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:choose>
         <xsl:when test="parent::*[cda:entryRelationship/@typeCode='CAUS']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::*[cda:entryRelationship/@typeCode='CAUS']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship between a medication activity and reaction observation SHALL be “CAUS” “Is etiology for” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]" priority="3999"
                 mode="M78">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity SHOULD contain exactly one SubstanceAdministration / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:effectiveTime">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity SHOULD contain one or more SubstanceAdministration / effectiveTime elements, used to indicate the actual or intended start and stop date of a medication, and the frequency of administration.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:routeCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:routeCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity SHOULD contain exactly one SubstanceAdministration / routeCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:doseQuantity)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:doseQuantity)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication activity SHOULD contain exactly one SubstanceAdministration / doseQuantity.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]" priority="3999"
                 mode="M79">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]" priority="3999"
                 mode="M80">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act or self::cda:encounter or self::cda:observation or self::cda:procedure or self::cda:substanceAdministration or self::cda:supply"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act or self::cda:encounter or self::cda:observation or self::cda:procedure or self::cda:substanceAdministration or self::cda:supply">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity (templateId 2.16.840.1.113883.10.20.1.25) SHALL be represented with Act, Encounter, Observation, Procedure, SubstanceAdministration, or Supply.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity SHALL contain at least one [Act | Encounter | Observation | Procedure | SubstanceAdministration | Supply] / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(@moodCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(@moodCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity SHALL contain exactly one [Act | Encounter | Observation | Procedure | SubstanceAdministration | Supply] / moodCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act or self::cda:encounter or self::cda:observation or self::cda:procedure or self::cda:substanceAdministration or self::cda:supply"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act or self::cda:encounter or self::cda:observation or self::cda:procedure or self::cda:substanceAdministration or self::cda:supply">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity (templateId 2.16.840.1.113883.10.20.1.25) SHALL be represented with Act, Encounter, Observation, Procedure, SubstanceAdministration, or Supply.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity SHALL contain at least one [Act | Encounter | Observation | Procedure | SubstanceAdministration | Supply] / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(@moodCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(@moodCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A plan of care activity SHALL contain exactly one [Act | Encounter | Observation | Procedure | SubstanceAdministration | Supply] / moodCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="(self::cda:act or self::cda:encounter or self::cda:procedure) and not (@moodCode='INT' or @moodCode='ARQ' or @moodCode='PRMS' or @moodCode='PRP' or @moodCode='RQO')">
         <svrl:successful-report test="(self::cda:act or self::cda:encounter or self::cda:procedure) and not (@moodCode='INT' or @moodCode='ARQ' or @moodCode='PRMS' or @moodCode='PRP' or @moodCode='RQO')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text>The value for “[Act | Encounter | Procedure] / moodCode” in a plan of care activity SHALL be [“INT” (intent) | “ARQ” (appointment request) | “PRMS” (promise) | “PRP” (proposal) | “RQO” (request)] 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:if test="(self::cda:substanceAdministration or self::cda:supply) and not (@moodCode='INT' or @moodCode='PRMS' or @moodCode='PRP' or @moodCode='RQO')">
         <svrl:successful-report test="(self::cda:substanceAdministration or self::cda:supply) and not (@moodCode='INT' or @moodCode='PRMS' or @moodCode='PRP' or @moodCode='RQO')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text>The value for “[SubstanceAdministration | Supply] / moodCode” in a plan of care activity SHALL be [“INT” (intent) | “PRMS” (promise) | “PRP” (proposal) | “RQO” (request)] 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:if test="(self::cda:observation) and not (@moodCode='INT' or @moodCode='PRMS'or @moodCode='PRP' or @moodCode='RQO' or @moodCode='GOL')">
         <svrl:successful-report test="(self::cda:observation) and not (@moodCode='INT' or @moodCode='PRMS'or @moodCode='PRP' or @moodCode='RQO' or @moodCode='GOL')">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text>The value for “Observation / moodCode” in a plan of care activity SHALL be [“INT” (intent) | “PRMS” (promise) | “PRP” (proposal) | “RQO” (request) | “GOL” (goal)] 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]" priority="3999"
                 mode="M81">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]" priority="3999"
                 mode="M82">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]" priority="3999"
                 mode="M83">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity (templateId 2.16.840.1.113883.10.20.1.26) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@classCode='ACT']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@classCode='ACT']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / classCode in a policy activity SHALL be 'ACT' 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / moodCode in a policy activity SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity SHALL contain at least one Act / id, which represents the group or contract number related to the insurance policy or program.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A coverage policy SHALL contain exactly one Act / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / statusCode in a policy activity SHALL be 'completed' 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:performer[@typeCode='PRF'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:performer[@typeCode='PRF'])=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity SHALL contain exactly one Act / performer [@typeCode="PRF"], representing the payer.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participant[@typeCode='COV'])=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participant[@typeCode='COV'])=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity SHALL contain exactly one Act / participant [@typeCode="COV"], representing the covered party.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participant[@typeCode='COV']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participant[@typeCode='COV']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity SHALL contain exactly one Act / participant [@typeCode="COV"], representing the covered party.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participant[@typeCode='HLD'])&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participant[@typeCode='HLD'])&lt;=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity MAY contain exactly one Act / participant [@typeCode='HLD'], representing the subscriber.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="not(cda:entryRelationship[not(@typeCode='REFR')])"/>
         <xsl:otherwise>
            <svrl:failed-assert test="not(cda:entryRelationship[not(@typeCode='REFR')])">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / entryRelationship / typeCode in a policy activity SHALL be 'REFR' 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M83"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;COV&#34;]"
                 priority="3998"
                 mode="M83">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;COV&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:time)&lt;=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:time)&lt;=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A covered party in a policy activity MAY contain exactly one participant / time, to represent the time period over which the patient is covered.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M83"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.26']/cda:entryRelationship[@typeCode='REFR']"
                 priority="3997"
                 mode="M83">
      <svrl:fired-rule context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.26']/cda:entryRelationship[@typeCode='REFR']"/>
      <xsl:choose>
         <xsl:when test="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.19'] | cda:act[@classCode='ACT'][@moodCode='DEF']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.19'] | cda:act[@classCode='ACT'][@moodCode='DEF']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of a policy activity with Act / entryRelationship / @typeCode='REFR' SHALL be an authorization activity (templateId 2.16.840.1.113883.10.20.1.19) or an Act, with Act [@classCode = 'ACT'] and Act [@moodCode = 'DEF'], representing a description of the coverage plan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M83"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.26']/cda:entryRelationship[@typeCode='REFR']/cda:act[@classCode='ACT'][@moodCode='DEF']"
                 priority="3996"
                 mode="M83">
      <svrl:fired-rule context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.26']/cda:entryRelationship[@typeCode='REFR']/cda:act[@classCode='ACT'][@moodCode='DEF']"/>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A description of the coverage plan SHALL contain one or more Act / Id, to represent the plan identifier.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]" priority="3999"
                 mode="M84">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A policy activity SHOULD contain zero to one Act / code, which represents the type of coverage.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M84"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;COV&#34;]"
                 priority="3998"
                 mode="M84">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;COV&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participantRole/cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A covered party in a policy activity SHOULD contain one or more participant / participantRole / id, to represent the patient's member or subscriber identifier with respect to the payer.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participantRole/cda:code">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A covered party in a policy activity SHOULD contain exactly one participant / participantRole / code, to represent the reason for coverage (e.g. Self, Family dependent, student).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M84"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;HLD&#34;]"
                 priority="3997"
                 mode="M84">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;HLD&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participantRole/cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A subscriber in a policy activity SHOULD contain one or more participant / participantRole / id, to represent the subscriber's identifier with respect to the payer.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]" priority="3999"
                 mode="M85">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]" priority="3999"
                 mode="M86">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act[@classCode='ACT'][@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@classCode='ACT'][@moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act (templateId 2.16.840.1.113883.10.20.1.27) SHALL be represented with Act. The value for "Act / classCode" in a problem act SHALL be "ACT" 2.16.840.1.113883.5.6 ActClass STATIC. The value for "Act / moodCode" in a problem act SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act SHALL contain at least one Act / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code/@nullFlavor='NA'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code/@nullFlavor='NA'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Act / code / @NullFlavor" in a problem act SHALL be "NA" "Not applicable" 2.16.840.1.113883.5.1008 NullFlavor STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act MAY contain exactly one Act / effectiveTime, to indicate the timing of the concern (e.g. the time the problem was noted).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act SHALL contain one or more Act / entryRelationship.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.41']) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.41']) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act MAY contain exactly one episode observation. The template identifier for an episode observation is 2.16.840.1.113883.10.20.1.41.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.48']) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.48']) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act MAY contain exactly one patient awareness.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]" priority="3999"
                 mode="M87">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.28']"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.28']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem act SHOULD include one or more problem observations (templateId 2.16.840.1.113883.10.20.1.28).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.28']                 or cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.18']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.28'] or cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.18']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of a problem act with Act / entryRelationship / @typeCode=”SUBJ” SHOULD be a problem observation (in the Problem section) or alert observation (in the Alert section, see section 3.9 Alerts), but MAY be some other clinical statement.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]" priority="3999"
                 mode="M88">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]" priority="3999"
                 mode="M89">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation[@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation[@moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation (templateId 2.16.840.1.113883.10.20.1.28) SHALL be represented with Observation. The value for "Observation / moodCode" in a problem observation SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / statusCode" in a problem observation SHALL be "completed" 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.50']) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.50']) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation MAY contain exactly one problem status observation. The template identifier for a problem status observation is 2.16.840.1.113883.10.20.1.50.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.51']) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.51']) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation MAY contain exactly one problem healthstatus observation. The template identifier for a problem healthstatus observation is 2.16.840.1.113883.10.20.1.51.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.48']) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:templateId[@root='2.16.840.1.113883.10.20.1.48']) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation MAY contain exactly one patient awareness.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]" priority="3999"
                 mode="M90">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation SHOULD contain exactly one Observation / effectiveTime, to indicate the timing of condition (e.g. the time the condition started, the onset of the illness or symptom).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]" priority="3999"
                 mode="M91">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]" priority="3999"
                 mode="M92">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:procedure or self::cda:act or self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:procedure or self::cda:act or self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A procedure activity (templateId 2.16.840.1.113883.10.20.1.29) SHALL be represented with Act, Observation, or Procedure.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "[Act | Observation | Procedure] / moodCode" in a procedure activity SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A procedure activity SHALL contain at least one [Act | Observation | Procedure] / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A procedure activity SHALL contain exactly one [Act | Observation | Procedure] / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A procedure activity SHALL contain exactly one [Act | Observation | Procedure] / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]" priority="3999"
                 mode="M93">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A procedure activity SHOULD contain exactly one [Act | Observation | Procedure] / effectiveTime.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “[Act | Observation | Procedure] / code” in a procedure activity SHOULD be selected from LOINC (codeSystem 2.16.840.1.113883.6.1) or SNOMED CT (codeSystem 2.16.840.1.113883.6.96).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]" priority="3999"
                 mode="M94">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]" priority="3999"
                 mode="M95">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A purpose activity (templateId 2.16.840.1.113883.10.20.1.30) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@classCode='ACT']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@classCode='ACT']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / classCode in a purpose activity SHALL be 'ACT' 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:act[@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act[@moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / moodCode in a purpose activity SHALL be 'EVN' 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A purpose activity SHALL contain exactly one Act / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Act / statusCode in a purpose activity SHALL be 'completed' 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='23745001'][@codeSystem='2.16.840.1.113883.6.96']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='23745001'][@codeSystem='2.16.840.1.113883.6.96']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A purpose activity SHALL contain exactly one Act / code, with a value of '23745001' 'Documentation procedure' 2.16.840.1.113883.6.96 SNOMED CT STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:entryRelationship/@typeCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:entryRelationship/@typeCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A purpose activity SHALL contain exactly one Act / entryRelationship / typeCode, with a value of 'RSON' 'Has reason' 2.16.840.1.113883.5.1002 ActRelationshipType STATIC, to indicate the reason or purpose for creating the CCD.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode='RSON']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship[@typeCode='RSON']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A purpose activity SHALL contain exactly one Act / entryRelationship / typeCode, with a value of 'RSON' 'Has reason' 2.16.840.1.113883.5.1002 ActRelationshipType STATIC, to indicate the reason or purpose for creating the CCD.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode='RSON']/cda:act | cda:entryRelationship[@typeCode='RSON']/cda:encounter | cda:entryRelationship[@typeCode='RSON']/cda:observation | cda:entryRelationship[@typeCode='RSON']/cda:procedure | cda:entryRelationship[@typeCode='RSON']/cda:substanceAdministration | cda:entryRelationship[@typeCode='RSON']/cda:supply"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship[@typeCode='RSON']/cda:act | cda:entryRelationship[@typeCode='RSON']/cda:encounter | cda:entryRelationship[@typeCode='RSON']/cda:observation | cda:entryRelationship[@typeCode='RSON']/cda:procedure | cda:entryRelationship[@typeCode='RSON']/cda:substanceAdministration | cda:entryRelationship[@typeCode='RSON']/cda:supply">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of Act / entryRelationship / typeCode in a purpose activity SHALL be an Act, Encounter, Observation, Procedure, SubstanceAdministration, or Supply.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]" priority="3999"
                 mode="M96">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]" priority="3999"
                 mode="M97">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]" priority="3999"
                 mode="M98">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation must be represented with the observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / moodCode" in a result observation SHALL be EVN.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHALL contain at least one Observation / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHALL contain exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHALL contain exactly one Observation / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:value)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHALL contain exactly one Observation / value</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="not(cda:referenceRange/cda:observationRange/cda:code)"/>
         <xsl:otherwise>
            <svrl:failed-assert test="not(cda:referenceRange/cda:observationRange/cda:code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHALL NOT contain Observation / referenceRange / observationRange / code, as this attribute is not used by the HL7 Clinical Statement or Lab Committee models.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M98"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]/cda:value[*:type=&#34;PQ&#34;]"
                 priority="3998"
                 mode="M98">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]/cda:value[*:type=&#34;PQ&#34;]"/>
      <xsl:choose>
         <xsl:when test="@codeSystem='2.16.840.1.113883.6.8'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@codeSystem='2.16.840.1.113883.6.8'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Where Observation / value is a physical quantity, the unit of measure SHALL be expressed using a valid UCUM expression.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]" priority="3999"
                 mode="M99">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / code” in a result observation SHOULD be selected from LOINC (codeSystem 2.16.840.1.113883.6.1) or SNOMED CT (codeSystem 2.16.840.1.113883.6.96).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHOULD contain exactly one Observation / effectiveTime, which represents the biologically relevant time (e.g. time the specimen was obtained from the patient).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:interpretationCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:interpretationCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHOULD contain exactly one Observation / interpretationCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:referenceRange"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:referenceRange">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result observation SHOULD contain one or more Observation / referenceRange to show the normal range of values for the observation result.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]" priority="3999"
                 mode="M100">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]" priority="3999"
                 mode="M101">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:organizer"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:organizer">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result organizer (templateId 2.16.840.1.113883.10.20.1.32) SHALL be represented with Organizer.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Organizer / moodCode in a result organizer SHALL be EVN.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result organizer SHALL contain at least one Organizer / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result organizer SHALL contain exactly one Organizer / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result organizer SHALL contain exactly one Organizer / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:component"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:component">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A result organizer SHALL contain one or more Organizer / component.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Each result organizers SHALL contain one or more result observations (templateId 2.16.840.1.113883.10.20.1.31).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.31']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.31']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of one or more result organizer Organizer / component relationships SHALL be a result observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]" priority="3999"
                 mode="M102">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Organizer / code in a result organizer SHOULD be selected from LOINC (codeSystem 2.16.840.1.113883.6.1) or SNOMED CT (codeSystem 2.16.840.1.113883.6.96)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]" priority="3999"
                 mode="M103">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]" priority="3999"
                 mode="M104">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A social history observation (templateId 2.16.840.1.113883.10.20.1.33) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / classCode” in a social history observation SHALL be “OBS” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in a social history observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A social history observation SHALL contain at least one Observation / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A social history observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / statusCode” in a social history observation SHALL be “completed” 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]" priority="3999"
                 mode="M105">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / code” in a social history observation SHOULD be selected from LOINC (codeSystem 2.16.840.1.113883.6.1) or SNOMED CT (codeSystem 2.16.840.1.113883.6.96).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]" priority="3999"
                 mode="M106">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]" priority="3999"
                 mode="M107">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:supply"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:supply">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A supply activity (templateId 2.16.840.1.113883.10.20.1.34) SHALL be represented with Supply.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN' or @moodCode='INT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN' or @moodCode='INT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Supply / moodCode” in a medication activity SHALL be “EVN” or “INT” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A supply activity SHALL contain at least one Supply / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M107"/>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"
                 priority="3998"
                 mode="M107">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]//*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"/>
      <xsl:choose>
         <xsl:when test="parent::*[cda:entryRelationship/@typeCode='SUBJ']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::*[cda:entryRelationship/@typeCode='SUBJ']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship between a supply activity and fulfillment instruction SHALL be “SUBJ” “Subject” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]" priority="3999"
                 mode="M108">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A supply activity SHOULD contain exactly one Supply / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:effectiveTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A supply activity SHOULD contain exactly one Supply / effectiveTime, to indicate the actual or intended time of dispensing.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]" priority="3999"
                 mode="M109">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]" priority="3999"
                 mode="M110">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]" priority="3999"
                 mode="M111">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]" priority="3999"
                 mode="M112">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]" priority="3999"
                 mode="M113">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:externalDocument"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:externalDocument">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An advance directive reference (templateId 2.16.840.1.113883.10.20.1.36) SHALL be represented with Observation / reference / ExternalDocument.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="parent::cda:reference/@typeCode='REFR'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::cda:reference/@typeCode='REFR'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / reference / typeCode in an advance directive reference SHALL be 'REFR' 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:id">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>ExternalDocument SHALL contain at least one ExternalDocument / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]" priority="3999"
                 mode="M114">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]" priority="3999"
                 mode="M115">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]" priority="3999"
                 mode="M116">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]" priority="3999"
                 mode="M117">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]" priority="3999"
                 mode="M118">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M118"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M118"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]" priority="3999"
                 mode="M119">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS'][@moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation[@classCode='OBS'][@moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An age observation (templateId 2.16.840.1.113883.10.20.1.38) SHALL be represented with Observation. The value for "Observation / classCode" in an age observation SHALL be "OBS" 2.16.840.1.113883.5.6 ActClass STATIC. The value for "Observation / moodCode" in an age observation SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code/@code='397659008'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code/@code='397659008'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / code" in an age observation SHALL be "397659008" "Age" 2.16.840.1.113883.6.96 SNOMED CT STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1 and cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1 and cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An age observation SHALL include exactly one Observation / statusCode. The value for "Observation / statusCode" in an age observation SHALL be "completed" 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:value)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An age observation SHALL include exactly one Observation / value.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M119"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M119"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]" priority="3999"
                 mode="M120">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]" priority="3999"
                 mode="M121">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M121"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M121"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]" priority="3999"
                 mode="M122">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M122"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M122"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]" priority="3999"
                 mode="M123">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]" priority="3999"
                 mode="M124">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M124"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M124"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]" priority="3999"
                 mode="M125">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A comment (templateId 2.16.840.1.113883.10.20.1.40) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='ACT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='ACT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Act / classCode” in a comment SHALL be “ACT” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Act / moodCode” in a comment SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A comment SHALL contain exactly one Act / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M125"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M125"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]" priority="3999"
                 mode="M126">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]" priority="3999"
                 mode="M127">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M127"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M127"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]" priority="3999"
                 mode="M128">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An episode observation (templateId 2.16.840.1.113883.10.20.1.41) SHALL be represented with Observation. The value for "Observation / classCode" in an episode observation SHALL be "OBS" 2.16.840.1.113883.5.6 ActClass STATIC. The value for "Observation / moodCode" in an episode observation SHALL be "EVN" 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1 and cda:statusCode/@code='completed'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1 and cda:statusCode/@code='completed'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>An episode observation SHALL include exactly one Observation / statusCode. The value for "Observation / statusCode" in an episode observation SHALL be "completed" 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M128"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M128"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]" priority="3999"
                 mode="M129">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code/@code='ASSERTION'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code/@code='ASSERTION'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "Observation / Code" in an episode observation SHOULD be "ASSERTION" 2.16.840.1.113883.5.4 ActCode STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M129"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M129"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]" priority="3999"
                 mode="M130">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M130"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M130"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]" priority="3999"
                 mode="M131">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:entryRelationship[@typeCode='CAUS']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:entryRelationship[@typeCode='CAUS']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A family history cause of death observation SHALL contain one or more entryRelationship / typeCode. The value for at least one “entryRelationship / typeCode” in a family history cause of death observation SHALL be "CAUS" "is etiology for" 2.16.840.1.113883.5.1002 ActRelationshipType STATIC, with a target family history observation of death.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M131"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M131"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]" priority="3999"
                 mode="M132">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]" priority="3999"
                 mode="M133">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M133"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M133"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]" priority="3999"
                 mode="M134">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A fulfillment instruction (templateId 2.16.840.1.113883.10.20.1.43) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='INT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='INT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Act / moodCode” in a fulfillment instruction SHALL be “INT” “Intent” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M134"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M134"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]" priority="3999"
                 mode="M135">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]" priority="3999"
                 mode="M136">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M136"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M136"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]" priority="3999"
                 mode="M137">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:participant[@typeCode='LOC']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:participant[@typeCode='LOC']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A location participation (templateId 2.16.840.1.113883.10.20.1.45) SHALL be represented with the participant participation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participantRole) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participantRole) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A location participation SHALL contain exactly one participant / participantRole.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participantRole/@code) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participantRole/@code) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Participant / participantRole in a location participation MAY contain exactly one participant / participantRole / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participantRole/@classCode = 'SDLOC'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participantRole/@classCode = 'SDLOC'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “participant / participantRole / classCode” in a location participation SHALL be “SDLOC” “Service delivery location” 2.16.840.1.113883.5.110 RoleClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participantRole/playingEntity) &lt; 2"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participantRole/playingEntity) &lt; 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Participant / participantRole in a location participation MAY contain exactly one participant / participantRole / playingEntity.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:playingEntity/@classCode = 'PLC'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:participantRole/cda:playingEntity/@classCode = 'PLC'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “participant / participantRole / playingEntity / classCode” in a location participation SHALL be “PLC” “Place” 2.16.840.1.113883.5.41 EntityClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M137"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M137"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]" priority="3999"
                 mode="M138">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]" priority="3999"
                 mode="M139">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M139"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M139"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]" priority="3999"
                 mode="M140">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]"/>
      <xsl:choose>
         <xsl:when test="ancestor::*[templateId/@root='2.16.840.1.113883.10.20.1.24'][/*[cda:entryRelationship/@typeCode='SUBJ']]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="ancestor::*[templateId/@root='2.16.840.1.113883.10.20.1.24'][/*[cda:entryRelationship/@typeCode='SUBJ']]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship between a medication activity and medication series number observation SHALL be “SUBJ” “Subject” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication series number observation (templateId 2.16.840.1.113883.10.20.1.46) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / classCode” in a medication series number observation SHALL be “OBS” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in a medication series number observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication series number observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication series number observation SHALL contain exactly one Observation / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='30973-2'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='30973-2'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / code” in a medication series number observation SHALL be “30973-2” “Dose number” 2.16.840.1.113883.6.1 LOINC STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:value)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A medication series number observation SHALL contain exactly one Observation / value.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:value[@type='INT']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:value[@type='INT']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The data type for “Observation / value” in a medication series number observation SHALL be INT (integer).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M140"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M140"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]" priority="3999"
                 mode="M141">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]" priority="3999"
                 mode="M142">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M142"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M142"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]" priority="3999"
                 mode="M143">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M143"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M143"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]" priority="3999"
                 mode="M144">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]" priority="3999"
                 mode="M145">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M145"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M145"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]" priority="3999"
                 mode="M146">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:participant[@typeCode='SBJ']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:participant[@typeCode='SBJ']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Patient awareness (templateId 2.16.840.1.113883.10.20.1.48) of a problem, observation, or other clinical statement SHALL be represented with participant. The value for “participant / typeCode” in a patient awareness SHALL be “SBJ” “Subject” 2.16.840.1.113883.5.90 ParticipationType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:awarenessCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:awarenessCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Patient awareness SHALL contain exactly one participant / awarenessCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participantRole/cda:id)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participantRole/cda:id)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Patient awareness SHALL contain exactly one participant / participantRole / id</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="/cda:ClinicalDocument/cda:recordTarget/cda:patientRole//cda:id[@root=cda:participantRole/cda:id/@root]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="/cda:ClinicalDocument/cda:recordTarget/cda:patientRole//cda:id[@root=cda:participantRole/cda:id/@root]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>(The value of the participant/participantRole/id) SHALL also be present in ClinicalDocument / recordTarget / patientRole / id.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M146"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M146"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]" priority="3999"
                 mode="M147">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]" priority="3999"
                 mode="M148">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M148"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M148"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]" priority="3999"
                 mode="M149">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:act"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:act">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A patient instruction (templateId 2.16.840.1.113883.10.20.1.49) SHALL be represented with Act.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='INT'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='INT'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Act / moodCode” in a patient instruction SHALL be “INT” “Intent” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="parent::*[cda:entryRelationship/@typeCode='SUBJ']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::*[cda:entryRelationship/@typeCode='SUBJ']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship to a patient instruction SHALL be “SUBJ” “Subject” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M149"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M149"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]" priority="3999"
                 mode="M150">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]" priority="3999"
                 mode="M151">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M151"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M151"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]" priority="3999"
                 mode="M152">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code/@code='11323-3'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code/@code='11323-3'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>... the value for "Observation / code" in a problem healthstatus observation SHALL be "11323-3" "Health status" 2.16.840.1.113883.6.1 LOINC STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M152"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M152"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]" priority="3999"
                 mode="M153">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]" priority="3999"
                 mode="M154">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M154"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M154"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]" priority="3999"
                 mode="M155">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M155"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M155"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]" priority="3999"
                 mode="M156">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M156"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M156"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]" priority="3999"
                 mode="M157">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M157"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M157"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]" priority="3999"
                 mode="M158">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M158"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M158"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]" priority="3999"
                 mode="M159">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M159"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M159"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]" priority="3999"
                 mode="M160">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M160"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M160"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]" priority="3999"
                 mode="M161">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:participantRole"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:participantRole">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A product instance (templateId 2.16.840.1.113883.10.20.1.52) SHALL be represented with the ParticipantRole class.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='MANU'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='MANU'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for "participantRole / classCode" in a product instance SHALL be "MANU" "Manufactured product" 2.16.840.1.113883.5.110 RoleClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M161"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M161"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]/cda:id"
                 priority="3999"
                 mode="M162">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]/cda:id"/>
      <xsl:choose>
         <xsl:when test="cda:scopingEntity"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:scopingEntity">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>If participantRole in a product instance contains participantRole / id, then participantRole SHOULD also contain participantRole / scopingEntity.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M162"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M162"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]" priority="3999"
                 mode="M163">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M163"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M163"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]" priority="3999"
                 mode="M164">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A reaction observation (templateId 2.16.840.1.113883.10.20.1.54) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / classCode” in a reaction observation SHALL be “OBS” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in a reaction observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A reaction observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / statusCode” in a reaction observation SHALL be “completed” 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M164"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M164"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]" priority="3999"
                 mode="M165">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M165"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M165"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]" priority="3999"
                 mode="M166">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M166"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M166"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]" priority="3999"
                 mode="M167">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A severity observation (templateId 2.16.840.1.113883.10.20.1.55) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="ancestor::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.55' ][//*[cda:entryRelationship/@typeCode='SUBJ']]"/>
         <xsl:otherwise>
            <svrl:failed-assert test="ancestor::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.55' ][//*[cda:entryRelationship/@typeCode='SUBJ']]">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “entryRelationship / typeCode” in a relationship between a reaction observation and severity observation SHALL be “SUBJ” “Has subject” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / classCode” in a severity observation SHALL be “OBS” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in a severity observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A severity observation SHALL include exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / statusCode” in a severity observation SHALL be “completed” 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A severity observation SHALL contain exactly one Observation / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='SEV']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='SEV']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / code” in a severity observation SHALL be “SEV” “Severity observation” 2.16.840.1.113883.5.4 ActCode STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:value)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:value)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A severity observation SHALL contain exactly one Observation / value.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M167"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M167"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]" priority="3999"
                 mode="M168">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M168"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M168"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]" priority="3999"
                 mode="M169">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M169"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M169"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]" priority="3999"
                 mode="M170">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M170"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M170"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]" priority="3999"
                 mode="M171">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M171"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M171"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]" priority="3999"
                 mode="M172">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M172"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M172"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]" priority="3999"
                 mode="M173">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:observation"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:observation">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation (templateId 2.16.840.1.113883.10.20.1.57) SHALL be represented with Observation.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="parent::*[cda:entryRelationship/@typeCode='REFR']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="parent::*[cda:entryRelationship/@typeCode='REFR']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation SHALL be the target of an entryRelationship whos value for “entryRelationship / typeCode” SHALL be “REFR” 2.16.840.1.113883.5.1002 ActRelationshipType STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@classCode='OBS'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@classCode='OBS'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / classCode” in a status observation SHALL be “OBS” 2.16.840.1.113883.5.6 ActClass STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@moodCode='EVN'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@moodCode='EVN'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / moodCode” in a status observation SHALL be “EVN” 2.16.840.1.113883.5.1001 ActMood STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:code)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:code)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation SHALL contain exactly one Observation / code.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:code[@code='33999-4'][@codeSystem='2.16.840.1.113883.6.1']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:code[@code='33999-4'][@codeSystem='2.16.840.1.113883.6.1']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / code” in a status observation SHALL be “33999-4” “Status” 2.16.840.1.113883.6.1 LOINC STATIC</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:statusCode)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation SHALL contain exactly one Observation / statusCode.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="cda:statusCode[@code='completed']"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:statusCode[@code='completed']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for “Observation / statusCode” in a status observation SHALL be “completed” 2.16.840.1.113883.5.14 ActStatus STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="(count(@*)=2) and @classCode and @moodCode"/>
         <xsl:otherwise>
            <svrl:failed-assert test="(count(@*)=2) and @classCode and @moodCode">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation SHALL NOT contain any additional Observation attributes.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="count(cda:participant)=0"/>
         <xsl:otherwise>
            <svrl:failed-assert test="count(cda:participant)=0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A status observation SHALL NOT contain any Observation participants.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M173"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M173"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]" priority="3999"
                 mode="M174">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M174"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M174"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]" priority="3999"
                 mode="M175">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M175"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M175"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]" priority="3999"
                 mode="M176">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M176"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M176"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]" priority="3999"
                 mode="M177">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M177"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M177"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]" priority="3999"
                 mode="M178">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M178"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M178"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]" priority="3999"
                 mode="M179">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]"/>
      <xsl:choose>
         <xsl:when test="self::cda:participant"/>
         <xsl:otherwise>
            <svrl:failed-assert test="self::cda:participant">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A verification of an advance directive observation (templateId 2.16.840.1.113883.10.20.1.58) SHALL be represented with Observation / participant.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="@typeCode='VRF'"/>
         <xsl:otherwise>
            <svrl:failed-assert test="@typeCode='VRF'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The value for Observation / participant / typeCode in a verification SHALL be 'VRF' 'Verifier' 2.16.840.1.113883.5.90 ParticipationType STATIC.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M179"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M179"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]" priority="3999"
                 mode="M180">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:time"/>
         <xsl:otherwise>
            <svrl:failed-assert test="cda:time">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A verification of an advance directive observation SHOULD contain Observation / participant / time.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="M180"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M180"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]" priority="3999"
                 mode="M181">
      <svrl:fired-rule context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M181"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M181"/>
   <xsl:template match="text()" priority="-1"/>
</xsl:stylesheet>