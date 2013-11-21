"""
A helper script to traverse the known RDs now and then and provide an
index of elements and attributes while doing that.
"""

import datetime
import os
import re

from gavo import api
from gavo.registry import publication
from gavo.utils import ElementTree


# used to make links to the actual RDs (no trailing slash, please)
SVN_BASE = "http://svn.ari.uni-heidelberg.de/svn/gavo/hdinputs"

INTRO ="""================================
Index to Elements and Attributes
================================

This is an index of DaCHS elements and attributes in use at GAVO's
data center, intended primarily to help people looking for concrete
usage examples.  The index keys are xpath-like expressions, where the basic 
``resource`` node is left out; since element and attributes are by and large
equivalent in RDs, we do not distinguish between them.

Note that many elements can occur at many places (even more so with
active tags).  Thus, you should keep searching after the first match to
find more examples.

Meta elements are omnipresent, but some names are somewhat magic, so for
those we use the ad-hoc syntax ``meta[name]``.

This document was generated %s using the docs/makeElemenIndex.py script
in the DaCHS distribution.

"""%(datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S"))


def gatherXPaths(inFile):
	"""returns a set of xpath-like keys found in inFile.
	"""
	curPath, keys = [], set()

	for event, element in ElementTree.iterparse(inFile, events=("start", "end")):
		if event=="start":
			curPath.append(element.tag)

		elif event=="end":
			if element.tag=="meta" and element.attrib.get("name"):
				# special handling -- for those we normally want to evaluate
				# name values only
				keys.add("/".join(curPath[1:])+"[%s]"%element.attrib["name"])

			else:
				if len(curPath)>1:
					keys.add("/".join(curPath[1:]))
				for attName in element.attrib:
					keys.add("/".join(curPath[1:])+"/%s"%attName)

			curPath.pop()

	return keys	


def getPathIndex():
	"""returns a dictionary mapping xpath-like things to rd ids in which 
	they appear.

	The RDs are gathered by traversion [general]inputsDir.
	"""
	pathIndex = {}
	for rdId in publication.findAllRDs():
		# ignore RD ids with funky characters (which may get us in trouble
		# with rstx, for example)
		if not re.match("[A-Za-z0-9][\w_/]*$", rdId):
			continue

		rdPath = os.path.join(api.getConfig("inputsDir"), rdId+".rd")
		if not os.path.exists(rdPath):
			# probably a __system__ RD
			continue

		with open(rdPath) as inFile:
			for key in gatherXPaths(inFile):
				pathIndex.setdefault(key, set()).add(rdId)
	return pathIndex


def makeIndexRSTX(pathIndex, baseURL):
	"""returns reStructuredText for pathIndex, with RDs being found at baseURL.
	"""
	result = []
	for path in sorted(pathIndex):
		result.append(":%s:\n  %s"%(
			path,
			", ".join("`%s`_"%rdId for rdId in sorted(pathIndex[path]))))

	result.append("")
	for rdId in reduce(lambda a, b: a|b, pathIndex.values()):
		result.append(".. _%s: %s/%s.rd"%(rdId, baseURL, rdId))

	return INTRO+'\n'.join(result)



def main():
	pathIndex = getPathIndex()
	print makeIndexRSTX(pathIndex, SVN_BASE)


if __name__=="__main__":
	main()
