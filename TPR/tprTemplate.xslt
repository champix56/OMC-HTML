<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:include href="../lib/libElement.xslt"/>
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
			<body>
				<xsl:call-template name="header"/>
				<xsl:call-template name="title"/>
				<xsl:call-template name="toc"/>
				<xsl:apply-templates select="//body/sec"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
