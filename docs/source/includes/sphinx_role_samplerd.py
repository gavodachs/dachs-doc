def setup(app):
    from docutils import nodes
    from docutils import utils as rstutils

    def _samplerdRoleFunc(name, rawText, text, lineno, inliner,
                            options={}, content=[]):
        # this will turn into a link to a file in the GAVO svn
        # (usually for RDs)
        text = rstutils.unescape(text)
        url = "http://svn.ari.uni-heidelberg.de/svn/gavo/hdinputs/"+text
        return [nodes.reference(text, text, internal=False, refuri=url)
                ], []

    # RSTExtensions.makeTextRole("samplerd", _samplerdRoleFunc)
    # del _samplerdRoleFunc
    app.add_role('samplerd', _samplerdRoleFunc)
