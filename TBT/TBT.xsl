<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<xsl:call-template name="styleCSS"/>
			</head>
			<body>
				<xsl:apply-templates select="//title-group"/>
				<xsl:apply-templates select="//table-wrap"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="styleCSS">
		<style type="text/css">
			<!--<xsl:call-template name="commun-css"/>-->
			h1{
				color:skyblue;
				text-align:center;
			}
			.common-title{
				font-size:24pt;
			}
			.bold-type{
				font-weight:900;
			}
		</style>
	</xsl:template>
	<xsl:template match="title-group">
		<h1 class="common-title bold-type">
			<xsl:value-of select="title"/>
		</h1>
	</xsl:template>
	<!--uniquement pour les table-wrap enfant de named-book-part-body-->
	<xsl:template match="named-book-part-body/table-wrap">
		<table class="common-title">
			<xsl:apply-templates select="//*"/>
		</table>
	</xsl:template>
	<!--uniquement pour les table-wrap enfant de named-book-part-body uniquement si il contient plus de 2 table-wrap-->
	<xsl:template match="named-book-part-body[count(table-wrap)>2]/table-wrap" priority="1">
		<table class="common-title">
			<xsl:apply-templates select="//*"/>
		</table>
	</xsl:template>
	<xsl:template match="named-book-part-body//td">
			<xsl:apply-templates select="//*"/>
	</xsl:template>
	<xsl:template match="td">
	
	</xsl:template>
	<xsl:template match="table-wrap">
		<table class="bold-type">
			<xsl:apply-templates select="//*"/>
		</table>
	</xsl:template>
</xsl:stylesheet>
