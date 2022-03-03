<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:include href="lib/libElementIPwithnotes.xslt"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="/book/collection-meta/title-group/title"/>
					<xsl:for-each select="//custom-meta[meta-name='Symbol']/meta-value">, <xsl:value-of select="."/>
					</xsl:for-each>
				</title>
				<style type="text/css">
					<xsl:call-template name="cssContent"/>
				</style>
			</head>
			<xsl:apply-templates select="/book"/>
		</html>
	</xsl:template>
	<xsl:template match="/book[book-body]">
		<body>
			<xsl:call-template name="header"/>
			<xsl:call-template name="title"/>
			<xsl:call-template name="toc"/>
			<xsl:apply-templates select="//body/sec"/>
		</body>
		<footer>
			<xsl:call-template name="notes"/>
		</footer>
	</xsl:template>
	<xsl:template match="/book[not(book-body)]">
		<body>
			<xsl:call-template name="header"/>
			<xsl:call-template name="title"/>
		</body>
	</xsl:template>
</xsl:stylesheet>
