<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:param name="mediaBase">G419 - </xsl:param>
	<!--Voir pour production nomanclature du doc-->
	<xsl:param name="mediaPath" select="concat('./',$mediaBase,'Images/')"/>
	<xsl:param name="imgExtension">.png</xsl:param>
	<xsl:template name="imgPathCreator">
		<xsl:param name="imgPosition" select="count(preceding::graphic)+1"/>
		<xsl:value-of select="$mediaPath"/>
		<xsl:value-of select="$mediaBase"/>
		<xsl:choose>
			<xsl:when test="$imgPosition &lt; 10">Fig. 00</xsl:when>
			<xsl:when test="$imgPosition &gt;= 10 and $imgPosition &lt; 100">Fig. 0</xsl:when>
			<xsl:otherwise>Fig. </xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$imgPosition"/>
		<xsl:value-of select="$imgExtension"/>
	</xsl:template>
	<xsl:include href="./libToc.xslt"/>
	<xsl:template name="header">
		<div class="header">
			<div class="header-top">
				<div class="header-logo">
					<img alt="logo OMC" src="{$mediaPath}logo.png"/>
					<br/>
					<div class="publisher-id">(<xsl:value-of select="/book/book-meta/book-id[@book-id-type='publisher-id']"/>)</div>
				</div>
				<div class="header-meta">
					<xsl:if test="/book/book-meta/custom-meta-group/custom-meta[@id='Restricted' and meta-value='True']">
						<div class="header-restricted">
							<xsl:value-of select="/book/book-meta/custom-meta-group/custom-meta[@id='Restricted' and meta-value='True']/meta-name"/>
						</div>
					</xsl:if>
					<xsl:for-each select="/book/book-meta/custom-meta-group/custom-meta[meta-name='Symbol']">
						<div class="header-symbol">
							<xsl:value-of select="meta-value"/>
						</div>
					</xsl:for-each>
					<div class="header-date">
						<xsl:value-of select="/book/book-meta/pub-date/day"/>
						<xsl:call-template name="monthStringFromNumber"/>
						<xsl:value-of select="/book/book-meta/pub-date/year"/>
					</div>
				</div>
			</div>
			<div class="header-bottom"/>
		</div>
	</xsl:template>
	<xsl:template name="monthStringFromNumber">
		<!--template format mois EN-->
		<xsl:param name="monthNumber" select="/book/book-meta/pub-date/month"/>
		<xsl:choose>
			<xsl:when test="$monthNumber=1"> January </xsl:when>
			<xsl:when test="$monthNumber=10"> October </xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="cssContent">
	h2,h3,h4,h5,h6 {color:#006283;}
	.alpha-lower {list-style-type:lower-alpha;}
	.alpha-upper {list-style-type:upper-alpha;}
	.roman-lower {list-style-type:lower-roman;}
	.roman-upper {list-style-type:upper-roman;}
	thead tr td {color: white;}
	table {	width: 90%;
			margin-left:5%;
			border:1px solid black;
			border-spacing:0;
			border-collapse:collapse;}
	tbody tr td:nth-child(odd) {background-color: #91A9A7;}
	td {border-left:1px solid black;}
	.header-top {display:flex;
				width:100%;}
	.header-logo {flex-grow:1;}
	</xsl:template>
	<xsl:template name="sec-title">
		<xsl:variable name="seclevel" select="count(ancestor-or-self::sec)"/>
		<xsl:element name="h{$seclevel+1}">
			<xsl:attribute name="id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
			<xsl:value-of select="label"/>. 
		<xsl:value-of select="title"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="sec">
		<xsl:call-template name="sec-title"/>
		<xsl:apply-templates select="*[name()!='label'and name()!='title' ]"/>
	</xsl:template>
	<xsl:template match="p">
		<p>
			<xsl:apply-templates select="text()|*"/>
		</p>
	</xsl:template>
	<xsl:template match="ext-link">
		<a href="{@xlink:href}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="list">
		<ol class="{@list-type}">
			<xsl:apply-templates select="list-item"/>
		</ol>
	</xsl:template>
	<xsl:template match="list-item">
		<li>
			<xsl:apply-templates select="p|list"/>
		</li>
	</xsl:template>
	<xsl:template match="table-wrap">
		<h3>
			<xsl:value-of select="label"/>: <xsl:value-of select="caption/title"/>
		</h3>
		<xsl:apply-templates select="table"/>
	</xsl:template>
	<xsl:template match="table">
		<table id="{../@id}">
			<xsl:copy-of select="thead|tbody|tfoot|tr"/>
		</table>
	</xsl:template>
	<xsl:template match="fig">
		<h3 id="{@id}">
			<xsl:value-of select="label"/>
			<xsl:value-of select="title"/>
		</h3>
		<xsl:apply-templates select="*[name()!='label'and name()!='title' ]"/>
	</xsl:template>
	<xsl:template match="graphic">
		<xsl:variable name="src">
			<xsl:call-template name="imgPathCreator"/>
		</xsl:variable>
		<img alt="{../label}" src="{$src}"/>
	</xsl:template>
</xsl:stylesheet>
