<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:umls="xalan://org.projectlaika.validator.codesystem.XSLTValidator"
                xmlns:cda="urn:hl7-org:v3"
                extension-element-prefixes="umls"
                version="1.0">
       
  <xsl:template match="//*[@codeSystem and @code]">
 
   <c>
        <xsl:text> is code system </xsl:text> 
        <xsl:value-of select="@codeSystem"/> 
        <xsl:text>with code </xsl:text>
        <xsl:value-of select="@code"/>       
       <xsl:text> valid ?</xsl:text>
        
    </c>
  </xsl:template>
 
</xsl:stylesheet>