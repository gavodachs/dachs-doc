<resource schema="editsample">
	<meta name="description">This is an example RD for a simple service
		letting people do annotations to some object list through the
		web interface.  It's kept in the docs repo because Markus does not have a
		live service that could show what do do for this kind of thing.

		The tutorial assumes this is installed at
		http://docs.g-vo.org/editsample_q.rd
	</meta>

	<table id="objlist" onDisk="True" primary="id">
		<column name="id" type="text"
			ucd="meta.id;meta.main"
			description="The id of the object.  This is unique within this table."/>

		<column name="ra"
			ucd="pos.eq.ra;meta.main" unit="deg"/>
		<column name="dec"
			ucd="pos.eq.dec;meta.main" unit="deg"/>

		<column name="remarks" type="text"
			ucd="meta.note"
			description="User-provided notes."/>
	</table>

	<data id="import-fake">
		<sources item="10"/>
		<embeddedGrammar>
			<iterator>
				<setup imports="random"/>
				<code>
					for id in range(int(self.sourceToken)):
						yield dict(zip(
							["id", "ra",                "dec",                 "remarks"],
							[id,   random.random()*360, random.random()*180-90, None]))
				</code>
			</iterator>
		</embeddedGrammar>
		<make table="objlist"/>
	</data>

	<service id="view">
		<dbCore queriedTable="objlist">
			<condDesc buildFrom="id"/>
		</dbCore>

		<outputTable original="objlist">
			<outputField name="edit"
					select="array[id, remarks]">
				<formatter>
					return T.a(class_="buttonlike", href="/\rdId/edit/form?"
						+urllib.parse.urlencode({
							"id": data[0],
							"remarks": data[1] or ""}))["Edit this"]
				</formatter>
			</outputField>
		</outputTable>
	</service>

	<service id="edit" limitTo="ari">
		<meta name="_related" title="Query Service"
			>\internallink{\rdId/view}</meta>
		<pythonCore>
			<inputTable>
				<inputKey original="objlist.id" required="True"/>
				<inputKey original="objlist.remarks" required="True"
					widgetFactory="widgetFactory(TextArea, rows=5, cols=40)"/>
			</inputTable>
			<outputTable original="objlist" primary=""/>

			<coreProc>
				<setup imports="gavo.svcs"/>
				<code>
					with base.getWritableAdminConn() as conn:
						if 1!=conn.execute("UPDATE \schema.objlist"
								" SET remarks=%(remarks)s"
								" WHERE id=%(id)s", inputTable.args):
							raise base.ValidationError("No row for id '{}'".format(
								inputTable.args["id"]), colName="id")

						return rsc.TableForDef(
							self.outputTable,
							rows=list(conn.queryToDicts("SELECT * FROM \schema.objlist"
								" WHERE id=%(id)s", inputTable.args)))

					# or remove the return clause and let this run to redirect
					# back to somewhere else, like the result display.
					raise svcs.Found("/\rdId/view?"+urllib.parse.urlencode({
						"id": inputTable.args["id"],
						"__nevow_form__": "genForm"}))

				</code>
			</coreProc>
		</pythonCore>
	</service>
</resource>
