      *------------------------------------------------------------
      *        preprocessor calling Oracle Unix procob precompiler
      *        copyright Acucorp - jmbc 2002/2004
      *
      *        The program contains 4 parts:
      *        -one main part (clientpart) called by boomerang.cmd 
      *            under Acubench
      *        -one part (serverpart) called by Acuconnect
      *            (on the server) under the main part
      *        -one part (preCompilePart) called by the compiler
      *            under the main part
      *        -one part (cleanServerpart) called by Acuconnect
      *            (on the server) under the main part
      *
      *
      * Roch Rolland : December 2004
      * Some modifications were made to extract the specifities
      * of CNAM-TS from Boomerang.
      *
      *------------------------------------------------------------
       identification division.
       environment division.
       input-output section.
       file-control.
      *--lock file for client station
       select optional lockfile assign lockFileName
           access mode is sequential
           lock mode exclusive
           file status is stFic.
      *--input file for various files
       select iFile assign iFileName
           access mode is sequential
           organization is line sequential
           file status is stFic.
      *--list file for vio management and more
       select optional listFile assign listFileName
           access mode is sequential
           organization is line sequential
           file status is stFic.
      *--identification of the current task
       select optional uniqueNumber assign to uniqueNumberName
           access mode is random
           organization relative
           relative key is keyNumber
           lock mode exclusive
           file status is stFic.
      *--output file for various files
       select optional oFile assign oFileName
           access mode is sequential
           organization is line sequential
           file status is stFic.
      *--------------------------------------------------
       data division.
       file section.
      *--see above for comments
       fd lockFile.
       01 lRecord                      pic x.
       fd iFile.
       01 iRecord                      pic x(1000).
       fd listFile.
       01 listFileRecord.
           02 lfr-directiveName        pic x(100).
           02 lfr-realName             pic x(3120).
       fd uniqueNumber.
       01 uniqueNumberRecord           pic 9(6).
       fd oFile.
       01 oRecord                      pic x(1000).
      *--------------------------------------------------
       working-storage section.
      *--misc items for file management
       01 stFic                        pic xx.
       01 rc                           pic 9(9).
       01 lockFileName                 pic x(3120).
       01 iFileName                    pic x(3120).
       01 listFileName                 pic x(3120).
       01 uniqueNumberName             pic x(3120).
       01 keyNumber                    pic 9 value 1.
       01 oFileName                    pic x(3120).
      * 01 wrkspcFileName               pic x(3120). 
      *--command line
       01 cmdline                      pic x(1024).
      *--command line arguments
       01 dataTbParam.
           03 nbParam                  pic 9(4).
           03 tbParam                  pic x(3120) occurs 100.
       01 listFileNameArg              pic x(100).
       01 thinClientMode               pic xxx.
      *--number of parameters in linkage section if any
       01 num-param                    pic 9(5) usage is comp-1.
      *--file and project names infos
       01 prjDir                       pic x(100).
       01 sourceFilePath               pic x(100).
       01 srcName                      pic x(100).
       01 baseSrcName                  pic x(100).
       01 extSrcName                   pic x(100).
       01 extSrcNameLow                pic x(100).
       01 tmpDirname                   pic x(3120).
      *--compilation flags
       01 cobFlags                     pic x(100).
       01 cobFlagsDelimited            pic x(100).
       01 cobFlagsFileName             pic x(3120).
      *--copy dirs list
       01 dataTbCopyDir.
           78 maxNbCopyDir             value 1000.
      * Roch Rolland - 12/2004 - Begin ( value 0 )
           03 nbCopyDir                pic 9(4) value 0.
      * Roch Rolland - 12/2004 - End
           03 tbCopyDir                pic x(3120) occurs maxNbCopyDir.
      *--for 'include's processing
       01 iRecordLow                   pic x(1000).
       01 tbRecord.
           03 tbRec                    pic x(100) occurs 10.
       01 tbRecordL.
           03 tbRecL                   pic x(100) occurs 10.
       01 includeFileName              pic x(3120).
       01 includeFilePath              pic x(3120).
      *--compilation command
       01 compileCmd                   pic x(1000).
       01 compileStatus                pic 9(5).
      *--various flags about the server
       01 flagServerPresent            pic x(3).
       01 serverName                   pic x(64).
       01 serverTime                   pic 9(8).
       01 serverTmpPath                pic x(1000).
       01 serverProcobStart            pic x(1000).
       01 serverObjPath                pic x(1000).
       01 flagAcuLocalDest             pic x(3).
      *--for 'accept system-information ...'
       01 system-information.
           03 operating-system         pic x(10).
           03 user-id                  pic x(12).
           03 station-id               pic x(12).
           03 has-indexed-read-previous pic x.
           03 has-relative-read-previous pic x.
           03 can-test-input-status    pic x.
           03 is-multi-tasking         pic x.
           03 runtime-version.
              05  runtime-major-version pic 99.
              05  runtime-minor-version pic 99.
              05  runtime-release      pic 99.
           03 is-plugin                pic x.
           03 serial-number            pic x(20).
      *--for extended errors code
       01 errParam1                    pic x(5).
       01 errParam2                    pic x(80).
      *--for c$fileinfo
       01 file-info.
           02 file-size                pic x(8) comp-x.
           02 file-date                pic 9(8) comp-x.
           02 file-time                pic 9(8) comp-x.
       01 status-code                  pic 9.
      *--for c$system
       01 cmd-line                     pic x(1024).
       01 exit-status                  pic 9(5).
       01 flags                        usage unsigned-int.
       78  csys-hidden                 value 32.
       78  csys-shell                  value 64.
       78  csys-minimized              value 8.
      *--for c$listdir
       78 listdir-open                 value 1.
       78 listdir-next                 value 2.
       78 listdir-close                value 3.
       01 op-code                      pic 99 comp-x.
       01 dirName                      pic x(3120).
       01 dirHandle                    usage handle.
      *--for c$chdir
       01 err-num                      pic 9(9) comp-4.
      *--for file copy
       01 source-file                  pic x(100).
       01 dest-file                    pic x(100).
      *--for cbl_copy_file
       01 copy-status                  pic 9.
      *--for rename
       01 rename-status                pic 9(9) comp-4.
      *--for $mkdir
       01 dir-name                     pic x(3120).
      *--misc index and temp variables
       01 pInc                         pic 9(4).
       01 i                            pic 9(9).
       01 j                            pic 9(9).
       01 k                            pic 9(9).
       01 l                            pic 9(9).
       01 tmp.
        05 tmp-1car                    pic x.
        05 tmp-ncar                    pic x(3119).
       01 tmp2                         pic x(3120).
       01 tmp3                         pic x(3120).
       01 tmp4                         pic x(3120).
       01 tmp5                         pic x(31200).
       01 tmp6                         pic x(3120).
      *--
       01 serverProcobSh               pic x(200).
      *--for directives generation
       01 extDestName                  pic x(100).
       01 preprocDir                   pic x(80).
      * 01 preprocDir2                  pic x(80).
       01 flagBegin                    pic x(3).
       01 flagMsgWait                  pic x(3).
      * 01 flagWriten                   pic x(3).
       78 ppDirBegin1
           value '      *(( PREPROC BOOMERANG LINE BEGIN 1 ))'.
       78 ppDirEnd1
           value '      *(( PREPROC BOOMERANG LINE END 1 ))'.
      *--for file names mapping
       01 dataTbNamesMapping.
         78 maxTbNamesMapping          value 1000.
         02 nbNamesMapping             pic 9(6).
         02 occurs maxTbNamesMapping.
           03 nm-directiveName         pic x(100).
           03 nm-realName              pic x(100).
      *--for sql error checking
       78 libErrOracle                 value 'Error at line'.
       01 flagErrOracle                pic x(3) value 'no '.
      *--message display
       01 heure.
           03 hh                       pic 99.
           03 mm                       pic 99.
           03 ss                       pic 99.
           03 cc                       pic 99.
       01 msg                          pic x(512).
       01 msgTmp                       pic x(512).
       01 msgStruct.
           02 msgLine                  pic x(6).
           02 msgFicName               pic x(100).
      *--

      * Roch Rolland - 12/2004 - Begin
       77 tmp-Copypath                 pic x(3120).
       77 tbCopyDir-Ptr                pic s9(4) comp value 1.
       77 analyse-Copypath             pic x value "N". 
          88 analyse-Copypath-ended    value "Y".
       78 stringCopypath-Null          value ";(null)".
       77 nameOfErrorFile              pic x(3120).
       77 stringSwitchError            pic x(3120).
       77 numberOfAtCaracter           pic 9(4).
       77 typeOfPathFile               pic x(3120).
       77 typeOfPath                   pic 9.
          88 typeOfPathAbsolute        value 0.
          88 typeOfPathRelative        value 1.
       77 typeOfParam                  pic 9.
          88 typeOfParamFile           value 0.
          88 typeOfParamNoFile         value 1.
       77 listPathName                 pic x(3120) value space.
       77 stringSwitchList             pic x(3120) value space.
       77 errorFileFlag                pic 9.
         88 errorFileFlagInArgs        value 0.
         88 errorFileFlagNotInArgs     value 1.
      * 01 sourcePathTmp                pic x(3120) value space.
      * 01 sourcePath                   pic x(3120) value space.
      * 01 listpath                     pic x(3120) value space.
      * 01 buildPath                    pic x(3120) value space.
      * 01 basecopyPath                 pic x(3120) value space.
      * Roch Rolland - 12/2004 - End

      *--
       01 objectPathTmp                pic x(3120) value space.
       01 objectPath                   pic x(3120) value space.
      *--for path name correction
       01 correctPathData              pic x(3120) value space.
       01 cpNew                        pic x(3120) value space.
       01 cpi                          pic 9(9).
       01 cpj                          pic 9(9).
       01 cpD                          pic 9(9).
      *--------------------------------------------------
       linkage section.
      *--number of parameters received
       78 lnkNbParam                   value 7.
       78 lnkNbParClean                value 2.
      *--function id
       01 lnkFlagServer                pic x(10).
       78 flagServer                   value "serverSide".
       78 flagCleanSrv                 value "srvClean  ".
      *--precompilation path script
       01 lnkServerProcobSh            pic x(200).
      *--current task id for function 'srvClean'
       01 lnkNum redefines lnkServerProcobSh pic 9(6).
      *--file names info
       01 lnkBaseSrcName               pic x(100).
       01 lnkExtSrcName                pic x(100).
       01 lnkExtDestName               pic x(100).
      *--current task id for function 'serverSide'
       01 lnkUniqueNumber              pic 9(6).
      *--needed only for a coherent arguments number
       01 lnkDummyParam                pic x.
      *--------------------------------------------------
       procedure division using lnkFlagServer lnkServerProcobSh 
           lnkBaseSrcName lnkExtSrcName lnkExtDestName
           lnkUniqueNumber lnkDummyParam.
       main section.
           perform setEnvironment
           perform getOsInfo
      * Roch Rolland - 12/2004 - Begin
           perform checkNumParam
           if operating-system not = 'Unix'
                  perform getCmdLineParams
           end-if
      * Roch Rolland - 12/2004 - End

           |display message 'début' cmdline
           |--decides what part must be executed
           evaluate true
               |--the number of parameters says it's the server part
               when num-param = lnkNbParam
                 and operating-system = 'Unix' perform serverpart
               |--the number of parameters says it's the clean server part
               when num-param = lnkNbParClean
                 and operating-system = 'Unix' perform cleanServerpart
               |--the -Po option says it's called by the compiler
               when tbParam(1) = '-Po'         perform preCompilePart
               |--nothing else possible that the client part
               when other                      perform clientPart
           end-evaluate
           goback. 
      *--------------------------------------------------
      * necessary for files usage in this session
       setEnvironment.
           set environment 'STRIP_TRAILING_SPACES' to '1'
           set environment 'FILE_PREFIX' to '.'
           set environment "ERRORS_OK" to "1".
      *--------------------------------------------------
      * puts the command line options in a table
       getCmdLineParams.

           accept cmdline from command-line

           initialize dataTbParam
           move 1 to pInc nbParam
           perform until pInc >= length of cmdLine
               unstring cmdLine delimited all space
                   into tbParam(nbParam)
                   pointer pInc
               end-unstring
               add 1 to nbParam
           end-perform
           subtract 1 from nbParam.

      *--------------------------------------------------
      * takes the number of parameters in linkage/command line
       checkNumParam.
           call "c$narg" using num-param.
      *--------------------------------------------------
      * this part runs on the server
       serverpart.
           if lnkFlagServer = flagServer
               |--start precompilation script
               initialize cmd-line
               string lnkServerProcobSh delimited space
                   " " delimited size 
                   lnkBaseSrcName delimited space
                   " " delimited size 
                   lnkExtSrcName delimited space
                   " " delimited size 
                   lnkExtDestName delimited space
                   " " delimited size 
                   lnkUniqueNumber delimited space
                   into cmd-line
               call "c$system" using cmd-line giving exit-status
               |--
               move exit-status to return-code
           end-if.
      *--------------------------------------------------
      * this part is called by the compiler with -Po option
       preCompilePart.
           perform precParseSourceFileName
           |--precompilation is done only for a main source file
           if tbParam(2) = 'acu__pp1.out'
               perform precCreateFile
               perform precPrepDirective
               perform precInsertDirective
               perform precExtendListFile
           else
               perform precCopyFile
               |--insert directives only if copy member exists
               if status-code = 0
                 perform precPrepDirective
                 perform precInsertDirective
                 perform precExtendListFile
               end-if
           end-if.
           |--

      *--------------------------------------------------
       precParseSourceFileName.
           |--keep the whole path
           move tbParam(nbParam) to sourceFilePath
           |--search the file name part
           perform varying i from length of tbParam(nbParam) by -1
           until i=0 or tbParam(nbParam)(i:1)="\"
               continue
           end-perform
           compute l = length of tbParam(nbParam) - i
           add 1 to i
           move tbParam(nbParam)(i:l) to srcName
           |--search the base and extension name part
           perform varying i from 1 by 1
           until srcName(i:1)="." or space
               continue
           end-perform
           subtract 1 from i
           move srcName(1:i) to baseSrcName
           add 2 to i
           compute l = length of srcName - i
           move srcName(i:l) to extSrcName extSrcNameLow tmp
           |--have the lower case version
           call "C$TOLOWER" using extSrcNameLow 
               by value length of extSrcNameLow
           |--
           perform computeNewExtName
           move tmp to extDestName.
      *--------------------------------------------------
      * the compiler needs a file named 'acu_ppx.out' so
      * this part prepares it by renaming the copy
      * of the source file existing in the tmp directory
       precCreateFile.
           initialize tmp
           if extSrcNameLow = 'pco'
               string baseSrcName delimited space
                   '.' delimited size
                   extDestName delimited space
                   into tmp
           else
               move srcName to tmp
           end-if
           call "rename" using tmp tbParam(2)
               rename-status.
      *--------------------------------------------------
      * takes a copy of the initial source file in the tmp dir
       precCopyFile.
           call "c$fileinfo" using tbParam(6) file-info 
               giving status-code
           if status-code = 0
               call "cbl_copy_file" using tbParam(6) tbParam(2)
                   giving copy-status
               if copy-status not = 0
                   move 2 to rc
               end-if
           end-if.
      *--------------------------------------------------
      * prepares a FILE directive for the compiler
       precPrepDirective.
           initialize preprocDir
           string 
               '      *(( PREPROC BOOMERANG FILE "' delimited size
               srcName delimited space
               '" ))' delimited size
               into preprocDir.
      *--------------------------------------------------
      * insert the FILE directive in the source file. This
      * is done by writing that as the first line and writing
      * all the initial lines by reading thru the source file
       precInsertDirective.
           move tbParam(2) to iFileName
           initialize oFileName
           string iFileName '.tmp' delimited space
               into oFileName
           open input iFile
           if stFic = '00' open output oFile
           |--write it on the top of the new file
           if stFic = '00'
               move preprocDir to oRecord
               write oRecord
               move ppDirBegin1 to oRecord
               write oRecord
           end-if
           |--reading loop
           initialize i
           perform until stFic not = "00"
               initialize oRecord
               read iFile next
               at end 
                   close iFile oFile
                   |--deletes the initial file
                   delete file iFile
                   |--renames the new file with the initial name
                   call "rename" using oFileName iFileName
                       rename-status
                   |--
                   move all high-value to stFic
               not at end
                   move iRecord to oRecord
                   write oRecord
                   add 1 to i
                   |--writes one 'END' after the first line
                   |--(this is done to correct a compiler lines numbering bug)
                   if i = 1
                       move ppDirEnd1 to oRecord
                       write oRecord
                   end-if
                   |--
               end-read
           end-perform.
      *--------------------------------------------------
      * keeps track of the full path of a file. Useful because
      * the FILE directive cannot exceed 80th column
       precExtendListFile.
           move 'preprocList' to listFileName
           open extend listFile
           if stFic = '00' or '05'
               move srcName to lfr-directiveName
               move sourceFilePath to lfr-realName
               write listFileRecord
               close listFile
           end-if.
      *--------------------------------------------------
      * this part is called on the client side by boomerang.cmd
       clientPart.

      *    Roch Rolland - begin - 12/2004
      *    Now to simplify the Boomerang process, if the source
      *    file is not a pco file and the Thin Client mode isn't
      *    selected, we made a standard compilation.
      *    This treatment is made by the new typeOfCompilation
      *    paragraph.
           perform typeOfCompilation
      *    Roch Rolland - end   - 12/2004

           initialize rc
           perform getprjDir

      * Roch Rolland - 12/2004 - Begin
      *     perform analyzeArgs
      *     perform checkCmdLineParams
      *     if rc = 0 perform parseSourceFileName end-if
      *     if rc = 0 perform analyzeArgs end-if
      *     if rc = 0 perform deleteListFiles end-if
      *     if rc = 0 perform analyzeCmdLineParams end-if
            if rc = 0 perform analyzeCmdLineParams end-if
            if rc = 0 perform deleteListFiles end-if
      * Roch Rolland - 12/2004 - End

           if rc = 0 perform checkEnvironment end-if
           if rc = 0 perform buildEnvironment end-if
           if rc = 0 perform checkSourceFile end-if
           if rc = 0 perform checkServerPresent end-if
           if rc = 0 perform checkPossible end-if
           if rc = 0 perform deleteAcuFile end-if

      * Roch Rolland - 12/2004 - Begin
      *     if rc = 0 perform checkCopyPath end-if
      * Roch Rolland - 12/2004 - End

           if rc = 0 perform lockClientStation end-if
           if rc = 0 perform createTmpDirName end-if
           if rc = 0 perform deleteTmpDir end-if
           if rc = 0 perform createTmpDir end-if
           if rc = 0 perform goTmpDir end-if
           if rc = 0 perform getCobFlags end-if
           if rc = 0 perform getCopyPaths end-if
           if rc = 0 perform genSource end-if
           if rc = 0 perform detectIncludes end-if
           if rc = 0 perform getUniqueNumber end-if
           if rc = 0 perform downloadFile end-if
           if rc = 0 perform precompFile end-if
           if rc = 0 perform uploadFile end-if
           if rc = 0 perform loadNamesMapping end-if
           if rc = 0 perform checkPrecompOutput end-if
           if rc = 0 perform prepLinesDirectives end-if
           if rc = 0 perform prepCompile end-if
           if rc = 0 perform doCompile end-if
           if rc = 0 perform loadNamesMapping end-if
           if rc = 0 perform displayErrors end-if
           if rc = 0 perform putAcuFile end-if
           perform goBackPrjDir
           perform deleteTmpDir
           perform deleteRemoteTmpDir
           perform unlockClientStation
           move rc to return-code.
      *--------------------------------------------------
       getOsInfo.
           accept system-information from system-info.
      *--------------------------------------------------
      * gets the project directory
       getprjDir.
           call "c$chdir" using prjDir.

      * Roch Rolland - 12/2004 - begin
      *--------------------------------------------------
      * checkCmdLineParams.
      *     accept tmp from environment 'CHECKOPTIONS'
      *     if tmp not = 'no'
      *         perform checkCmdLineParams2
      *     else
      *         move 
      *         'compilation options not verified and not used'
      *             to msg
      *         perform displayWarningMessage
      *     end-if.
      **--------------------------------------------------
      * checkCmdLineParams2.
      *     if nbParam not = 6
      *         move 'project compilation options not correct'
      *             to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if
      *     if tbParam(nbParam) = spaces
      *         move '6th parameter empty' to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if
      *     if tbParam(1) not = '-o'
      *         move '1st parameter not = -o' to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if
      *     if tbParam(3) not = '-x'
      *         move '3th parameter not = -x' to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if
      *     if tbParam(4) not = '-Lo'
      *         move '4th parameter not = -Lo' to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if.
      * Roch Rolland - 12/2004 - end

      *--------------------------------------------------
      * gets some file name information from the command line parameters
       analyzeCmdLineParams.
           perform varying i from 1 by 1 until i > nbParam
               |--from the last parameter
      * Roch Rolland - 12/2004 - Begin
      *         if i = nbParam
      *             perform getSourcePath
      *             perform getBuildPath
      *         end-if
      * Roch Rolland - 12/2004 - End
               |--from -o
               if tbParam(i) = '-o'
                   perform getObjectPath
                   perform getServerName
                   perform getServerObjPath
               end-if
               |--from -Lo
               if tbParam(i) = '-Lo'
                   perform getListPath
               end-if
           end-perform.

      * Roch Rolland - 12/2004 - Begin

      *--------------------------------------------------
      * deduces source path from full path name of the file
      * getSourcePath.
      *     move tbparam(i) to sourcePathTmp
      *     perform varying j from length of sourcePathTmp by -1
      *     until j=0 or sourcePathTmp(j:1) = '\'
      *           continue
      *     end-perform
      *     compute l = length of sourcePathTmp - j
      *     compute j = j - 1 
      *     move sourcePathTmp(1:j) to sourcePath. 
      **--------------------------------------------------

      * Roch Rolland - 17/02/2004 - End

      * Roch Rolland - 14/12/2004 - Begin

      * constructs the build path from source path plus '\build'
      * getBuildPath.
      *     perform varying i from length of sourcePath by -1
      *     until i=0 or sourcePath(i:1) = '\'
      *           continue
      *     end-perform
      *     compute l = length of sourcePath - i
      *     compute i = i - 1 
      *     string sourcePath(1:i) 
      *            '\build' delimited by size
      *     into buildPath
      *     string sourcePath(1:i) delimited by size
      *     into basecopyPath.

      * Roch Rolland - 12/2004 - End

      *--------------------------------------------------
      * deduces object path from full path name of the file
       getObjectPath.
           compute j= i + 1
           move tbparam(j) to objectPathTmp
           perform varying j from length of objectPathTmp by -1
           until j=0 or objectPathTmp(j:1) = '\' or '/'
                 continue
           end-perform
           compute l = length of objectPathTmp - j
           compute j = j - 1 
           move objectPathTmp(1:j) to objectPath tmp
           |--if it is relative, assume it's from project directory
           if objectPath(1:1)= '.'
               string prjDir '\' tmp delimited space
                   into objectPath
           end-if
           |--checks if the object file is wanted locally
           initialize flagAcuLocalDest
           accept tmp from environment 'ACULOCALDEST'
           if tmp not = spaces and thinClientMode = 'yes'
               move tmp to objectPath
               move 'yes ' to flagAcuLocalDest
           end-if.
      *--------------------------------------------------
      * deduces the server name from acurfap notation
       getServerName.
           initialize serverName tmp tmp2
           compute j= i + 1
           move tbparam(j) to tmp
           perform varying j from 1 by 1 
           until j not < length of tmp
               if tmp(j:2)='//'
                   add 2 to j
                   compute k= length of tmp - j
                   move tmp(j:k) to tmp2
                   move length of tmp to j
               end-if
           end-perform
           perform varying j from 1 by 1 
           until j > length of tmp2
               if tmp2(j:1)=':' or tmp2(j:1)='/'
                   subtract 1 from j
                   move tmp2(1:j) to serverName
                   move length of tmp2 to j
               end-if
           end-perform.
      *--------------------------------------------------
      * constructs the server object path with an Acuconnect notation
       getServerObjPath.
           initialize serverObjPath
           perform varying j from length of objectPath by -1
           until j= 0
               if objectPath(j:1) = ':'
                   add 1 to j
                   compute k= length of objectPath - j
                   string '@' serverName ':' objectPath(j:k)
                       delimited by space into serverObjPath
                   move 0 to j
               end-if
           end-perform.
      *--------------------------------------------------
      * gets the path of the compilation listing file (.lst)
       getListPath.

      * Roch Rolland - 12/2003 - Begin
      * This Paragraph was completely rebuilt
           compute j= i + 1
           move tbparam(j) to typeOfPathFile
           perform typeOfPathParagrah
           if typeOfPathAbsolute
           then
                move tbparam(j) to listPathName
           else
               if tbparam(j)(1:1) = '.'
                string prjdir '\' tbparam(j)(3:length of tbparam(j) - 2) 
                   delimited by space
                    into listPathName
               else
                 string prjdir '\' tbparam(j)
                   delimited by space
                    into listPathName
               end-if
            end-if

           move listPathName to tmp
           perform replaceAtCaracter
           move tmp to listPathName.
      * Roch Rolland - End - 12/2004


      *--------------------------------------------------

      * Roch Rolland - 12/2004 - Begin
      * path name in 'correctPathData' normalization (\\ replaced by \)
      * correctPath.
      *     move 1 to cpD
      *     perform varying cpi from 1 by 1 
      *     until cpi > length of correctPathData
      *         if cpi < length of correctPathData
      *             compute cpj= cpi + 1
      *             evaluate true
      *             when correctPathData(cpi:1) = '\'
      *             and correctPathData(cpj:1) = '\'
      *                 add 1 to cpi
      *             end-evaluate
      *         end-if
      *         move correctPathData(cpi:1) to cpNew(cpD:1)
      *         add 1 to cpD
      *     end-perform
      *     move cpNew to correctPathData.
      * Roch Rolland - 12/2004 - End

      *--------------------------------------------------
      * checks some environment variables presence
       checkEnvironment.
           move 'TEMP' to tmp              perform checkEnv
      * Roch Rolland - 12/2004 - Begin
      *     move 'COBFLAGSPATH' to tmp      perform checkEnv
      * Roch Rolland - 12/2004 - End
           move "UNIQUENUMBERNAME" to tmp  perform checkEnv
           move "SERVERTMPPATH" to tmp     perform checkEnv
           move "SERVERPROCOBSTART" to tmp perform checkEnv
           move "SERVERPROCOBSH" to tmp    perform checkEnv
           move 'PCOMPILE' to tmp          perform checkEnv.
      *--------------------------------------------------
       checkEnv.
           accept tmp2 from environment tmp
           if tmp2 = spaces
               initialize msg
               string 'environment variable ' delimited size
                   tmp delimited space
                   ' missing in the project environment'
                       delimited size
                   into msg
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
      * builds up some Acuserver names from environment
       buildEnvironment.
           initialize uniqueNumberName
           accept tmp from environment "UNIQUENUMBERNAME"
           string '@' serverName ':' tmp
               delimited by space into uniqueNumberName
           initialize serverTmpPath
           accept tmp from environment "SERVERTMPPATH"
           string '@' serverName ':' tmp
               delimited by space into serverTmpPath
           initialize serverProcobStart
           accept tmp from environment "SERVERPROCOBSTART"
           string '*' serverName ':' tmp
               delimited by space into serverProcobStart.
      *--------------------------------------------------
      * checks source file present
       checkSourceFile.
           call "c$fileinfo" 
               using tbParam(nbParam) file-info giving status-code
           if status-code not = 0
               initialize msg
               string 'source file "' delimited size
                   tbParam(nbParam) delimited space
                   '" not present or not accessible !' delimited size
                   into msg
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
       parseSourceFileName.
           move tbParam(nbParam) to sourceFilePath
           |--search the file name part
           perform varying i from length of tbParam(nbParam) by -1
           until i=0 or tbParam(nbParam)(i:1)="\"
               continue
           end-perform
           compute l = length of tbParam(nbParam) - i
           add 1 to i
           move tbParam(nbParam)(i:l) to srcName
           |--search the base and extension name part
           perform varying i from 1 by 1
           until srcName(i:1)="." or space
               continue
           end-perform
           subtract 1 from i
           move srcName(1:i) to baseSrcName
           add 2 to i
           compute l = length of srcName - i
           |--have it in lower case
           move srcName(i:l) to extSrcName extSrcNameLow tmp
           call "C$TOLOWER" using extSrcNameLow 
               by value length of extSrcNameLow
           |--
           perform computeNewExtName
           move tmp to extDestName.
      *--------------------------------------------------
      * computes a .cob extension with exactly the same case
      * that the .pco initial file (ex: 'Pco' gives 'Cob')
       computeNewExtName.
           if tmp(1:1) = 'p' move "c" to tmp(1:1) end-if
           if tmp(1:1) = 'P' move "C" to tmp(1:1) end-if
           if tmp(1:1) = 'c' move "c" to tmp(1:1) end-if
           if tmp(1:1) = 'C' move "C" to tmp(1:1) end-if
           if tmp(2:1) = 'c' move "o" to tmp(2:1) end-if
           if tmp(2:1) = 'C' move "O" to tmp(2:1) end-if
           if tmp(2:1) = 'b' move "o" to tmp(2:1) end-if
           if tmp(2:1) = 'B' move "O" to tmp(2:1) end-if
           if tmp(3:1) = 'o' move "b" to tmp(3:1) end-if
           if tmp(3:1) = 'O' move "B" to tmp(3:1) end-if
           if tmp(3:1) = 'l' move "b" to tmp(3:1) end-if
           if tmp(3:1) = 'L' move "B" to tmp(3:1) end-if.
      *--------------------------------------------------

      * Roch Rolland - Begin - 12/2004
      * analyses the command line arguments
      * analyzeArgs.
      *     move 'no' to thinClientMode
      *     perform varying i from 1 by 1 until i > nbParam
      *         evaluate tbParam(i)
      *
      ** Roch Rolland - 15/12/2004 - Begin
      **         when '-Lo'
      **             compute j= i + 1
      **             move tbParam(j) to listFileNameArg
      ** Roch Rolland - 15/12/2004 - End
      *
      *         when '-o'
      *             compute j= i + 1
      *             if tbParam(j)(1:7) = 'acurfap'
      *                 move 'yes' to thinClientMode
      *             end-if
      *         end-evaluate
      *     end-perform
      *
      **     if listFileNameArg = spaces
      **         move 'needs a -Lo compilation parameter' to msg
      **         perform displayFatalMessage
      **         move 2 to rc
      **     end-if
      *
      *     if thinClientMode = spaces
      *         move 'needs a -o compilation parameter' to msg
      *         perform displayFatalMessage
      *         move 2 to rc
      *     end-if.
      *--------------------------------------------------
      * Roch Rolland - End - 12/2004

      * ensures Acuserve presence if we are in thin client mode
       checkServerPresent.
           if thinClientMode = 'yes'
               move 'no ' to flagServerPresent
               call "c$ping" using serverName serverTime
               if return-code  = 0
                   move 'yes' to flagServerPresent
               else
                   initialize msg
                   evaluate return-code
                   when 3 move 'connection_refused' to tmp
                   when 4 move 'version_error' to tmp
                   when 5 move 'socket_error' to tmp
                   when other move 'error' to tmp
                   end-evaluate
                   move return-code to tmp2
                   string 'acuserve ' delimited size
                       tmp delimited space
                       ' (error ' delimited size
                       tmp2 delimited space
                       ')' delimited size
                       into msg
                   inspect msg replacing all '_' by space
                   perform displayFatalMessage
                   move 2 to rc
               end-if
           end-if.
      *--------------------------------------------------
      * checks precompilation possible
       checkPossible.
           move serverName to tmp
           if tmp = space
               move 'a_server' to tmp
           end-if
           if extSrcNameLow = 'pco' and flagServerPresent not = 'yes'
               initialize msg
               string 
               'impossible to precompile without ' delimited size
               tmp delimited space
                   into msg
               inspect msg replacing all '_' by space
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
      * after the checking and as the compilation could succeed,
      * deletes the object file on the server
       deleteAcuFile.
           |--NB: could be weak; would check additionnaly 'thinClientMode' ?
           if flagServerPresent = 'yes'
               initialize dest-file
               string serverObjPath '/' baseSrcName '.acu' 
                   delimited space into dest-file
               call "cbl_delete_file" using dest-file 
                   giving copy-status
           end-if.
      *--------------------------------------------------
      * deletes the list files in the list directory (file.*)
      * needs an OS command for that, as cobol routines cannot delete a branch
       deleteListFiles.

      * Roch Rolland - Begin - 12/2004

           initialize cmd-line
           string 'del/f ' delimited by size
               listPathName delimited by low-value
               into cmd-line

      *     initialize tmp tmp2
      *     unstring listFileNameArg delimited all '@' 
      *         into tmp tmp2
      *     initialize cmd-line
      *     string 'del/f ' delimited size
      *         tmp delimited space
      *         baseSrcName delimited space
      *         tmp2 delimited space
      *         into cmd-line
      * Roch Rolland - End - 12/2004

           compute flags= csys-hidden + csys-shell
           call "c$system" using cmd-line flags giving exit-status
           if exit-status not = 0
               continue
           end-if

      * Roch Rolland - Begin - 12/2004
           move listPathName to oFileName

      *     string tmp delimited space
      *         baseSrcName delimited space
      *         tmp2 delimited space
      *         into oFileName

      * Roch Rolland - End - 12/2004

           open output oFile
           if stFic = '00' or '05'
               move 'new compilation started' to oRecord
               write oRecord
               close oFile
           end-if.
      *--------------------------------------------------

      * Roch Rolland - 12/2004 - Begin
      * the COPYPATH variable can unfortunately be put by Acubench automatically
      * checkCopyPath.
      *     initialize tmp
      *     accept tmp from environment 'COPYPATH'
      *     if tmp not = spaces and ';;'
      *         initialize msg
      *         string 'forbidden (and not used) COPYPATH='
      *                 delimited size
      *             tmp delimited space
      *             ' in project environment' delimited size
      *             into msg
      *         perform displayWarningMessage
      *     end-if.
      * Roch Rolland - 12/2004 - End


      *--------------------------------------------------
      * be sure that one compilation only is in progress on
      * one client machine. This is done by attempting to lock
      * a file on the client station, and keeping this file opened
      * while the work is pending
       lockClientStation.
           initialize stFic lockFileName flagMsgWait
           accept tmp from environment 'TEMP'
           string tmp delimited space
               '\boomerangLock.dat' delimited size
               into lockFileName
           perform test after until stFic = "00" or "05"
               open i-o lockFile
               if stFic = '93' and flagMsgWait not = 'yes'
                   initialize msg
                   string 'another compilation '
                       'in progress, waiting..'
                       delimited by size into msg
                   perform displayWarningMessage
                   move 'yes' to flagMsgWait
                   accept omitted before time 10
               end-if
               if stFic not = "00" and "05" and "93"
                   call "c$rerr" using errParam1 errParam2
                   initialize msg
                   string 'lock file status= '
                       errParam1 " " errParam2
                       delimited size into msg
                   perform displayFatalMessage
      * Roch Rolland - Begin - 12/2004
      * Without this instruction, we can stay in the loop
      * undefinitaly.
                   move "00" to stFic
      * Roch Rolland - End - 12/2004
                   move 2 to rc
               end-if
           end-perform.
      *--------------------------------------------------
      * releases the lock on the client station
       unlockClientStation.
           close lockFile
           |--the delete is potentially weak, but so clean
           delete file lockFile.
      *--------------------------------------------------
      * creates the tmp dir name on the client station, 
      * using the content of %TEMP%, and the name of the file
       createTmpDirName.
           accept tmp from environment 'TEMP'
           initialize tmpDirName
           string tmp delimited space
               '\boomerang' delimited size
               baseSrcName delimited space
               into tmpDirName.
      *--------------------------------------------------
      * deletes the tmp directory on the client side
       deleteTmpDir.
           initialize cmd-line tmp
           |--normally never unix
           if operating-system = 'Unix'
               move 'rm -rf' to tmp
           else
               move 'rmdir/s/q' to tmp
           end-if
           string tmp delimited space
               ' ' delimited size 
               tmpDirName delimited space
               into cmd-line
           compute flags= csys-hidden + csys-shell
           call "c$system" using cmd-line flags giving exit-status
           if exit-status not = 0
               |--this is normal, the tmp dir should not exist before
               continue
           end-if.
      *--------------------------------------------------
      * creates the tmp directory on the client side
       createTmpDir.
           call "c$makedir" using tmpDirName giving status-code
           if status-code not = 0
               initialize msg
               string 'cannot create directory "' delimited size
                   tmpDirName delimited space
                   '"' delimited size
                   into msg
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
      * go to the tmp directory. All the job is going to be done here
       goTmpDir.
           call "c$chdir" using tmpDirName err-num
           if err-num not = 0
               move err-num to i
               initialize msg
               string 
                   'chdir temporary directory "' delimited size
                   tmpDirName delimited space
                   '" (error ' i ')' delimited size
                   into msg
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
      * gets the compiler flags
       getCobFlags.

      * Roch Rolland - 12/2004 - Begin
      * The -o, -Lo and -e switches are treated separately
           initialize cobFlags
           perform varying i from 1 by 1 until i >= nbParam
               evaluate tbParam(i)
               when '-o'
               when '-Lo'
               when '-e'
                   add 1 to i
               when other
                   string cobFlags delimited spaces
                     '_' delimited size
                     tbParam(i) delimited spaces
                     into cobFlags                       
               end-evaluate
           end-perform
           inspect cobFlags replacing all '_' by space.
      * Roch Rolland - 12/2004 - Begin
      *     initialize cobFlags cobFlagsFileName
      *     |--global parameter in %COBFLAGSPATH%
      *     accept iFileName from environment 'COBFLAGSPATH'
      *     open input iFile
      *     if stFic = "00" 
      *         read iFile next
      *         not at end 
      *             move iFileName to cobFlagsFileName
      *         end-read 
      *         close iFile
      *     end-if
      *     if stFic not = "00"
      *         initialize msg
      *         string 
      *             'cobflags file "' delimited size
      *             iFileName delimited space
      *             '" (error ' stFic ')' delimited size
      *             into msg
      *         perform displayfatalMessage
      *         move 2 to rc
      *     else
      *         move iRecord to cobFlags
      *     end-if
      *     |--global parameter in the project directory
      *     initialize iFileName iRecord
      *     string buildPath delimited space
      *         '\COBFLAGS.bldacu' delimited size
      *         into iFileName
      *     open input iFile
      *     if stFic = "00" 
      *         if stFic = "00" 
      *             read iFile next
      *             not at end 
      *                 move iFileName to cobFlagsFileName
      *             end-read
      *             close iFile
      *         end-if
      *         if stFic not = "00"
      *             initialize msg
      *             string 
      *                 'cobflags file "' delimited size
      *                 iFileName delimited space
      *                 '" (error ' stFic ')' delimited size
      *                 into msg
      *             perform displayFatalMessage
      *             move 2 to rc
      *         else
      *             move iRecord to cobFlags
      *         end-if
      *
      *     end-if.
      * Roch Rolland - 14/12/2004 - End           

      *--------------------------------------------------
      * Roch Rolland - 14/12/2004 - Begin

      * Get the list of the Copy Directories
       getCopyPaths.

            
      * Get the list of the Copy directories in COPYPATH var
            initialize tmp-Copypath
            accept tmp-Copypath from environment 'COPYPATH'
            unstring tmp-Copypath delimited by stringCopypath-Null
               into tmp-Copypath
            perform storeCopyPaths 

      * Get the list of Copy Directories in -Sp switch
           initialize tmp-Copypath
           perform varying i from 1 by 1 until i >= nbParam
               evaluate tbParam(i)
               when '-Sp'
                   compute j= i + 1
                   move tbParam(j) to tmp-Copypath
                   perform storeCopyPaths                      
               end-evaluate
           end-perform

           if nbCopyDir not equal zero
           then
            initialize tmp
            perform varying i from 1 by 1 until i > nbCopyDir
               initialize tmp2
               string tmp delimited space
                   tbCopyDir(i) ';' delimited space
                   into tmp2
               move tmp2 to tmp
            end-perform
            initialize msg
            string 
               'copy directories: ' delimited size
               tmp delimited space
               into msg
            perform displayMessage
           end-if.           

      *--------------------------------------------------
       storeCopyPaths.
            move 1 to tbCopyDir-Ptr
            if tmp-Copypath not = spaces and ';;'
               move "N" to analyse-Copypath
               perform until analyse-Copypath-ended
                  add 1 to nbCopyDir
                  unstring tmp-Copypath
                     delimited by ";"
                     into tbCopyDir(nbCopyDir)
                     pointer tbCopyDir-Ptr 
                     on overflow
                       if nbCopyDir >= maxNbCopyDir
                          move 'too much copy' to msg
                          perform displayFatalMessage
                          move 2 to rc
                       end-if
                     not on overflow 
                          move "Y" to analyse-Copypath
                  end-unstring
               end-perform
            end-if.

      * Roch Rolland - 12/2004 - End

      * Roch Rolland - 12/2004 - Begin
      * creates a list of the COPY directories (the content of
      * '\build\COPYPATH.bldacu')
      *getCopyPaths.
      *     initialize dataTbCopyDir
      *     |--COPYPATH.bldacu file
      *     initialize iFileName iRecord
      *     string buildPath delimited space
      *         '\COPYPATH.bldacu' delimited size
      *         into iFileName
      *     open input iFile
      *     perform until stFic not = "00"
      *         read iFile next
      *         at end 
      *             close iFile
      *             move all high-value to stFic
      *         not at end
      *          if iRecord not equal spaces
      *          then
      *             if nbCopyDir >= maxNbCopyDir
      *                 move 'too much copy' to msg
      *                 perform displayFatalMessage
      *                 move 2 to rc
      *                 close iFile
      *                 move all high-value to stFic
      *             else
      *                 add 1 to nbCopyDir
      *                 |--copy path normalization (made by Roch)
      *                 initialize tmp tab-filename-all
      *                 move 1 to tab-filename-ind
      *                 move 1 to tab-filename-ptr
      *                 string basecopyPath delimited space
      *                     '\' delimited size
      *                    iRecord delimited space
      *                    into tmp
      *                 move "N" to analyse-filename
      *                 perform until analyse-filename-ended
      *                  unstring tmp
      *                   delimited by "\"
      *                   into tab-filename(tab-filename-ind)
      *                   pointer tab-filename-ptr 
      *                   on overflow
      *                     evaluate true
      *                     when tab-filename(tab-filename-ind) = ".."
      *                       subtract 1 from tab-filename-ind
      *                     when tab-filename(tab-filename-ind) = "."
      *                       initialize tab-filename(tab-filename-ind)
      *                     when other
      *                       add 1 to tab-filename-ind
      *                     end-evaluate
      *                   not on overflow
      *                     move "Y" to analyse-filename
      *                  end-unstring
      *                 end-perform
      *                 |--
      *                 move 1 to i
      *                 initialize tmp
      *                 perform until i > tab-filename-ind
      *                  if i not equal tab-filename-ind
      *                  then
      *                     string tmp tab-filename(i)
      *                             delimited by space,
      *                          "\" delimited by size
      *                     into tmp
      *                  else
      *                    string tmp tab-filename(i) delimited by space
      *                    into tmp
      *                  end-if
      *                  add 1 to i
      *                 end-perform                        
      *                 string tmp delimited space
      *                    into tbCopyDir(nbCopyDir)
      *             end-if
      *           end-if
      *         end-read
      *     end-perform
      *     |--
      *     initialize tmp
      *     perform varying i from 1 by 1 until i > nbCopyDir
      *         initialize tmp2
      *         string tmp delimited space
      *             tbCopyDir(i) ';' delimited space
      *             into tmp2
      *         move tmp2 to tmp
      *     end-perform
      *     initialize msg
      *     string 
      *         'copy directories: ' delimited size
      *         tmp delimited space
      *         into msg
      *     perform displayMessage
      *     initialize msg
      *     string ' (from ' delimited size
      *         iFileName delimited space
      *         ')' delimited by size
      *         into msg
      *     perform displayMessage
      * Roch Rolland - 12/2004 - End      

      *--------------------------------------------------
      * verify the COPY directory exists, and keep its path
       validateCopyLib.       
           move listdir-open to op-code
           call "c$list-directory" using op-code dirName '*'
           if return-code not = 0
               move return-code to dirHandle
               add 1 to nbCopyDir
               move dirName to tbCopyDir(nbCopyDir)
               move listdir-close to op-code
               call "c$list-directory" using op-code dirHandle
               initialize return-code
           end-if.
      *--------------------------------------------------
      * creates a copy of the source file, with a number in column 81th.
      * This number is there to facilitate a further analysis. So the
      * constraint is that is not possible to use sources containing something
      * within this area. This is a weakness but cannot be avoided at the moment.
       genSource.
           move tbParam(nbParam) to iFileName
           move srcName to oFileName
           initialize i
           open output oFile
           if stFic not = '00'
               initialize msg
               string 
                   'gen source file "' delimited size
                   tbParam(nbParam) delimited space
                   '" (error ' stFic ')' delimited size
                       into msg
                   perform displayFatalMessage
                   move 2 to rc
           else
               |--
               move 'acu__pp1.out' to includeFileName
               move iFileName to includeFilePath
               perform extendListFile
               |--
               open input iFile
           end-if
           perform until stFic not = '00'
               read iFile next
               at end
                   close iFile oFile
                   move srcName to listFileRecord
                   perform prepFileList
                   move all high-values to stFic
               not at end
                   add 1 to i
                   initialize oRecord
                   string iRecord(1:80) i 
                       delimited size into oRecord
                   write oRecord
               end-read
           end-perform.
      *--------------------------------------------------
      * keep the name of that file in a list in a file
       prepFileList.
           string tmpDirname delimited space
               '\listSources' delimited size
               into listFileName
           open extend listFile
           write listFileRecord
           close listFile.
      *--------------------------------------------------
      * a source analysis to see if there are include files to download
       detectIncludes.
           initialize iFileName
           string tmpDirname delimited space
               '\' delimited size
               srcName delimited size
               into iFileName
           open input iFile
           perform until stFic not = "00"
               initialize iRecord
               read iFile next
               at end
                   close iFile
                   move all high-values to stFic
               not at end
                   perform detectIncludesRecord
               end-read
           end-perform.
      *--------------------------------------------------
      * tries to see if there is an include in the current source line
       detectIncludesRecord.
           if iRecord(1:1) not = '*' and iRecord(7:1) not = '*'
               move iRecord to iRecordLow
               call "c$tolower" using iRecordLow 
                   by value length of iRecordLow
               initialize i
               inspect iRecordLow tallying i for all 'exec'
               if i not = 0
                   initialize tbRecord tbRecordL
                   unstring iRecordLow delimited by all space
                       into tbRecL(1) tbRecL(2) 
                       tbRecL(3) tbRecL(4) tbRecL(5)
                       on overflow continue end-unstring
                   unstring iRecord delimited by all space
                       into tbRec(1) tbRec(2) 
                       tbRec(3) tbRec(4) tbRec(5)
                       on overflow continue end-unstring
                   if tbRecL(2) = 'exec'
                   and tbRecL(3) = 'sql'
                   and tbRecL(4) = 'include'
                       move tbRec(5) to includeFileName
                       if includeFileName not = spaces
                           perform processInclude
                       end-if
                       initialize includeFileName
                   end-if
               end-if
           end-if.
      *--------------------------------------------------
      * if there is an include, tries to find it in the COPY
      * directories list.
      * With its proper name at first, with '.cob' extension after
       processInclude.
           perform varying i from 1 by 1 until i > nbCopyDir
               initialize includeFilePath
               string tbCopyDir(i) delimited space
                   '\' delimited size
                   includeFileName delimited space
                   into includeFilePath
               call "c$fileinfo" 
                   using includeFilePath file-info 
                   giving status-code
               if status-code not = 0
                   |--not found, tries with '.cob' extension
                   initialize includeFilePath tmp
                   string tbCopyDir(i) delimited space
                       '\' delimited size
                       includeFileName delimited space
                       '.cob' delimited size
                       into includeFilePath
                   call "c$fileinfo" 
                       using includeFilePath file-info 
                       giving status-code
                   if status-code = 0
                       move includeFileName to tmp
                       string tmp delimited space
                           '.cob' delimited size
                           into includeFileName
                   end-if
               end-if
               if status-code = 0
                   |--found, takes a copy
                   call "cbl_copy_file" 
                       using includeFilePath includeFileName
                       giving copy-status
                   if copy-status = 0
                       move includeFileName to listFileRecord
                       perform prepFileList
                       perform extendListFile
                   end-if
                   move nbCopyDir to i
               end-if
           end-perform.
      *--------------------------------------------------
      * keeps the name of a file and the complete corresponding path
       extendListFile.
           move 'preprocList' to listFileName
           open extend listFile
           if stFic = '00' or '05'
               move includeFileName to lfr-directiveName
               move includeFilePath to lfr-realName
               write listFileRecord
               close listFile
           end-if.
      *--------------------------------------------------
      * be sure to do one compilation at the same time. This
      * is done by getting a unique number from a file on the
      * server, incrementing this number, updating in the file,
      * and using it as a tmp directory name
       getUniqueNumber.
           if flagServerPresent = 'yes'
               perform getUniqueNumber2
           end-if.
       getUniqueNumber2.
           |--be sure to be alone
           initialize stFic i
           perform test after 
           until (stFic = "00" or "05") or rc not = 0
               open i-o uniqueNumber
               evaluate true
               when stFic = '00' or '05'
                   initialize uniqueNumberRecord
                   read uniqueNumber
                       invalid key
                           write uniqueNumberRecord
                   end-read
                   if uniqueNumberRecord = 999999
                       move 0 to uniqueNumberRecord
                   else
                       add 1 to uniqueNumberRecord
                   end-if
                   rewrite uniqueNumberRecord
                   close uniqueNumber
               when stFic = '93'
                   accept omitted before time 10
                   add 1 to i
                   if i > 100
                       move 'server time out (10 seconds)' to msg
                       perform displayMessage
                       move 2 to rc
                   end-if
               when other
                   initialize errParam1 errParam2
                   call "c$rerr" using errParam1 errParam2
                   initialize msg
                   string errParam1 " " errParam2
                       delimited size into msg
                   perform displayMessage
                   move 2 to rc
               end-evaluate
           end-perform.
      *--------------------------------------------------
      * creates an archive containing the usefull files for the
      * precompilation, compress it, and send it to the server
      * in a unique temporary directory
       downloadFile.
           if extSrcNameLow = 'pco' and flagServerPresent = 'yes'
               move 'downloading source files' to msg
               perform displayMessage
               move 'vio32 -oblf listSources sources.vio' to cmd-line
               compute flags= csys-hidden + csys-shell
               call "c$system" using cmd-line flags giving exit-status
               move 'gzip sources.vio' to cmd-line
               compute flags= csys-hidden + csys-shell
               call "c$system" using cmd-line 
                   flags giving exit-status
               if exit-status not = 0
                   initialize msg
                   string '"' delimited size
                       cmd-line delimited space
                       '"' delimited size 
                       into msg

                   perform displayFatalMessage
                   move 2 to rc
               else
                   |--creates the unique directory on the server
                   initialize dir-name
                   string serverTmpPath '/' uniqueNumberRecord 
                       delimited space into dir-name
                   call "c$makedir" using dir-name giving status-code
                   |--
                   if status-code not = 0
                       initialize msg
                       string 
                           'mkdir "' delimited size
                           dir-name delimited space
                           '" (error ' status-code ')' delimited size
                           into msg
                       perform displayFatalMessage
                       move 2 to rc
                   else
                       |--send the gzipped vio file containing the sources
                       initialize source-file dest-file
                       move 'sources.vio.gz' to source-file
                       string serverTmpPath '/' uniqueNumberRecord 
                           '/' 'sources.vio.gz'
                           delimited space into dest-file
                       call "cbl_delete_file" using dest-file
                           giving copy-status
                       call "cbl_copy_file" 
                           using source-file dest-file
                           giving copy-status
                       if copy-status not = 0
                           initialize msg
                           string 
                               'copy file "' 
                                   delimited size
                               dest-file delimited space
                               '" (error ' copy-status ')' 
                                   delimited size
                               into msg
                           perform displayFatalMessage
                           move 2 to rc
                       end-if
                   end-if
               end-if
           end-if.
      *--------------------------------------------------
      * starts the precompilation process
       precompFile.
           if extSrcNameLow = 'pco' and flagServerPresent = 'yes'
               move 'precompiling on the server' to msg
               perform displayMessage
               accept serverProcobSh 
                   from environment "serverProcobSh"
               |--call the server part (by acuconnect)
               call serverProcobStart using flagServer
                   serverProcobSh 
                   baseSrcName extSrcName extDestName
                   uniqueNumberRecord ' '
                   on exception
                       initialize msg
                       string 
                           'calling "' delimited size
                           serverProcobStart delimited space
                           '"' delimited size
                               into msg
                       perform displayFatalMessage
                       move 2 to rc
               end-call
               if return-code not = 0 and 1
                   move return-code to tmp
                   initialize msg
                   string 
                       'procob command return code = ' delimited size
                       serverProcobStart delimited space
                           into msg
                   perform displayFatalMessage
                   move 2 to rc
               end-if
            end-if.
      *--------------------------------------------------
      * gets back the result file, unzip it, unarchive the contained files
       uploadFile.
           if extSrcNameLow = 'pco' and flagServerPresent = 'yes'
               move 'uploading source files' to msg
               perform displayMessage
               initialize source-file dest-file
               move 'results.vio.gz' to dest-file
               string serverTmpPath '/' 
                   uniqueNumberRecord '/' 'results.vio.gz'
                   delimited space into source-file
               call "cbl_copy_file" using source-file dest-file 
                   giving copy-status
               if copy-status not = 0
                   initialize msg
                   string 
                       'copy file "' delimited size
                       source-file delimited space
                       '" (error ' copy-status ')' delimited size
                       into msg
                   perform displayFatalMessage
                   move 2 to rc
               else
                   |--deletes the file on the server
                   call "cbl_delete_file" using source-file
                       giving copy-status
                   |--unzip the retrieved file
                   move 'gzip -d results.vio.gz' to cmd-line
                   compute flags= csys-hidden + csys-shell
                   call "c$system" using cmd-line flags 
                       giving exit-status
                   |--unvio it
                   move 'vio32 -ivnf results.vio>listResults' 
                       to cmd-line
                   compute flags= csys-hidden + csys-shell
                   call "c$system" using cmd-line 
                       flags giving exit-status
                   if exit-status not = 0
                       initialize msg
                       string '"' delimited size
                           cmd-line delimited space
                           '"' delimited size 
                               into msg
                       perform displayFatalMessage
                       move 2 to rc
                   end-if
               end-if
           end-if.
      *--------------------------------------------------
      * check if there was a precompiler error by analyzing procob output
       checkPrecompOutput.
           if flagServerPresent = 'yes'
               initialize iFileName flagErrOracle
               string baseSrcName '.out' delimited space
                   into iFileName
               open input iFile
               perform until stFic not = "00"
                   initialize iRecord
                   read iFile next
                   at end
                       close iFile
                       move all high-values to stFic
                   not at end
                       move length of libErrOracle to i
                       if iRecord(1:i) = libErrOracle
                           move 'yes' to flagErrOracle
                       end-if
                       if flagErrOracle = 'yes'
                       and iRecord not = spaces
                           move iRecord to msg
                           perform displayErrOracle
                       end-if
                   end-read 
               end-perform
               if flagErrOracle = 'yes'
                   move 2 to rc
               end-if
           end-if.
      *--------------------------------------------------
      * generates the LINE directives, by analysing the resulting
      * source. Basically, if the line does not contain a number in
      * column 81, it was generated by the precompiler. So a LINE
      * directive is necessary to have the compiler providing relevant
      * numbers in its error reports
       prepLinesDirectives.
           initialize iFileName
           string baseSrcName '.' extDestName delimited space
               into iFileName
           string iFileName '.tmp' delimited space 
               into oFileName
           open output oFile
           if stFic not = '00'
               initialize msg
               string 
                   'tmp source file "' delimited size
                   oFileName delimited space
                   '" (error ' stFic ')' delimited size
                       into msg
                   perform displayFatalMessage
                   move 2 to rc
           else
               open input iFile
               if stFic not = '00'
                   close oFile
                   move all high-values to stFic
               end-if
           end-if
           initialize i flagBegin
           perform until stFic not = '00'
               read iFile next
               at end
                   close iFile oFile
                   delete file iFile
                   call "rename" using oFileName iFileName
                       rename-status
                   move all High-Values to stFic
               not at end
                   move length of i to j
                   evaluate true
                   |--something in column 81th ?
                   when iRecord(81:j) not = spaces
                       |--LINE BEGIN was done ?
                       if flagBegin = 'yes'
                           |--needs LINE END
                           initialize flagBegin
                           perform prepDirectiveEnd
                           move preprocDir to oRecord
                           write oRecord
                       end-if
                       move iRecord(81:j) to i
                   |--nothing in col 81, and no LINE BEGIN before ?
                   when iRecord(81:j) = spaces
                   and flagBegin not = 'yes'
                       |--LINE BEGIN needed
                       add 1 to i
                       perform prepDirectiveBegin
                       move preprocDir to oRecord
                       write oRecord
                       move 'yes' to flagBegin
                   end-evaluate
                   |--write out the record
                   move iRecord(1:80) to oRecord
                   write oRecord
               end-read
           end-perform.
      *--------------------------------------------------
       prepDirectiveBegin.
           initialize preprocDir
           string 
               '      *(( PREPROC BOOMERANG LINE BEGIN ' 
                   delimited size
               i delimited size
               ' ))' delimited size
               into preprocDir.
      *--------------------------------------------------
       prepDirectiveEnd.
           initialize preprocDir
           string 
               '      *(( PREPROC BOOMERANG LINE END ' 
                   delimited size
               i delimited size
               ' ))' delimited size
               into preprocDir.
      *--------------------------------------------------
      * prepares the compilation command on the station, with -Pg option
       prepCompile.
           initialize compileCmd tmp tmp2 tmp3 tmp4 tmp5
           accept tmp from environment 'PCOMPILE'
           string '-Pg "' delimited size
                 'wrun32 ' delimited size
                 tmp delimited space
                 '"' delimited size
                 low-value delimited size
               into tmp2
           move cobFlags to cobFlagsDelimited
           perform varying i from length of cobFlagsDelimited by -1
           until i < 1 or cobFlagsDelimited(i:1) not = space
               move low-value to cobFlagsDelimited(i:1)
           end-perform
           initialize tmp5
           perform varying i from 1 by 1 until i > nbCopyDir
               move tmp5 to tmp6
               initialize tmp5
               if tmp6 = spaces
                   move tbCopyDir(i) to tmp5
               else
                   string tmp6 ';' tbCopyDir(i)
                       delimited space into tmp5
               end-if
           end-perform

           perform ConstructStringsListError  

           |--if there is no copy
           if tmp5 not equal spaces
           then
             string
               'ccbl32 ' delimited size
               cobFlagsDelimited delimited low-value
               ' ' delimited size
               tmp2 delimited low-value
      * Roch Rolland - 12/2004 - Begin
               stringSwitchError delimited by low-value
               stringSwitchList delimited by low-value
      * Roch Rolland - 12/2004 - End
               ' -o ' delimited size
                 baseSrcName delimited space
                 '.acu ' delimited size
               '-Sp ' delimited size
                 tmp5 delimited space
                 ' ' delimited size
               sourceFilePath delimited space
               into compileCmd
           else
             string
               'ccbl32 ' delimited size
               cobFlagsDelimited delimited low-value
               ' ' delimited size
               tmp2 delimited low-value
      * Roch Rolland - 12/2004 - Begin
                stringSwitchError delimited by low-value
                stringSwitchList delimited by low-value
      * Roch Rolland - 12/2004 - End
               ' -o ' delimited size
                 baseSrcName delimited space
                 '.acu ' delimited size
               sourceFilePath delimited space
               into compileCmd
           end-if.
      *--------------------------------------------------
       doCompile.
           initialize msg
           string 'compiling with ' delimited size
               cobFlagsDelimited delimited low-value
               into msg
           perform displayMessage

      * Roch Rolland - 12/2004 - Begin
      *     initialize msg
      *     string ' (options from ' delimited size
      *         cobFlagsFileName delimited space
      *         ')' delimited by size
      *         into msg
      *     perform displayMessage
      * Roch Rolland - 12/2004 - End

           |--
           compute flags= csys-hidden + csys-shell
           call "c$system" using compileCmd flags giving exit-status
           move exit-status to compileStatus.
      *--------------------------------------------------
      * retrieves the real file names corresponding to the FILE directives
       loadNamesMapping.
           initialize dataTbNamesMapping
           move 'preprocList' to listFileName
           open input listFile
           perform until stFic not = "00" and '05'
               initialize listFileRecord
               read listFile next
               at end
                   close listFile
                   move all high-values to stFic
               not at end
                   add 1 to nbNamesMapping
                   move lfr-directiveName 
                       to nm-directiveName(nbNamesMapping)
                   move lfr-realName 
                       to nm-realName(nbNamesMapping)
               end-read 
           end-perform.
      *--------------------------------------------------
      * display errors in the resulting .err file from ccbl32
       displayErrors.
           initialize iFileName
      * Roch Rolland - 12/2004 - Begin
      *     string baseSrcName delimited by space
      *         '.err' delimited by size
      *         into iFileName
           move nameOfErrorFile to iFileName
      * Roch Rolland - 12/2004 - End

           open input iFile
           perform until stFic not = "00"
               initialize iRecord
               read iFile next
               at end
                   close iFile
                   move all high-values to stFic
               not at end
                   move iRecord to msg
                   perform errorAnalysis
               end-read 
           end-perform.
      *--------------------------------------------------
      * changes the file names by the full path names in the error report
       errorAnalysis.
           perform varying i from 1 by 1
           until i = length of msg or msg(i:1) = ','
               continue
           end-perform
           if msg(i:1) = ','
               subtract 1 from i
               move msg(1:i) to tmp
               |--loop on the names table
               perform varying j from 1 by 1 until j > nbNamesMapping
                   if tmp = nm-directiveName(j)
                       add 1 to i
                       compute k= length of msg - i
                       initialize tmp2
                       string nm-realName(j) delimited space
                           msg(i:k) delimited size
                           into tmp2
                       move tmp2 to msg
                       move nbNamesMapping to j
                   end-if
               end-perform
               |--
           end-if
           perform displayErr.
      *--------------------------------------------------
      * puts the .acu file at the right place
       putAcuFile.
           initialize source-file dest-file
           string baseSrcName '.acu' delimited space
               into source-file
           call "c$fileinfo" using source-file file-info 
               giving status-code
           if status-code not = 0
               move 2 to rc
           else
               if thinClientMode = 'yes' 
               and flagAcuLocalDest not = 'yes'
                   initialize msg
                   string 
                       'copying file "' delimited size
                       source-file delimited space
                       '" on the server ' delimited size
                       into msg
                   perform displayMessage
                   perform putAcuFileCopyOnServer
               else
                   perform putAcuFileCopyLocally
                   if flagAcuLocalDest = 'yes'
                   and thinClientMode = 'yes' 
                       move 'because of parameter ACULOCALDEST'    
                           to tmp
                   else
                       move 'because not in thin client mode'
                           to tmp
                   end-if
                   initialize msg
                   string 
                       'file "' delimited size
                       source-file delimited space
                       '" not copied on the server ' delimited size
                       tmp delimited size
                         into msg
                   perform displayWarningMessage
               end-if
           end-if.
      *--------------------------------------------------
       putAcuFileCopyOnServer.
           string serverObjPath '/' baseSrcName '.acu' delimited space
               into dest-file
           move serverObjPath to tmp
           initialize tmp2
           string '//' tmp-ncar delimited size
              into tmp2
           call "cbl_copy_file" using source-file dest-file 
               giving copy-status
           if copy-status not = 0
               initialize msg
               string 
                   'copy file "' delimited size
                   source-file delimited space
                   ' on ' delimited size
                   tmp2 delimited space
                   '" (error ' copy-status ')' delimited size
                       into msg
               perform displayFatalMessage
               move 2 to rc
           else
               initialize msg
               string 
                   'copy file "' delimited size
                   source-file delimited space
                   ' on ' delimited size
                   tmp2 delimited space
                   '" successfull' delimited size
                   into msg
               perform displayMessage
           end-if.
      *--------------------------------------------------
       putAcuFileCopyLocally.
           initialize tmp 
           string objectPath  '\' delimited by space
                  baseSrcName '.acu' delimited space
               into dest-file
           call "cbl_copy_file" using source-file dest-file 
               giving copy-status
           if copy-status not = 0
               initialize msg
               string 
                   'copy file "' delimited size
                   source-file delimited space
                   '" on ' delimited size
                   objectPath delimited space
                   ' (error ' copy-status ')' delimited size
                       into msg
               perform displayFatalMessage
               move 2 to rc
           else
               initialize msg
               string 
                   'copy file "' delimited size
                   source-file delimited space
                   '" on ' delimited size
                   objectPath delimited space
                   ' successfull' delimited size
                   into msg
               perform displayMessage
           end-if.
      *--------------------------------------------------
      * go back to the project directory
       goBackPrjDir.
           call "c$chdir" using prjDir err-num
           if err-num not = 0
               move err-num to i
               initialize msg
               string 
                   'chdir project directory "' delimited size
                   prjDir delimited space
                   '" (error ' i ')' delimited size
                       into msg
               perform displayFatalMessage
               move 2 to rc
           end-if.
      *--------------------------------------------------
      * call the part cleaning the tmp dir on the server
       deleteRemoteTmpDir.
           if flagServerPresent = 'yes'
               |--call the server part (by acuconnect)
               call serverProcobStart 
                   using flagCleanSrv uniqueNumberRecord
                   on exception continue
               end-call
           end-if.
      *--------------------------------------------------
      * this part is called on the server side by acuconnect
      * (see deleteRemoteTmpDir)
       cleanServerpart.
           initialize cmd-line tmp
           move 'rm_-rf_./tmp/' to tmp
           string tmp delimited space
               lnkNum delimited space
               into cmd-line
           inspect cmd-line replacing all '_' by space
           |--if command wont delete global tmp dir...
           inspect tmp replacing all '_' by space  
           if cmd-line not = tmp
               |--delete this tmp dir
               call "system" using cmd-line giving exit-status
           end-if.
      *--------------------------------------------------
       displayErrOracle.
           if msg(1:14)= 'Error at line '
               perform OracleErrAnalysis
           else
               perform displayErr
           end-if.
      *--------------------------------------------------
      * analyzes the precompiler error report to put the
      * right file names with the full path
       OracleErrAnalysis.
           initialize msgStruct
           |--analysis loop
           compute l= length of msg - 80
           perform varying i from 1 by 1 until i > l
               evaluate true
               |--looks for the line number
               when msg(i:14)= 'Error at line '
                   move 15 to i j
                   perform varying j from j by 1
                   until j > l
                       if msg(j:1) = ','
                           compute k= j - i
                           move msg(i:k) to msgLine
                           move l to j
                       end-if
                   end-perform
               |--looks for the file name
               when msg(i:9)= ' in file '
                   add 9 to i
                   compute j= l - i
                   move msg(i:j) to msgFicName
                   if msgFicName = srcName
                       move sourceFilePath to msgFicName
                   end-if
                   move l to i
               end-evaluate
           end-perform
           |--
           perform varying i from 1 by 1 until i > nbNamesMapping
               if msgFicName = nm-directiveName(i)
                   move nm-realName(i) to msgFicName
                   move nbNamesMapping to i
               end-if
           end-perform
           |--
           initialize msg
           string msgFicName delimited space
               ', line ' delimited size
               msgLine delimited space
               ': SQL error.'  delimited size
               into msg
           perform displayErr.
      *--------------------------------------------------
       displayWarningMessage.
           move msg to msgTmp
           string 'warning: ' msgTmp delimited size
               into msg
           perform displayMessage.
      *--------------------------------------------------
       displayFatalMessage.
           move msg to msgTmp
           string 'fatal error: ' msgTmp delimited size
               into msg
           perform displayMessage.
      *--------------------------------------------------
       displayMessage.
           accept heure from time
           display hh ':' mm ':' ss ' ' msg upon console.
      *--------------------------------------------------
       displayErr.
           display msg upon console.
      *--------------------------------------------------

      * Roch Rolland - Begin - 12/2004

      * This paragraph is use to test if we have to pass by the all
      * Boomerang process to make the compilation
       typeofCompilation.

           perform precParseSourceFileName
           perform testThinClientMode
           perform getNameErrorFile

      * If we don't pass by Boomerang Process
           if thinClientMode equal "no" or extSrcNameLow not equal 'pco'
           then
              if extSrcNameLow equal 'pco'
              then
                initialize msg
                move 
                  'impossible to precompile this file without Boomerang'
                  to msg
                perform displayFatalMessage
              end-if

      *       Execute a standard compilation
              initialize cmd-line

              if errorFileFlagNotInArgs
                string "ccbl32.exe " delimited by size
                  "-e " delimited by size
                  nameOfErrorFile delimited by low-value
                  " " delimited by size
                  cmdline delimited by size
                   into cmd-line
              else
                string "ccbl32.exe " delimited by size
                  cmdline delimited by size
                   into cmd-line
              end-if

              call "c$system" using cmd-line, CSYS-HIDDEN 
                            giving exit-status
              perform displayStandardErrors
              stop run
           end-if
           .
      *--------------------------------------------------
      * This Paragraph give a value to the thinClientMode variable
       testThinClientMode.
           move 'no' to thinClientMode
           perform varying i from 1 by 1 until i > nbParam
               evaluate tbParam(i)
               when '-o'
                   add 1 to i
                   if tbParam(i)(1:7) = 'acurfap'
                       move 'yes' to thinClientMode
                   end-if
      * Break the perform statement
                   add nbParam to i
                end-evaluate
           end-perform.
      *--------------------------------------------------
      * Boomerang need an error file to function
      * This paragraph tests if -e switch is used
      * or give the value @.err to nameOfErrorFile variable 
       getNameErrorFile.
           initialize nameOfErrorFile
           perform varying i from 1 by 1 until i > nbParam
               evaluate tbParam(i)
               when '-e'
                   add 1 to i
                   move tbParam(i) to nameOfErrorFile
      * Statement to break the perform
                   add nbParam to i
               end-evaluate
           end-perform

           if nameOfErrorFile equal spaces
           then
               string baseSrcName delimited by space
               '.err' delimited by size
               into nameOfErrorFile
               inspect nameOfErrorFile  
                   replacing trailing spaces by low-values
               set errorFileFlagNotInArgs to true
           else
               move nameOfErrorFile to tmp
               perform replaceAtCaracter
               move tmp to nameOfErrorFile
               set errorFileFlagInArgs to true
           end-if.
      *--------------------------------------------------
      * Paragraph to replace the @ caracter by the base name
      * of the Source file
       replaceAtCaracter.
                initialize tmp2 tmp3
                inspect tmp  
                   replacing trailing spaces by low-values
                move 0 to numberOfAtCaracter
                inspect tmp tallying numberOfAtCaracter for all '@'
                if numberOfAtCaracter > 0
                then
                    unstring tmp 
                      delimited by "@"
                      into tmp2,tmp3
                    inspect tmp2
                       replacing trailing spaces by low-values
                    inspect tmp3
                       replacing trailing spaces by low-values
                    string tmp2 delimited by low-values
                           baseSrcName delimited by space
                           tmp3 delimited low-values
                    into tmp

                 end-if.
      *--------------------------------------------------
      *Build the string corresponding to the swith -e
       ConstructStringsListError.
                       
               string 
                ' -e ' delimited by size
                nameOfErrorFile delimited by low-value
                ' ' delimited by size
               into StringSwitchError
               inspect StringSwitchError  
                   replacing trailing spaces by low-values
               
               if listPathName not equal spaces
                  string 
                   ' -Lo ' delimited size
                   listPathName delimited by low-value
                   ' ' delimited by size
                   into StringSwitchList
                end-if
                inspect StringSwitchList  
                   replacing trailing spaces by low-values                
                .
      *--------------------------------------------------
      * Test the PathName of typeOfPathFile
      * if the PathName is absolute, put 0 in typeofPath
      * if the PathName is relative, put 1 in typeofPath
       typeOfPathParagrah.
           if typeOfPathFile(1:1) = '\' or
             typeOfPathFile(1:1) = '/' or
             typeOfPathFile(2:1) = ':'
           then
             set typeOfPathAbsolute to true
           else
             set typeOfPathRelative to true
           end-if.


      *--------------------------------------------------
      * Display the Standard compilations messages in the Output Window
       displayStandardErrors.
           initialize iFileName
           move nameOfErrorFile to iFilename

           open input iFile
           perform until stFic not = "00"
               initialize iRecord
               read iFile next
               at end
                   close iFile
                   move all high-values to stFic
               not at end
                   move iRecord to msg
                   perform displayErr
               end-read 
           end-perform.


      * Roch Rolland - End - 12/2004
