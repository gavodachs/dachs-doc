<?xml version="1.0" encoding="iso-8859-1"?>
<x:stylesheet xmlns:x="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:fn="http://www.w3.org/2005/xpath-functions">

<!-- This is a stylesheet to generate some crude form of documentation
from resource descriptors -->

<x:template match="ResourceDescriptor">
	<html><head><title>Docs for <x:value-of select="@srcdir"/></title>
	</head><body>
	<x:apply-templates/>
	</body></html>
</x:template>

<x:template match="schema">
	<p>Target Schema: <x:apply-templates/></p>
</x:template>

<x:template match="Data">
	<h1>Data from <x:value-of select="@source"/><x:value-of select="@srcpat"/>
	</h1>
	<x:apply-templates select="*/Record"/>
</x:template>

<x:template match="Record">
	<h2>Table <x:value-of select="@table"/></h2>
	<table border="1">
		<tr><th>DB name</th><th>DB type</th><th>Table head</th><th>Description</th>
		<th>Unit</th><th>UCD</th><th>Source</th></tr>
		<x:apply-templates/>
	</table>
</x:template>

<x:template match="Field">
	<tr>
		<td><x:value-of select="@dest"/></td>
		<td><x:value-of select="@dbtype"/></td>
		<td><x:value-of select="@tablehead"/></td>
		<td><x:value-of select="@description"/></td>
		<td><x:value-of select="@unit"/></td>
		<td><x:value-of select="@ucd"/></td>
		<td><x:value-of select="@source"/></td>
	</tr>
</x:template>

</x:stylesheet>
