<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="tocTPRS">
		<xsl:if test="/book/book-meta/book-title-group/book-title[text()='TRADE POLICY REVIEW'] and /book/book-meta/book-title-group/subtitle[text()='REPORT BY THE SECRETARIAT']"/>
	</xsl:param>
	<xsl:template match="sec" mode="toc">
		<xsl:choose>
			<xsl:when test="sec[@id]">
				<xsl:choose>
					<xsl:when test="count(ancestor::sec) &lt; 1">
						<dt>
							<xsl:if test="//sec/sec[@id]">
								<a href="#{@id}">
						<xsl:value-of select="label"/>. <xsl:value-of select="title"/>
					</a>
							</xsl:if>
							<xsl:if test="//sec [not(@id)]/title">
								<a href="#{title}">
									<xsl:value-of select="text()"/>
								</a>
							</xsl:if>
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
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count(ancestor::sec) &lt; 1">
						<dt>
							<xsl:if test="//sec/sec[@id]">
								<a href="#{@id}">
									<xsl:value-of select="label"/>
									<xsl:value-of select="title"/>
								</a>
							</xsl:if>
							<xsl:if test="//sec [not(@id)]/title">
								<a href="#{title}">
									<xsl:value-of select="text()"/>
								</a>
							</xsl:if>
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
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="toc">
		<h2 style="color:black;">Contents</h2>
		<dl>
			<xsl:apply-templates mode="toc" select="//sec"/>
		</dl>
	</xsl:template>
	<xsl:template match="fig[@fig-type='chart']" mode="toc">
		<!--test condition-->
		<!--<xsl:choose>
			<xsl:when test="$tocTPRS = true()">-->
		<xsl:choose>
			<xsl:when test="count(ancestor::fig) &lt; 1">
				<dt>
					<a href="#{@id}">
						<xsl:value-of select="label"/>: <xsl:value-of select="caption/p"/>
					</a>
				</dt>
			</xsl:when>
			<xsl:otherwise>
				<dd>
					<a href="#{@id}">
						<xsl:value-of select="label"/>: <xsl:value-of select="caption/p"/>
					</a>
				</dd>
			</xsl:otherwise>
		</xsl:choose>
		<!--</xsl:when>
		<xsl:otherwise></xsl:otherwise>
		</xsl:choose>-->
	</xsl:template>
	<xsl:template name="tocChart">
		<h2 style="color:black;">Chart</h2>
		<dl>
			<xsl:apply-templates mode="toc" select="//fig[@fig-type='chart']"/>
		</dl>
	</xsl:template>
	<xsl:template match="table-wrap" mode="toc">
		<xsl:choose>
			<xsl:when test="count(ancestor::table-wrap) &lt; 1">
				<dt>
					<a href="#{@id}">
						<xsl:value-of select="label"/>: <xsl:value-of select="caption/title"/>
					</a>
				</dt>
			</xsl:when>
			<xsl:otherwise>
				<dd>
					<a href="#{@id}">
						<xsl:value-of select="label"/>: <xsl:value-of select="caption/title"/>
					</a>
				</dd>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="tocTable">
		<h2 style="color:black;">Table</h2>
		<dl>
			<xsl:apply-templates mode="toc" select="/book/book-body/book-part[2]/body/sec[@id]//table-wrap"/>
		</dl>
	</xsl:template>
	<xsl:template name="tocTableAppendix">
		<h2 style="color:black;">Appendix Table</h2>
		<dl>
			<xsl:apply-templates mode="toc" select="/book/book-body/book-part[2]/body/sec[last()]//table-wrap"/>
		</dl>
	</xsl:template>
</xsl:stylesheet>