<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="sec" mode="toc">
		<xsl:choose>
			<xsl:when test="count(ancestor::sec) &lt; 1">
				<dt>
					<a href="#{@id}">
						<xsl:value-of select="label"/>. <xsl:value-of select="title"/>
					</a>
				</dt>
			</xsl:when>
			<xsl:otherwise>
				<dd>
					<a href="#{@id}">
						<xsl:value-of select="label"/>. <xsl:value-of select="title"/>
					</a>
				</dd>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="toc">
		<h2 style="color:black;">Contents</h2>
		<dl>
			<xsl:apply-templates mode="toc" select="//sec"/>
		</dl>
	</xsl:template>
</xsl:stylesheet>
