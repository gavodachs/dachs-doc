def setup(app):
    import re
    from docutils import nodes
    from docutils import utils as rstutils

    def _dachsrefRoleFunc(name, rawText, text, lineno, inliner,
                          options={}, content=[]):
        # this will guess a link into the ref documentation
        print name,rawText,text
        text = rstutils.unescape(text)
        fragId = re.sub("[^a-z0-9]+", "-", text.lower())
        url = app.config.dachsref_base +"#"+ fragId
        _out = nodes.reference(text, text, internal=False, refuri=url)
        return [_out], []

    app.add_config_value('dachsref_base', "http://docs.g-vo.org/DaCHS/ref.html", False)
    app.add_role('dachsref', _dachsrefRoleFunc)
