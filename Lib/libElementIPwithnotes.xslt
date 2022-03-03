<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:param name="mediaBase">M103 - </xsl:param>
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
			<div class="header-bottom">
				<div class="header-bottom-left uppercase">
					<xsl:value-of select="/book/book-meta//custom-meta[@id='Bodies']/meta-value"/>
				</div>
				<div class="header-bottom-right">
					<xsl:for-each select="/book/book-meta//custom-meta[contains(@id,'OriginalLanguage')]">
						<div class="header-language">Original: <xsl:value-of select="meta-value"/>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template name="title">
		<h1 class="center">
			<xsl:value-of select="/book/book-meta/book-title-group/book-title"/>
		</h1>
		<h2 class="center">
			<xsl:value-of select="/book/book-meta/book-title-group/subtitle"/>
		</h2>
		<h3 class="center">
			<xsl:value-of select="/book/book-meta//custom-meta[@id='DocCountry']/meta-value"/>
		</h3>
		<xsl:apply-templates select="/book/front-matter/front-matter-part/named-book-part-body/p"/>
	</xsl:template>
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
	<xsl:template name="cssContent">
	body {padding:7em;}
	h1,h2,h3,h4,h5,h6 {color:#006283;}
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
				width:100%;
				border-bottom:1px solid black;}
	.header-bottom {display:flex;
				width:100%;}			
	.header-logo, .header-bottom-left {flex-grow:1;}
	.header-logo img {max-width:calc(100vw - 150px);min-width:70px;}
	.publisher-id {color:red;}
	.header-restricted {color:red;
				font-weight:700;
				text-transform:uppercase;}
	.header-symbol {font-weight:700}
	.uppercase {text-transform:uppercase;}
	.center {text-align:center;}
						
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
			<xsl:apply-templates select="text()|*[name()!='fn']"/>
		</p>
	</xsl:template>
	<!--	test notes de bas de page-->
	<xsl:template match="xref">
		<sup id="fntext-{@rid} ">
			<a href="#{@rid}" type="ref-type={@ref-type}">
				<xsl:value-of select="."/>
			</a>
		</sup>
	</xsl:template>
	<!--<xsl:template name="footnotes">-->
	<xsl:template match="fn">
			<li id="{@id}" class="note-list">
				<span class="reference-text">
					<xsl:value-of select="label"/>
					<xsl:value-of select="p"/>
					<a href="#fntext-1" class="small">
						<i class="icon-back-to-top"/> Back to text</a>
				</span>
			</li>
	</xsl:template>
	<!--</xsl:template>-->
	<!--	xml

<p>2.1.  	The <underline>Chair</underline> recalled treaties<xref rid="fn1" ref-type="fn"><sup>1</sup></xref>

<fn id="fn1"><label>1</label> <p> Samoa has acceded to the WIPO Madrid Agreement and Protocol in 2018.</p></fn>
, before commencing the review. He proposed that the Secretariat.</p>-->
	<!--creation du renvoi html
<sup id="fntext-1"><a href="#fnt-1">(1)</a></sup>-->
	<!--creation de la partie note html
<h3>Notes</h3>

	<ol class="footnote-list">
       <li id="fnt-1" class="">
              <span class="reference-text">The waivers covered by this provision are listed in footnote 7.</span>
              <a href="#fntext-1" class="small"><i class="icon-back-to-top"></i> Back to text</a>
        </li>
</ol>-->
	<xsl:template match="ext-link">
		<a href="{@xlink:href}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<xsl:template match="email">
		<a href="mailto:{@xlink:href}">
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
