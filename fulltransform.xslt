<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:include href="lib/libElement.xslt"/>
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
					
					.notif-table-wrap{
						margin:0;
						border-style:double;
					}
					.notif-table-wrap table{
						border:none !important;
						width:100%;
						margin:0;
					}
					.notif-table-wrap table td{
						border-left:none;
						border-right:none;
						padding:10px;
					}
					.notif-table-wrap td, .notif-table-wrap th, .rta-table-wrap td, .rta-table-wrap th
					{
						background-color:transparent !important;
					}
				</style>
			</head>
			<xsl:apply-templates select="/book"/>
		</html>
	</xsl:template>
	<!--architecture XML courante-->
	<xsl:template match="/book[book-body]">
		<body>
			<xsl:call-template name="header"/>
			<xsl:call-template name="title"/>
			<xsl:call-template name="toc"/>
			<xsl:call-template name="displayAnex"/>
			<xsl:call-template name="summary"/>
			<xsl:apply-templates select="//body/sec"/>
		</body>
		<footer>
			<xsl:call-template name="notes"/>
		</footer>
	</xsl:template>
	
	<!--architecture XML courante tableau>-->
	<xsl:template match="/book/book-body[book-part]">
		<body>
			<xsl:call-template name="header"/>
			<xsl:call-template name="title"/>
			<div class="">
				
				<xsl:apply-templates select="body/table-wrap"/>
					
			</div>
			<!--<div class="bckg">
			<xsl:apply-templates select="table-wrap-foot"/>coucou
			</div>-->
			
		</body>
	</xsl:template>
	<!--architecture XML notifications tableau>-->
	<xsl:template match="/book[not(book-body)]">
		<body>
			<xsl:call-template name="header"/>
			<xsl:call-template name="title"/>
			<div class="notif-table-wrap">
				<xsl:apply-templates select="front-matter/front-matter-part/named-book-part-body/table-wrap"/>
				
			</div>
		</body>
	</xsl:template>
</xsl:stylesheet>