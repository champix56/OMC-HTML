<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:include href="./HTMLandFOCommonLib.xsl"/>
	<xsl:include href="./libToc.xslt"/>
	<!--Modification manuelle du nom de repertoire dans troncature-->
	<xsl:param name="mediaBase">S418 - </xsl:param>
	<!--Modification automatique du nom de repertoire dans troncature-->
	<!--<xsl:param name="mediaBase">
		<xsl:value-of select="//book-id[@book-id-type='publisher-id']"/>
	</xsl:param>
	<xsl:param name="serialNumber">
		<xsl:value-of select="/book/book-meta/book-id[@book-id-type='publisher-id']/text()"/>
	</xsl:param>-->
	<xsl:param name="bookMetaSubject">
		<xsl:for-each select="/book/book-meta/subj-group[@subj-group-type='report-type']">
			<xsl:value-of select="subject"/>
		</xsl:for-each>
	</xsl:param>
	<!--Voir pour production nomanclature du doc-->
	<xsl:param name="mediaPath" select="concat('./',$mediaBase,'Images/')"/>
	<xsl:param name="imgExtension">.png</xsl:param>
	<xsl:template name="imgPathCreator">
		<xsl:param name="imgPosition" select="count(preceding::fig)+1"/>
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
	<xsl:template name="header">
		<div class="header">
			<div class="header-top">
				<div class="header-logo">
					<!--<img alt="logo OMC" src="{$mediaPath}logo.png"/>-->
					<img alt="logo OMC" src="../Lib/Images/logo.png"/>
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
		<!--<h2 class="center">
			<xsl:value-of select="/book/book-meta/book-title-group/subtitle"/>
		</h2>-->
		<xsl:for-each select="/book/book-meta/book-title-group/subtitle">
			<h2 class="center">
				<xsl:value-of select="."/>
			</h2>
		</xsl:for-each>
		<h3 class="center">
			<xsl:value-of select="/book/book-meta//custom-meta[@id='DocCountry']/meta-value"/>
		</h3>
		<h3 class="center">
			<xsl:value-of select="//subj-group[@subj-group-type='report-date-range']//subject"/>
		</h3>
		<h3 class="center">
			<xsl:value-of select="//contrib-group"/>
		</h3>
		<xsl:apply-templates select="/book/front-matter/front-matter-part/named-book-part-body/p"/>
	</xsl:template>
	<xsl:template name="summary">
		<xsl:if test="/book/front-matter//front-matter-part/named-book-part-body/sec">
			<div class="sum">
				<h1 id="#{title}">
					<!--<xsl:value-of select="//front-matter/front-matter-part[@book-part-type]/book-part-meta/title-group/title"/>-->
					<xsl:value-of select="/book/front-matter/front-matter-part[2]/named-book-part-body//title"/>
				</h1>
				<xsl:for-each select="/book/front-matter/front-matter-part[2]/named-book-part-body//p">
					<p>
						<xsl:value-of select="."/>
					</p>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cssContent">
	body {	padding:7em;
			text-align: justify;
			<!--font-weight:900;-->
			font-size:14pt;
			font-family: Verdana;}<!--ajustement mise en page-->
			
	h1,h2,h3,h4,h5,h6 {color:#006283;}
	h1 {font-size:27px !important;
		font-family: museo sans 700;}
	h2 {font-size:20px !important;
		font-family: museo sans 700;}
	h3 {font-size:17px !important;
		font-family: museo sans 700;}
	h4 {font-size:14PX !important;
		font-family: museo sans 300;}
	h5 {font-size:0.9em !important;
		font-family: museo sans 300;}
	h6 {font-size:0;8em !important;
		font-family: museo sans 300;}
	<!--h1 {font-size:2,07em !important;
		font-family: museo sans 700;}
	h2 {font-size:1,42em !important;
		font-family: museo sans 700;}
	h3 {font-size:1,21em !important;
		font-family: museo sans 700;}
	h4 {font-size:1em !important;
		font-family: museo sans 300;}
	h5 {font-size:0.9em !important;
		font-family: museo sans 300;}
	h6 {font-size:0;8em !important;
		font-family: museo sans 300;}-->	
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
	table td {padding:10px;}
	<!--tbody tr td:nth-child(even) {background-color: #91A9A7;}-->
	td {border-left:1px solid black;}
	.header-top {	display:flex;
					width:100%;
					border-bottom:1px solid black;}
	.header-bottom {	display:flex;
					width:100%;}			
	.header-logo, .header-bottom-left {flex-grow:1;}
	.header-logo img {	max-width:calc(100vw - 150px);
						min-width:70px;
						margin-top: -50px;
						margin-left: -25px;
						margin-bottom: 5px;}
	.publisher-id {color:red;}
	.header-restricted {	color:red;
						font-weight:700;
						text-transform:uppercase;}
	.header-symbol {font-weight:700;}
	.header-date {margin-top:30px;}
	.uppercase {text-transform:uppercase;}
	.center {text-align:center;}
	a[href="#top"], .backToTop {float: right;
    margin-top: 0 !important;
    font-size: 10.5px !important;
    font-family: "Museo Sans 300";
    font-weight: normal;
    text-decoration: none !important;
    color: #006283 !important;}
    .supnote, .supnote a {
		top: -0.8em;
		color: #00aeff;
		font-size: 60%;
		line-height: 0;
		position: relative;
		vertical-align: baseline;
	}
	.notes {list-style-type: circle;
			padding-left: 20px;}
	.notes :before {<!--font-family: 'WTO';
					content: '\0041';
					padding: 0;-->
					color: #00AEFF;
					font-size: 60%;
					<!--margin-right: 10px;-->
					margin-left: 20px;}
	.bckg {background-color:red !important;
			margin-left: 5%;
			width: 90%;}
	.disp-none{display:none;}
	.tab-img{ width: 100%;
			  border: 0px;
			  margin: -15px;}
						
	</xsl:template>
	<xsl:template name="sec-title">
		<xsl:variable name="seclevel" select="count(ancestor-or-self::sec)"/>
		<xsl:element name="h{$seclevel+1}">
			
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:value-of select="label"/>. 
		<xsl:value-of select="title"/>
			<a href="#top" class="backToTop"> back to top</a>
			
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
	<xsl:template match="ext-link">
		<a href="{@xlink:href}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>
	<!--Attention aux références internes du doc: faire des exclusions-->
	<xsl:template match="xref[@ref-type='fn']">
		<!--<xsl:template match="p/fn">-->
		<!--<sup id="{@rid}" class="supnote">-->
		<!--<sup id="fntext-[name()='label']" class="supnote">-->
		<!--<sup class="supnote" id="fntext-[text()='fn/label']">-->
		<sup id="fntext-{@rid}" class="supnote">
			<a href="#{@rid}">
				<xsl:value-of select="."/>
			</a>
		</sup>
	</xsl:template>
	<!--<xsl:template match="fn[@id]|except //table-wrap-foot/fn">-->
	<xsl:template match="fn[@id]">
		<li id="{@id}" class="note-list">
			<span class="reference-text">
				<xsl:value-of select="label"/>
				<span>. </span>
				<xsl:value-of select="p"/>
				<span>&#160;</span>
				<a href="#fntext-{@id}" class="small">
					<i class="icon-back-to-top"/>Back to text</a>
			</span>
		</li>
	</xsl:template>
	<!--<xsl:template match="xref[@ref-type='fn']">
		<li id="{@rid}" class="note-list">
			<span class="reference-text">
				<xsl:value-of select="label"/>
				<span>. </span>
				<xsl:value-of select="p"/>
				<span>&#160;</span>
				<a href="#fntext-{@rid}" class="small">
					<i class="icon-back-to-top"/>Back to text</a>
			</span>
		</li>
	</xsl:template>-->
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
		<xsl:if test="label|caption/title">
			<h3>
				<xsl:value-of select="label"/>: <xsl:value-of select="caption/title"/>
			</h3>
		</xsl:if>
		<xsl:apply-templates select="table"/>
		<div class="bckg">
			<xsl:apply-templates select="table-wrap-foot"/>
		</div>
	</xsl:template>
	<!--test insertion tfoot-->
	<xsl:template name="table-wrap-foot">
		<p>
			<xsl:value-of select="fn/p"/>
		</p>
		<p>
			<xsl:value-of select="attrib"/>
		</p>
	</xsl:template>
	<xsl:template match="table">
		<table id="{../@id}">
			<xsl:apply-templates select="thead|tbody|tr"/>
			<!--thead|tbody|tfoot|tr-->
		</table>
	</xsl:template>
	<xsl:template match="thead|tbody|tr|td|th">
		<!--thead|tbody|tfoot|tr|td|th-->
		<xsl:element name="{name()}">
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:for-each>
			<xsl:apply-templates select="text()|*"/>
		</xsl:element>
	</xsl:template>
	<!--test solutiom table footer-->
	<!--<xsl:template match="table-wrap-foot">
		<p>
			<xsl:value-of select="fn/p"/>
		</p>
		<p>
			<xsl:value-of select="attrib"/>
		</p>
		<xsl:apply-templates select="table"/>
	</xsl:template>-->
	<!--	<xsl:template match="table-wrap">
		<h3>
			<xsl:value-of select="label"/>: <xsl:value-of select="caption/title"/>
		</h3>
		<xsl:apply-templates select="table"/>
	</xsl:template>-->
	<!--<xsl:template match="table">
		<table id="{../@id}">
			<xsl:copy-of select="thead|tbody|tfoot|tr"/>
		</table>
	</xsl:template>-->
	<xsl:template name="annex">
		<xsl:for-each select="/book/book-back/book-app-group/book-app">
			<p>
				<xsl:value-of select="/book-part-meta/title-group/title"/>
			</p>
			<xsl:for-each select="/body/sec">
				<p>
					<p>
						<xsl:value-of select="/title"/>
					</p>
				</p>
			</xsl:for-each>
		</xsl:for-each>
		<!--<ol class="{@list-type}">
			<xsl:apply-templates select=""/>
		</ol>-->
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
		<!--<img alt="{../label}" src="{$src}"/>-->
		<table class="tab-img">
			<tbody>
				<tr>
					<td>
						<img alt="{../label}" src="{$src}"/>
					</td>	
				</tr>
			</tbody>
		</table>
		
	</xsl:template>
	<xsl:template name="notes">
		<!--<xsl:if test="fn">-->
		<h3>Notes</h3>
		<ul class="notes">
			<xsl:apply-templates select="//fn"/>
		</ul>
		<!--</xsl:if>-->
	</xsl:template>
	<xsl:template name="displayAnex">
		<xsl:call-template name="tocChart"/>
		<xsl:call-template name="tocTable"/>
		<xsl:call-template name="tocTableAppendix"/>
	</xsl:template>
	<xsl:template match="break">
		<br/>
	</xsl:template>
	<xsl:template match="underline">
		<u>
			<xsl:value-of select="."/>
		</u>
	</xsl:template>
	<xsl:template match="bold">
		<b>
			<xsl:value-of select="."/>
		</b>
	</xsl:template>
</xsl:stylesheet>