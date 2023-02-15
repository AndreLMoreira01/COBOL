#  Makefile for alfred
#	"make" to compile the world
#

# The location of the ACUCOBOL-GT installation - assume we are in 
# $ACUCOBOL/alfred/sample
ACUCOBOL=../..

# To compile for debugging, uncomment and optionally modify the following line
#DEBUGFLAGS = -Gd

# To generate listings, uncomment and optionally modify the following line
#LISTFLAGS  = -lof @.lst

SAMPLE	 = $(ACUCOBOL)/sample
GENMENU	 = $(ACUCOBOL)/sample/genmenu
CCBL	 = $(ACUCOBOL)/bin/ccbl
CBLUTIL  = $(ACUCOBOL)/bin/cblutil
RUNCBL	 = $(ACUCOBOL)/bin/runcbl

CBLFLAGS = -vx $(DEBUGFLAGS) $(LISTFLAGS) -Sp $(SAMPLE):.

DIST	 = alfred.acu ParseXFD.acu
BMPS     = alfred.bmp alftools.bmp
OBJS     = alfred.cob ParseXFD.acu

all:	$(DIST)

alfred.acu: $(OBJS) $(BMPS)
	$(CBLUTIL) -lib -o $@ $(OBJS) $(BMPS)

alfred.cob: alfred.cbl alfred.mnu ParseXFD.ws
	$(CCBL) -o @.cob $(CBLFLAGS) alfred.cbl

alfred.mnu: genmenu.acu alfred.gmu
	$(RUNCBL) -b -1 genmenu alfred.gmu $@

genmenu.acu: $(ACUCOBOL)/sample/genmenu.cbl
	$(CCBL) -x -Sp $(SAMPLE) $(ACUCOBOL)/sample/genmenu.cbl

ParseXFD.acu: ParseXFD.ws ParseXFD.cbl
	$(CCBL) $(CBLFLAGS) ParseXFD.cbl

clean:
	-rm -f $(DIST) $(OBJS) genmenu.acu *.mnu *.lst *.adb
