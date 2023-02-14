---
title: eCos CDL remarks and criticism (outdated)
permalink: /xcdl/criticism/ecos/

comments: true

date: 2015-10-25 12:00:00 +0200

---

## The good parts

Developed in the very early 2000 (the manual date is 2001), the eCos CDL was a remarkably innovative solution for its time, not matched even today.

## The bad parts

Although the CDL design was pretty general, being created to support eCos, the CDL was perceived as an eCos specific part, and generally avoided.

Another important issue was the complexity of the CDL scripts, and to some (including myself) the Tcl syntax of the scripts, a bit outdated in the world of JSON/YML.

Other issues:

-   preprocessor only definitions, no direct support for modern solutions like the new C++11 constexpr

## Changes in XCDL

XCDL inherits the core concepts from CDL, however some changes were applied.

### Tcl replaced by JSON & JavaScript

After a prototyping phase which used Python instead of Tcl, the final format used for the XCDL metadata was settled to JSON, with its simple logical structure, a node has a name, a list of properties and an optional array of children nodes.

### Naming scheme shortened

In CDL, the object names were in fact C preprocessor definitions, and the scope of the names was the configuration tree.

The first step to separate the node names from the preprocessor definitions was attempted in the Python implementation of XCDL, where separate IDs were used. This solution was perfectly functional, but since the IDs were expected to be unique in the entire object space, they were quite long and hard to handle, not to mention that they were not at all fit to be represented in a graphical user interface.

In the JSON version of XCDL the naming scheme was shortened, and object names were required to be unique only in the scope of the parent node, similar to files in a folder. Recursively applied, this rule produces unique names as long as the entire path is used (again, similarly to files in a file system).

### Explicit header file

In CDL, by default, the name and location of the generated header file respected some not very obvious rules, with names derived from the long package name. This was perfectly functional, but made things a bit obscure.

In XCDL the rules were changes to a recursive approach, and the name of the file where to output the generated definitions must be explicitly specified for each object. If not specified, the definition from the parent node is used.
