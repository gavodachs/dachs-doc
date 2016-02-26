==========
GAVO DaCHS
==========

:Author: Markus Demleitner
:Email: gavo@ari.uni-heidelberg.de
:Date: |date|

The GAVO Data Center Helper Suite (DaCHS) is a publishing infrastructure
for the Virtual Observatory, including a flexible component for
ingesting and mapping data, integrated metadata handling with a
publishing registry, and support for many VO protocols and standards.


Documentation
=============

All of this is very much work in progress.  Users asking for elaboration
are certainly good indicators of where need is greatest.


System management

.. toctree::
    :maxdepth: 1

    install


Resources descriptors

.. toctree::
    :maxdepth: 1

    tutorial
    opguide
    howDoI
    commonproblems
    ref
    elemref


On providing (meta)data

.. toctree::
    :maxdepth: 2

    data_checklist


The web interface

.. toctree::
    :maxdepth: 2

    templating


Extras on file processing

.. toctree::
    :maxdepth: 2

    processors
    booster


API

.. toctree::
    :maxdepth: 1

    votable
    stc
    adql
    tapquery
    apidoc


Developers

.. toctree::
    :maxdepth: 1

    develNotes


What to read when?
------------------

Obviously, you should start with the installation instructions (have a
brief glance at them even if you install from Debian package).  You
should then probably read and work through the tutorial to get a feel
for how DaCHS works.  Once you have data and want to go live, you'll
have to read the operator's guide.  That's about all there is to read
sequentially.

When you get error messages you don't understand, check the "Hints on
common problems".  When you have some funky litte requirement the
solution for which is not immediately obvious, try the "How do I"
document.  If what you want is not covered, ask the authors.

The reference is, well, the reference, and I'm afraid you'll have to
look up things in there fairly regularly.  The good news is that there's
examples in the index to elements and attributes in the GAVO DC; these
are essentially live, and as long as you've had a look at the reference,
there's nothing wrong with lavishly copying from there.

You can ignore the topic guides (booster grammars, preprocessing,
anything else that might yet come) until you notice you need to read
them.

Software
========

To obtain the software (or parts of it), see
http://soft.g-vo.org.


Support
=======

If you run a DaCHS server, please subscribe to the `DaCHS-users`_
mailing list.  It is low volume (less than one mail a month), and you get
to know when new releases come out.  We'd also appreciate being able to
alert our users in case a security hole should be discovered in the
software (which hasn't happened so far, FWIW).

If you have questions regarding DaCHS, we'd appreciate if you subscribed
and sent your question to the `DaCHS-support`_ list (if all support
requests went on the list, we'd expect a volume of about one mail per
day, but let's see). It has a public archive, and other users can profit
from our (and your peers') answers, which is why we prefer the list to
questions sent directly to gavo@ari.uni-heidelberg.de; these will of
course still be answered.

.. _DaCHS-users: http://lists.g-vo.org/cgi-bin/mailman/listinfo/dachs-users
.. _DaCHS-support: http://lists.g-vo.org/cgi-bin/mailman/listinfo/dachs-support
.. |date| date::
