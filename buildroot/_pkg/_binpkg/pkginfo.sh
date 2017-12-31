#edit this file
#optional - create pkg.install
#DEPENDS list of dependencies (0 or more)
#DEPENDS="pkg1 pkg2"
#GRP - package group (2)
#GRP="group1 group2"
##DONTSTRIP 0 (or "" without value) or 1 ("1" value checked) - strip debug info or not
##DONTSTRIP=0

NAME=xdg-utils
VERSION=1.1.2
REV=2
SHORT_DESC="The xdg-utils package is a set of simple scripts that provide basic desktop integration functions for any Free Desktop, such as Linux"
DEPENDS=""
GRP="base xutil"
PKG=$NAME
DONTSTRIP=1
