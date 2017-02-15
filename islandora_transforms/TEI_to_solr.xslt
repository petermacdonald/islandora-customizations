<?xml version="1.0" encoding="UTF-8"?>
<!-- TEI -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei foxml">

    <xsl:template match="foxml:datastream[@ID = 'TEI']/foxml:datastreamVersion[last()]" name="index_TEI">
        <xsl:param name="content"/>
        <xsl:param name="prefix">TEI_</xsl:param>
        <xsl:param name="suffix">_ms</xsl:param>

        <!-- correspAction type=sent -->
        <xsl:for-each select="$content//tei:correspAction[@type = 'sent']">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'persName_sent', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="tei:persName[text()]"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'persName_sent_s')"/>
                </xsl:attribute>
                <xsl:value-of select="tei:persName[text()]"/>
            </field>
            <!-- suppressed as _ms is probably generated automatically from _s
                <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'placeName_sent', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="tei:placeName/tei:reg[text()]"/>
            </field>
-->
            <xsl:if test="tei:placeName != ''">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'placeName_sent_s')"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:placeName[text()]"/>
                </field>
            </xsl:if>
            
            <xsl:if test="tei:location/tei:geo != ''">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'coordinates_sent_ms')"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:location/tei:geo[text()]"/>
                </field>
            </xsl:if>
            
            <xsl:if test="tei:affiliation != ''">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'affiliation_sent_s')"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:affiliation[text()]"/>
                </field>
            </xsl:if>

            <xsl:if test="tei:date[@when != '']">
                <field>
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat($prefix, 'date_sent_s')"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:date/@when"/>
                </field>
            </xsl:if>
        </xsl:for-each>

        <!-- correspAction type=received -->
        <xsl:for-each select="$content//tei:correspAction[@type = 'received']">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'persName_received', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="tei:persName[text()]"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'persName_received_s')"/>
                </xsl:attribute>
                <xsl:value-of select="tei:persName[text()]"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'placeName_received', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="tei:placeName[text()]"/>
            </field>
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'placeName_received_s')"/>
                </xsl:attribute>
                <xsl:value-of select="tei:placeName[text()]"/>
            </field>
        </xsl:for-each>

        <!-- persName -->
        <xsl:for-each select="$content//tei:text//tei:persName/tei:reg[text()]">
            <field>
                <xsl:choose>
                    <xsl:when test="tei:roleName != ''">
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'persName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(concat(text(), tei:roleName))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'persName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(text())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </field>
        </xsl:for-each>

        <xsl:for-each select="$content//tei:text//tei:placeName/tei:reg[text()]">
            <field>
                <xsl:choose>
                    <xsl:when test="tei:region != ''">
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'placeName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(concat(text(), tei:region))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'placeName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(text())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </field>
        </xsl:for-each>

        <!-- geogName -->
        <xsl:for-each select="$content//tei:text//tei:geogName/tei:reg[text()]">
            <field>
                <xsl:choose>
                    <xsl:when test="tei:region != ''">
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'geogName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(concat(text(), tei:region))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="name">
                            <xsl:value-of select="concat($prefix, 'geogName', $suffix)"/>
                        </xsl:attribute>
                        <xsl:value-of select="normalize-space(text())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </field>
        </xsl:for-each>

        <!-- orgName -->
        <xsl:for-each select="$content//tei:text//tei:orgName/tei:reg[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'orgName', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>
        <!-- roleName -->
        <xsl:for-each select="$content//tei:text//tei:roleName[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'roleName', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- forename -->
        <xsl:for-each select="$content//tei:text//tei:forename[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'forename', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- surname -->
        <xsl:for-each select="$content//tei:text//tei:surname[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'surname', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- settlement name -->
        <xsl:for-each select="$content//tei:text//tei:settlement[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'settlement', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- region name -->
        <xsl:for-each select="$content//tei:text//tei:region[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'region', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- geoName -->
        <xsl:for-each select="$content//tei:text//tei:geogName/tei:reg/*[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'geogName', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(text())"/>
            </field>
        </xsl:for-each>

        <!-- text -->
        <xsl:for-each select="$content//tei:text[text()]">
            <field>
                <xsl:attribute name="name">
                    <xsl:value-of select="concat($prefix, 'text', $suffix)"/>
                </xsl:attribute>
                <xsl:value-of select="normalize-space(.)"/>
            </field>
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>
