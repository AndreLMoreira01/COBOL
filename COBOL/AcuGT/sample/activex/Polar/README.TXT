______________________________________________
Polar SpellChecker Component Trial
(C) Copyright 1998-1999 POLAR d.o.o.
All rights reserved.
______________________________________________

Polar SpellChecker Component Trial


IMPORTANT: Please read this document completely before using Polar SpellChecker Component.


CONTENTS
	1.  INTRODUCTION
	2.  ABOUT THE INSTALLATION PROGRAM
	3.  INSTALLING THE PRODUCT
	4.  FILE INFORMATION
	5.  DISTRIBUTING APPLICATIONS
	6.  REDISTRIBUTING APPLICATIONS
	7.  USING THE UNINSTALLER
	8.  HOW TO CONTACT US



1.  INTRODUCTION

Polar SpellChecker Component includes ActiveX and Dynamic-link library component
for adding spell checking functionality, and ActiveX and Dynamic-link library 
component for adding auto correct functionality to a higher-level application.
SpellChecker and AutoCorrect components contain all functions necessary for usual
spell checking and auto correct: get suggestions for words that are not in dictionary,
change, ignore or add words in custom dictionary; correct two initial caps, capitalization
of the first letter in the sentence, user defined exceptions for capitalizing of the first
letter in the sentence, correction of accidental use of CAPS LOCK key, user definable 
words for replacing while typing, and others.

It also includes SpellMaker - Wizard for the creation of your own dictionaries. 
From the simple txt file written by the rule "one word" - "one line", SpellMaker 
will generate a .lex file which can be used by Polar SpellChecker.

Or you can simply download one of dictionaries offered on our site: www.polarsoftware.com
(You can switch between dictionaries at runtime.), or let your end-users to download them 
themselves, from the inside of your application, with just one line of code!

Polar SpellChecker Component is a product of POLAR software company and is protected by copyright
laws and international treaty provisions. If you do not agree to the terms of the license
agreement, you are not allowed to use this product or any part of it. Should you have any
questions concerning this product, contact POLAR.
This is a trial version of Polar SpellChecker Component.



2.	ABOUT THE INSTALLATION PROGRAM
The Installer Program installs the trial version of the component. You cannot deploy applications
with this version and redistribute the component to your users. Trial version is limitted by 
displaying nag screens.


3.  INSTALLING THE PRODUCT
The Setup program creates new directories and copies product files to your hard disk.

To install a Polar SpellChecker Component on your hard disk:

	1.	Insert the first disk or CD in your drive. (If you downloaded the product
		from the Internet, locate the directory with installation files.)
	2.	Locate and double-click SETUP.EXE.
	3.	Follow the Setup program directions.




4.  FILE INFORMATION

List of Installed Files:
If you choose Typical setup option, the following files will be installed in the
Polar SpellChecker Component program directory (c:\Program Files\Polar SpellChecker Component\, by default):


Filename				Description

PolSpell.OCX		Polar SpellChecker ActiveX Control
PolSpell.LIC		Polar SpellChecker ActiveX Control license file
PolSpell.dll		Polar SpellChecker dynamic-link library (Installed in WIN/SYS directory)
PolSpell.lib		Polar SpellChecker library file
PolSpell.txt            Declarations of DLL functions for VB users
PolSpell.h		Polar SpellChecker header file (C++)
MfcSpell.h              Polar SpellChecker header file (C++)


AutoCorrect.OCX		Polar AutoCorrect ActiveX Control
AutoCorrect.LIC		Polar AutoCorrect ActiveX Control license file
AutoCorrectDLL.dll      Polar AutoCorrect  dynamic-link library (Installed in WIN/SYS directory)
AutoCorrectDLL.lib      Polar AutoCorrect library file
autocorr.h		Polar AutoCorrect  header file (C++)
AutoCorrectDLL.txt      Declarations of DLL functions for VB users

gteinet.dll		Module for download dictionary options (Installed in WIN/SYS directory)
GwdUnz32.dll            Module for download dictionary options (Installed in WIN/SYS directory)

SpellMaker.exe		Wizard for making SpellChecker dictionary files

README.TXT		This File
License.txt		License agreement
PolSpell.HLP            Developer's On-Line Documentation
AutoCorrect.hlp         Developer's On-Line Documentation

SpellCheckerOCX		Source code of the sample written in Visual Basic 5.0 (using SpellChecker OCX)
SpellCheckerDLL		Source code of the sample written in Visual Basic 5.0 (using SpellChecker DLL)
AutoCorrectOCX		Source code of the sample written in Visual Basic 5.0 (using AutoCorrect OCX)

SpellCheckerOCX		Source code of the sample written in Visual C++ 5.0 (using SpellChecker OCX)
AutoCorrectOCX		Source code of the sample written in Visual C++ 5.0 (using AutoCorrect OCX)
Editor			Source code of the sample written in Visual C++ 5.0 (using SpellChecker DLL)

AutoCorrectOCX		Source code of the sample written in Borland Delphi 3.0 (using AutoCorrect OCX)

DemoBrowser.exe		App (for easier sample browsing)



5.  DISTRIBUTING APPLICATIONS
Please read the license agreement included in your package. You are bound by the licensing
restrictions contained in this agreement.


6.  REDISTRIBUTING APPLICATIONS
The table below shows all the files necessary for POLAR ActiveX controls to operate properly.
If you have purchased Polar SpellChecker Component and are deploying an application, you must ensure
that the first three groups of files listed below exist on your client's machine and
are the proper version. The correct versions of these files are provided on the product CD.
If your client's machine has older versions of these files, you should update them.

	1  	PolSpell.OCX	(or PolSpell.dll)

                gteinet.dll	(if your app is using functions for downloading dictionaries)
		GwdUnz32.dll    (if your app is using functions for downloading dictionaries)
		AutoCorrect.OCX	(or AutoCorrectDLL.Dll) (if your app is using functions for autocorrection)

	2	MFC42.DLL
		MSVCRT.DLL

	3	OLE32.DLL
		OLEAUT32.DLL
		OLEPRO32.DLL

	4	KERNEL32.DLL
		USER32.DLL
		GDI32.DLL
		COMDLG32.DLL
		VERSION.DLL
		ADVAPI32.DLL

PolSpell.ocx, PolSpell.Dll, AutoCorrect.ocx, AutoCorrect.Dll, GwdUnz32.dll and gteinet.dll are 
the Polar SpellChecker Component re-distributable files. This file may be in the Windows system 
directory, on the computer's path, or for WinNT and Win95, in the directory specified by your 
application's Per Application Path key in the Registry Database. The .OCX file 
must be registered on each user's machine. The Polar SpellChecker Component Setup program 
registers the OCXs on your development machine. To register an OCX on the user 
machine, use the REGSVR32.EXE utility. This utility is available from Microsoft. 
To run this utility type the following at the command prompt on each user's machine:

regsvr32 filename

The second group of files are Microsoft redistributable files necessary for the
ActiveX control to operate. Your programming environment should have installed
and registered these files. If they were not installed, or they are older versions,
the Polar SpellChecker Component installer updated and registered them. Copy these files from
your development machine to your users machine.

Our ActiveX controls require OLE2 support to be installed on a machine. In order
to run an application containing one of our controls you must ensure OLE2 has
been installed on the user's machine. The third group of files in the table list are
the OLE2 files accessed by Polar SpellChecker Component. Normally, copying these files
to the user machine is all that is required.

The fourth group of files should be present on any system running Windows. You should
not remove or update these files. They are included only to form a complete list of
filed needed to use Polar SpellChecker Component.




7.	 USING THE UNINSTALLER
Polar SpellChecker Component files can be removed from your system with the Windows 95
Add\Remove Programs item or by double-clicking the UnInstaller icon in the
Program Manager folder. Using the UnInstaller will remove all files and
Registration Database entries made during the installation. If you are using
Visual Basic, it will create a support cache file (********.OCA) for each control,
that must be removed manually.

The UnInstaller creates a log of operations during the installation which it
"undoes" to "uninstall" the product. You should run the UnInstaller before running
the Installer additional times. If you run the installer a second time without
using the UnInstaller first, only the options selected in the second install will
be written to the UnInstall log and later be uninstalled. For the UnInstaller
to work properly, you should reinstall your original options in addition to the
options you wish to install.

The Windows Start menu is not always updated immediately by the operating system.
This means that sometimes uninstalled shortcuts do not always disappear right away.
Because of this limitation, an uninstalled shortcut can temporarily continue to
appear in the Start menu even though it really has been uninstalled. If you wait
for a while, run some other programs, or restart the system, the shortcut should
eventually disappear from the Start menu.

To verify that the program has been uninstalled:

1.	From the Start menu, go to Settings/Taskbar/Start Menu Programs/Advanced.
2.	When the Explorer displays, click on the existing program folder.
3.	Check to see if the shortcut exists in the program folder. If it does not,
	then the shortcut has been uninstalled correctly, but the Start menu has not
	been updated correctly.




8.  HOW TO CONTACT US

POLAR d.o.o.
Put Supavla 1
21000 Split
Croatia

Phone: +385 21 380770
Fax:	 +385 21 380771

World Wide Web: http://www.polarsoftware.com

Contact:		info@polarsoftware.com
Developer Services: 	support@polarsoftware.com