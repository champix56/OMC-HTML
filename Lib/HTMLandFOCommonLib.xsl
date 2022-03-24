<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="monthStringFromNumber">
		<!--template format mois EN-->
		<xsl:param name="monthNumber" select="/book/book-meta/pub-date/month"/>
		<xsl:choose>
			<xsl:when test="$monthNumber=1"> January </xsl:when>
			<xsl:when test="$monthNumber=2"> February </xsl:when>
			<xsl:when test="$monthNumber=3"> March </xsl:when>
			<xsl:when test="$monthNumber=4"> April </xsl:when>
			<xsl:when test="$monthNumber=5"> May </xsl:when>
			<xsl:when test="$monthNumber=6"> June </xsl:when>
			<xsl:when test="$monthNumber=7"> July </xsl:when>
			<xsl:when test="$monthNumber=8"> August </xsl:when>
			<xsl:when test="$monthNumber=9"> September </xsl:when>
			<xsl:when test="$monthNumber=10"> October </xsl:when>
			<xsl:when test="$monthNumber=11"> November </xsl:when>
			<xsl:when test="$monthNumber=12"> December </xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
