<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:sch="http://www.ascc.net/xml/schematron"
                xmlns:cda="urn:hl7-org:v3"
                version="1.0"
                cda:dummy-for-xmlns="">
   <xsl:output xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:iso="http://purl.oclc.org/dsdl/schematron"
               xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>
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
      <svrl:schematron-output xmlns:xs="http://www.w3.org/2001/XMLSchema"
                              xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                              xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Schematron schema for validating conformance to CCD documents"
                              schemaVersion="">
         <xsl:attribute name="phase">warning</xsl:attribute>
         <marker/>
         <svrl:ns-prefix-in-attribute-values uri="urn:hl7-org:v3" prefix="cda"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.1-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.2-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.3-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.4-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.5-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.6-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.7-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.8-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.9-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.10-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.11-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.12-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.13-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.14-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.15-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.16-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.17-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.18-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.19-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.20-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.21-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.22-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.23-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.24-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.25-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.26-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.27-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.28-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.29-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.30-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.31-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.32-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.33-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M105"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.34-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M108"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.35-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M111"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.36-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M114"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.37-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M117"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.38-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M120"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.39-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M123"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.40-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M126"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.41-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M129"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.42-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M132"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.43-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M135"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.45-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M138"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.46-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M141"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.47-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M144"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.48-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M147"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.49-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M150"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.51-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M153"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.50-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M156"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.53-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M159"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.52-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M162"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.54-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M165"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.55-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M168"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.56-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M171"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.57-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M174"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.44-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M177"/>
         <svrl:active-pattern>
            <xsl:attribute name="id">p-2.16.840.1.113883.10.20.1.58-warning</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M180"/>
      </svrl:schematron-output>
   </xsl:template>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]" priority="3999"
                 mode="M6">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]" priority="3999"
                 mode="M9">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.1&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]/cda:code[@code=&#34;304251008&#34;][@codeSystem=&#34;2.16.840.1.113883.6.96&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'advance directives')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]" priority="3999"
                 mode="M12">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.2&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'alert') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'allergies and adverse reactions')">
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
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root='2.16.840.1.113883.10.20.1.27'][ancestor::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.2']]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.18']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.18']">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]" priority="3999"
                 mode="M15">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.3&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.21']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.21']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'encounters')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]" priority="3999"
                 mode="M18">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.4&#34;]"/>
      <xsl:choose>
         <xsl:when test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'family history')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'family history')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]" priority="3999"
                 mode="M21">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.5&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;] | descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;] | descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'functional status')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]" priority="3999"
                 mode="M24">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.6&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]|descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]|descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'immunization')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]" priority="3999"
                 mode="M27">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.7&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'equipment')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]" priority="3999"
                 mode="M30">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.8&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.24' or cda:templateId/@root='2.16.840.1.113883.10.20.1.34' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.24' or cda:templateId/@root='2.16.840.1.113883.10.20.1.34' ]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'medication')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]" priority="3999"
                 mode="M33">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.9&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'insurance') or contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'payers')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]" priority="3999"
                 mode="M36">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.10&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.25']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.25']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'plan')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]" priority="3999"
                 mode="M39">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.11&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.27']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.27']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'problem')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>Section / title SHOULD be valued with a case-insensitive language-insensitive text string containing “problem”.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]" priority="3999"
                 mode="M42">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.12&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.29']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.29']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'procedures')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]" priority="3999"
                 mode="M45">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.13&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'purpose')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]" priority="3999"
                 mode="M48">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.14&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=".//cda:templateId[@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'results')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]" priority="3999"
                 mode="M51">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.15&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.33']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root='2.16.840.1.113883.10.20.1.33']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'social history')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]" priority="3999"
                 mode="M54">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.16&#34;]"/>
      <xsl:choose>
         <xsl:when test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="descendant::*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="contains(translate(cda:title,'QWERTYUIOPASDFGHJKLZXCVBNM','qwertyuiopasdfghjklzxcvbnm'),'vital signs')">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]" priority="3999"
                 mode="M57">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.17&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]" priority="3999"
                 mode="M60">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.18&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participant"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:participant">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:participant/cda:participantRole/cda:playingEntity/cda:code[@codeSystem='2.16.840.1.113883.6.88' or @codeSystem='2.16.840.1.113883.6.59' ]">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]" priority="3999"
                 mode="M63">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.19&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]" priority="3999"
                 mode="M66">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.20&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]" priority="3999"
                 mode="M69">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.21&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:code) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:code) = 1">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]" priority="3999"
                 mode="M72">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.22&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:effectiveTime"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:effectiveTime">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]" priority="3999"
                 mode="M75">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.23&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:component[cda:observation/cda:templateId/@root='2.16.840.1.113883.10.20.1.22']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:component[cda:observation/cda:templateId/@root='2.16.840.1.113883.10.20.1.22']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:subject/cda:relatedSubject/cda:subject)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:subject/cda:relatedSubject/cda:subject/cda:administrativeGenderCode)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:subject/cda:relatedSubject/cda:subject/cda:birthTime)=1">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]" priority="3999"
                 mode="M78">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.24&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:statusCode)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:effectiveTime">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:routeCode)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:doseQuantity)=1">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]" priority="3999"
                 mode="M81">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.25&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]" priority="3999"
                 mode="M84">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code">
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
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;COV&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:participantRole/cda:id">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:participantRole/cda:code">
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
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.26&#34;]/cda:participant[@typeCode=&#34;HLD&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:participantRole/cda:id"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:participantRole/cda:id">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]" priority="3999"
                 mode="M87">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.27&#34;]"/>
      <xsl:choose>
         <xsl:when test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.28']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test=".//cda:templateId[@root='2.16.840.1.113883.10.20.1.28']">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.28'] or cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.18']">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>The target of a problem act with Act / entryRelationship / @typeCode=”SUBJ” SHOULD be a problem observation (in the Problem section) or alert observation (in the Alert section, see section 3.9 Alerts), but MAY be some other clinical statement.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]" priority="3999"
                 mode="M90">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.28&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:effectiveTime)=1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-get-full-path"/>
               </xsl:attribute>
               <svrl:text>A problem observation SHOULD contain exactly one Observation / effectiveTime, to indicate the timing of condition (e.g. the time the condition started, the onset of the illness or symptom).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]" priority="3999"
                 mode="M93">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.29&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:effectiveTime)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:effectiveTime)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]" priority="3999"
                 mode="M96">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.30&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]" priority="3999"
                 mode="M99">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.31&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:effectiveTime)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:interpretationCode)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:referenceRange">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]" priority="3999"
                 mode="M102">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.32&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96']">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]" priority="3999"
                 mode="M105">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.33&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.96' ]">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]" priority="3999"
                 mode="M108">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.34&#34;]"/>
      <xsl:choose>
         <xsl:when test="count(cda:statusCode)=1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:statusCode)=1">
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
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cda:effectiveTime)=1">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]" priority="3999"
                 mode="M111">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.35&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]" priority="3999"
                 mode="M114">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.36&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]" priority="3999"
                 mode="M117">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.37&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]" priority="3999"
                 mode="M120">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.38&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]" priority="3999"
                 mode="M123">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.39&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]" priority="3999"
                 mode="M126">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.40&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]" priority="3999"
                 mode="M129">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.41&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:code/@code='ASSERTION'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:code/@code='ASSERTION'">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]" priority="3999"
                 mode="M132">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.42&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]" priority="3999"
                 mode="M135">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.43&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]" priority="3999"
                 mode="M138">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.45&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]" priority="3999"
                 mode="M141">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.46&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]" priority="3999"
                 mode="M144">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.47&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]" priority="3999"
                 mode="M147">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.48&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]" priority="3999"
                 mode="M150">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.49&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]" priority="3999"
                 mode="M153">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.51&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]" priority="3999"
                 mode="M156">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.50&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M156"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M156"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]" priority="3999"
                 mode="M159">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.53&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M159"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M159"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]/cda:id"
                 priority="3999"
                 mode="M162">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.52&#34;]/cda:id"/>
      <xsl:choose>
         <xsl:when test="cda:scopingEntity"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:scopingEntity">
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
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]" priority="3999"
                 mode="M165">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.54&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M165"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M165"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]" priority="3999"
                 mode="M168">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.55&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M168"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M168"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]" priority="3999"
                 mode="M171">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.56&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M171"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M171"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]" priority="3999"
                 mode="M174">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.57&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M174"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M174"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]" priority="3999"
                 mode="M177">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.44&#34;]"/>
      <xsl:if test=".">
         <svrl:successful-report xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                 xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                 test=".">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-get-full-path"/>
            </xsl:attribute>
            <svrl:text/>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates mode="M177"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M177"/>
   <xsl:template match="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]" priority="3999"
                 mode="M180">
      <svrl:fired-rule xmlns:xs="http://www.w3.org/2001/XMLSchema"
                       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                       xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="*[cda:templateId/@root=&#34;2.16.840.1.113883.10.20.1.58&#34;]"/>
      <xsl:choose>
         <xsl:when test="cda:time"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:xs="http://www.w3.org/2001/XMLSchema"
                                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                                xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="cda:time">
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
   <xsl:template match="text()" priority="-1"/>
</xsl:stylesheet>