#!/bin/sh

# Assume we are in $ACUCOBOL/sample/alfred, as distributed
ACUCOBOL=../..
CCBL=${ACUCOBOL}/bin/ccbl
RUNCBL=${ACUCOBOL}/bin/runcbl
SAMPLE=${ACUCOBOL}/sample

# If you want to compile in debug, modify and/or uncomment the following line
# DEBUGFLAGS=-Gd

# To generate listings, modify and/or uncomment the following line
# LISTFLAGS=-Lof @.lst

# First generate alfred.mnu - the alfred menu

# Make sure genmenu can be executed
build_menu()
{
    echo Building genmenu.acu
    $CCBL -xv -Sp $SAMPLE $SAMPLE/genmenu.cbl
    echo Generating alfred.mnu from alfred.gmu
    $RUNCBL -b -1 genmenu alfred.gmu alfred.mnu
    rm -f genmenu.acu
}

# Now we can build all the alfred objects (alfred and ParseXFD)
build_objects()
{
    build_menu
    echo Compiling ParseXFD.cbl
    $CCBL -xv -Sp $SAMPLE:. $DEBUGFLAGS $LISTFLAGS ParseXFD.cbl
    echo Compiling alfred.cbl
    $CCBL -xv -Sp $SAMPLE:. $DEBUGFLAGS $LISTFLAGS alfred.cbl
}

clean_objects()
{
    echo Cleaning \*.acu \*.mnu \*.lst *.adb
    rm -f *.acu *.mnu *.lst *.adb
}

if [ "$1". = "clean". ]
then
    clean_objects
else
    build_objects
fi
