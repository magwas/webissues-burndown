<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>


	<xsl:template match="/">
		<xsl:result-document href="changes.csv">
			<xsl:call-template name="writecsv">
				<xsl:with-param name="set" select="/pma_xml_export/database/table[@name='changes']"/>
			</xsl:call-template>
		</xsl:result-document>
		<xsl:result-document href="stamps.csv">
			<xsl:call-template name="writecsv">
				<xsl:with-param name="set" select="/pma_xml_export/database/table[@name='stamps']"/>
			</xsl:call-template>
		</xsl:result-document>
	</xsl:template>

	<xsl:template name="writecsv">
		<xsl:param name="set"/>
		<xsl:for-each select="$set">
			<xsl:variable name="cols">
				<xsl:for-each select="column">
					<item><xsl:value-of select="replace(replace(normalize-space(.),'''','&quot;'),',',';')"/></item>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="string-join($cols/item,',')"/><xsl:text>
</xsl:text>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>

