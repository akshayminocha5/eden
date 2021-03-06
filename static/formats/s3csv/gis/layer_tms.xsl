<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- **********************************************************************
         TMS Layers - CSV Import Stylesheet

         CSV column...........Format..........Content

         Name.................string..........Layer Name
         Description..........string..........Layer Description
         Enabled..............boolean.........Layer Enabled in SITE_DEFAULT config?
         Folder...............string..........Layer Folder
         URL..................string..........Layer URL
         URL2.................string..........Layer URL2
         URL3.................string..........Layer URL3
         Layer Name...........string..........Layer LayerName
         Format...............string..........Layer Image Format
         Attribution..........string..........Layer Attribution
         Zoom Levels..........integer.........Layer Zoom Levels

    *********************************************************************** -->
    <xsl:output method="xml"/>

    <!-- ****************************************************************** -->
    <xsl:template match="/">
        <s3xml>
            <xsl:apply-templates select="./table/row"/>
        </s3xml>
    </xsl:template>

    <!-- ****************************************************************** -->
    <xsl:template match="row">

        <xsl:variable name="Layer" select="col[@field='Name']/text()"/>

        <resource name="gis_layer_tms">
            <xsl:attribute name="tuid">
                <xsl:value-of select="$Layer"/>
            </xsl:attribute>
            <data field="name"><xsl:value-of select="$Layer"/></data>
            <data field="description"><xsl:value-of select="col[@field='Description']"/></data>
            <data field="dir"><xsl:value-of select="col[@field='Folder']"/></data>
            <data field="url"><xsl:value-of select="col[@field='URL']"/></data>
            <data field="url2"><xsl:value-of select="col[@field='URL2']"/></data>
            <data field="url3"><xsl:value-of select="col[@field='URL3']"/></data>
            <data field="layername"><xsl:value-of select="col[@field='Layer Name']"/></data>
            <xsl:if test="col[@field='Format']!=''">
                <data field="img_format"><xsl:value-of select="col[@field='Format']"/></data>
            </xsl:if>
            <data field="attribution"><xsl:value-of select="col[@field='Attribution']"/></data>
            <data field="zoom_levels"><xsl:value-of select="col[@field='Zoom Levels']"/></data>
        </resource>

        <resource name="gis_layer_config">
            <reference field="layer_id" resource="gis_layer_tms">
                <xsl:attribute name="tuid">
                    <xsl:value-of select="$Layer"/>
                </xsl:attribute>
            </reference>
            <reference field="config_id" resource="gis_config">
                <xsl:attribute name="uuid">
                    <xsl:value-of select="'SITE_DEFAULT'"/>
                </xsl:attribute>
            </reference>
            <data field="enabled"><xsl:value-of select="col[@field='Enabled']"/></data>
        </resource>

    </xsl:template>
    <!-- ****************************************************************** -->

</xsl:stylesheet>
