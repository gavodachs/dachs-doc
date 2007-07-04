<?xml version="1.0" encoding="iso-8859-1"?>
<x:stylesheet xmlns:x="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:fn="http://www.w3.org/2005/xpath-functions">

<!-- This is a stylesheet to generate some crude form of documentation
from resource descriptors -->

<x:template match="ResourceDescriptor">
	<html><head><title>Docs for <x:value-of select="@srcdir"/></title>
	<link rel="stylesheet" type="text/css" href="/qstatic/rddocs.css"/>
	</head><body>
	<x:apply-templates/>
	</body></html>
</x:template>

<x:template match="schema">
</x:template>

<x:template match="Data">
	<h1>Data from 
		<x:value-of select="../@srcdir"/>/<x:value-of 
			select="@source"/><x:value-of select="@sourcePat"/>
	</h1>
	<x:apply-templates select="*/Record"/>
</x:template>

<x:template match="Record">
	<h2>Table <x:value-of select="string(//schema)"/>.<x:value-of 
		select="@table"/></h2>
	<table class="recorddef">
		<tr><th>DB name</th><th>DB type</th><th>Table head</th><th>Description</th>
		<th>Unit</th><th>UCD</th><th>Source</th></tr>
		<x:apply-templates/>
	</table>
</x:template>

<x:template match="implements">
	<tr class="implements">
		<td colspan="7">
			This table satisfies the <x:value-of select="@name"/> interface.
			<!-- Take that info for "the source"? -->
			<x:choose>
				<x:when test="@name='products'">
					This means you can use fields datapath, owner, embargo, and fsize.
				</x:when>
				<x:when test="@name='positions'">
					This means you can use fields alphaFloat, deltaFloat, c_x,
					c_y, c_z.
				</x:when>
				<x:when test="@name='q3cpositions'">
					This means you can use fields alphaFloat, deltaFloat, c_x,
					c_y, c_z, and there should be a q3c index on alphaFloat and
					deltaFloat, meaning you can do fast cone searches and the like.
				</x:when>
				<x:otherwise>
					This interface is not explained in the style sheet rd.xslt.
					Please supply a description there or have someone do it.
				</x:otherwise>
			</x:choose>
		</td>
	</tr>
</x:template>

<x:template match="Field">
	<x:element name="tr">
		<x:choose>
			<x:when test="position() mod 4=0">
				<x:attribute name="class">evenRow</x:attribute>
			</x:when>
			<x:otherwise>
				<x:attribute name="class">oddRow</x:attribute>
			</x:otherwise>
		</x:choose>
		<td><x:value-of select="@dest"/></td>
		<td><x:value-of select="@dbtype"/></td>
		<td><x:value-of select="@tablehead"/></td>
		<td><x:value-of select="@description"/></td>
		<td><x:value-of select="@unit"/></td>
		<td><x:value-of select="@ucd"/></td>
		<td><x:value-of select="@source"/></td>
	</x:element>
</x:template>

</x:stylesheet>
