identification division.
program-id.  newftest.

* this program performs various file i/o tests for benchmarking
* purposes.  It should be compiled with no special compile option.
* This version requires Acucobol 4.3 or higher.
*
* NOTE - this program also requires the subroutine MESSAGE which is
*        distributed with Acucobol.  MESSAGE.CBL should be in the
*        SAMPLE directory under the directory where you installed
*        Acucobol-GT
*
* ADDITIONAL NOTE --- all COPY files used can be found in the /SAMPLE
*                     directory under the place you installed Acucobol-GT.
*

* date written: 8/05/92 - John
* Rewritten: 8/96 - Pete - to use Acucobol 3.x screens
* 10/24/98 - added capability to do a read with or without lock.
*            Moved file START button  (Pete)
* 8/13/99 - added call to "special" under special circumstances
* 10/21/99 - reversed order of test number and data fields.
* 11/10/99 - added logic for color map and mouse in non-gui env.
* 02/10/00 - removed color map.  Added alphabetic data to load.
*            Also added XFD WHEN options for Acu4GL and Alfred testing.

environment division.
configuration section.

special-names.
     class hex-chars is " 0123456789ABCDEF"
     class displayable is 33 thru 127.

input-output section.
file-control.

    select ftest-file
* This file is used for the normal non-transaction management mode
    assign to disk "ftestdat"
    organization is indexed
    access is dynamic
    record key is ftest-key
    alternate record key is ftest-altkey1
        with duplicates
    alternate record key is ftest-altkey2
    status is ftest-status.

    select ftest2-file
* This file is used when in transaction management mode
    assign to disk "ftestdat"
    organization is indexed
    access is dynamic
    lock mode is automatic
    with rollback
    record key is ftest2-key
    alternate record key is ftest2-altkey1
        with duplicates
    alternate record key is ftest2-altkey2
    status is ftest-status.

i-o-control.
     same record area for ftest-file,
                          ftest2-file.

* The record areas of the 2 files is the same so that the logic does not
* have to change in most of the program as far as data is concerned.  You
* only need to change the key and file names on the opens, starts, etc.

data division.
file section.

fd  ftest-file.
01  ftest-record.
    03  ftest-key           pic x(4).
    03  ftest-altkey1.
        05 ftest-key1-seg1  pic x(2).
        05 ftest-key1-seg2  pic x(2).
    03  ftest-altkey2       pic x(4).
    03  ftest-number        pic 9(6)v99.
    03  ftest-info          pic x(10).


fd  ftest2-file.
01  ftest2-record.
    03  ftest2-key           pic x(4).
    03  ftest2-altkey1.
        05 ftest2-key1-seg1  pic x(2).
        05 ftest2-key1-seg2  pic x(2).
    03  ftest2-altkey2       pic x(4).
    03  ftest2-number        pic 9(6)v99.
*((XFD WHEN FTEST2-KEY = OTHER))
    03  ftest2-info          pic x(10).
*
* Following used for testing XFD WHEN clause for Acu4GL, etc
*
*((XFD WHEN FTEST2-KEY < "0103"))
    03  ftest2-infor1 redefines ftest2-info.
        05  ftest2-info1     pic x(5).
        05  filler           pic x(5).
*((XFD WHEN FTEST2-KEY = "0103"))
    03  ftest2-infor2 redefines ftest2-info.
        05  ftest2-info2     pic x(7).
        05  filler           pic x(3).
*((XFD WHEN FTEST2-KEY > "0500"))
    03  ftest2-infor3 redefines ftest2-info.
        05  filler           pic x(8).
        05  ftest2-info3     pic x(2).
*
* Note - since both files point to the same physical file (ftestdat)
*        we only need to add the above information to the second file
*        since that's the one whose data will go into the .XFD file.
*        To use the WHEN clause areas you should use the Load File
*        option to load the file with 25 records of dummy data.
*


working-storage section.
copy "def/acucobol.def".
copy "def/acugui.def".
copy "def/stdfonts.def".

01  screen-control is special-names screen control.
    05  accept-control                pic 9.
    05  control-value                 pic 999.
    05  control-handle                handle.
    05  control-id                    pic xx comp-x.

77  hex-window-handle                   handle.
77  about-window-handle                 handle.
77  main-window-handle                  handle of window.

77  ftest-status                        pic x(2) value "00".
    88  ftest-ok                          value "00" "02" false "ZZ".

* various program flags
77  filler                              pic x.
    88  data-ok                           value "Y" false space.
77  filler                              pic x.
    88  primary-is-hex                    value "Y" false space.
77  filler                              pic x.
    88  key1-seg1-is-hex                  value "Y" false space.
77  filler                              pic x.
    88  key1-seg2-is-hex                  value "Y" false space.
77  filler                              pic x.
    88  alt2-is-hex                       value "Y" false space.
77  filler                              pic x.
    88  file-open                         value "Y" false space.
77  filler                              pic x.
    88  file-open-input                   value "Y" false space.

77  key-status
    is special-names crt status         pic 9(4).
    88  all-done                          value 27.

* standard error values
77  f-int-errno                         pic s9(4) comp-5 external.
77  f-errno                             pic s9(4) comp-5 external.
    88  f-in-error                      values 1 thru 99.
    88  e-sys-err                       value 1.
    88  e-param-err                     value 2.
    88  e-too-many-files                value 3.
    88  e-mode-clash                    value 4.
    88  e-rec-locked                    value 5.
    88  e-broken                        value 6.
    88  e-duplicate                     value 7.
    88  e-not-found                     value 8.
    88  e-undef-record                  value 9.
    88  e-disk-full                     value 10.
    88  e-file-locked                   value 11.
    88  e-rec-changed                   value 12.
    88  e-mismatch                      value 13.
    88  e-no-memory                     value 14.
    88  e-missing-file                  value 15.
    88  e-permission                    value 16.
    88  e-no-support                    value 17.
    88  e-no-locks                      value 18.
    88  e-interface                     value 19.
    88  e-license-error                 value 20.
    88  e-unknown-error                 value 21.
    88  e-transaction-error             value 22.
    88  w-no-support                    value 100.
    88  w-dup-ok                        value 101.

*---------------------------------------------------
78  nr-error-items      value 24.
01 error-items.
    03 filler pic x(20) value   "System Error".
    03 filler pic x(20) value   "Parameter error".
    03 filler pic x(20) value   "Too many files".
    03 filler pic x(20) value   "Mode Clash".
    03 filler pic x(20) value   "Record Locked".
    03 filler pic x(20) value   "Broken File".
    03 filler pic x(20) value   "Duplicate Key".
    03 filler pic x(20) value   "Record Not Found".
    03 filler pic x(20) value   "Undefined Record".
    03 filler pic x(20) value   "Disk Full".
    03 filler pic x(20) value   "File Locked".
    03 filler pic x(20) value   "Record Changed".
    03 filler pic x(20) value   "Mismatch".
    03 filler pic x(20) value   "No Memory ".
    03 filler pic x(20) value   "Missing File".
    03 filler pic x(20) value   "Permission Error".
    03 filler pic x(20) value   "No Support".
    03 filler pic x(20) value   "No Locks".
    03 filler pic x(20) value   "Interface".
    03 filler pic x(20) value   "License error".
    03 filler pic x(20) value   "Unknown Error".
    03 filler pic x(20) value   "Transaction Error".
    03 filler pic x(20) value   "No Support".
    03 filler pic x(20) value   "Duplicates OK".

01 error-table redefines error-items.
    03 error-lit occurs nr-error-items times   pic x(20).

*---------------------------------------------------

01  error-status.
    03 primary-error    pic x(2).
    03 secondary-error  pic x(10).
01  error-text                  pic x(40).
01  space-count                 pic 99.
01  line-pos                    pic 99.
01  error-line-1.
    05  filler                  pic x(19)
        value "FILE ERROR. Status=".
    05  disp-primary-error      pic xx.
    05  disp-comma              pic x   value ",".
    05  disp-secondary-error    pic x(10).
78  error-line-1-length         value 32.

01  error-line-2.
    05  filler                  pic x(13)  value "COBOL Error:".
    05  error-line-2-data       pic x(20).
78  error-line-2-length         value 33.

01  error-line-3.
    05  filler                  pic x(19)   value "Transaction Error: ".
    05  error-line-3-out        pic xx.
78  error-line-3-length         value 21.

* Used in Message routines.
01  message-type                       pic 9.
    88  error-type                       value 1.
    88  warning-type                     value 2.
    88  information-type                 value 3.

01  response-type.
    03  default-button                 pic 9.
        88  default-1                    values 0, 1.
        88  default-2                    value 2.
        88  default-3                    value 3.
    03  button-types                   pic 9.
        88  ok-type                      value 1.
        88  yes-no-type                  value 2.
        88  ok-cancel-type               value 3.
        88  yes-no-cancel-type           value 4.

01  response redefines response-type   pic 99.
    88  respond-ok                       value 1.
    88  respond-yes                      value 1.
    88  respond-no                       value 2.
    88  respond-cancel                   value 3.

01  message-1                          pic x(40).
01  message-2                          pic x(40).
01  message-3                          pic x(40).

01  msg-out                            pic x(25).

01  which-key                          pic 9 value 1.
    88  use-primary                      value 1.
    88  use-alt1                         value 2.
    88  use-alt2                         value 3.
01  start-type                         pic 9 value 4.
    88  start-le                         value 1.
    88  start-lt                         value 2.
    88  start-eq                         value 3.
    88  start-ge                         value 4.
    88  start-gt                         value 5.
01  filler                             pic x value space.
    88  use-transaction                  value "Y".
01  close-enabled                      pic 9  value zero.
01  io1-enabled                        pic 9  value 0.
01  io2-enabled                        pic 9  value 0.
01  io3-enabled                        pic 9  value 0.
01  read1-enabled                      pic 9  value 0.
01  read2-enabled                      pic 9  value 0.
01  read3-enabled                      pic 9  value 0.
01  start-enabled                      pic 9  value 0.
01  key-enabled                        pic 9  value 0.
01  key1-seg1-enabled                  pic 9  value 0.
01  key1-seg2-enabled                  pic 9  value 0.
01  altkey2-enabled                    pic 9  value 0.
01  number-enabled                     pic 9  value 0.
01  info-enabled                       pic 9  value 0.
01  start-trans-enabled                pic 9  value 1.
01  commit-enabled                     pic 9  value 1.
01  rollback-enabled                   pic 9  value 1.
01  rlock-enabled                      pic 9  value 0.
01  start-type-enabled                 pic 9  value 0.
01  which-enabled                      pic 9  value 0.
01  read-lock                          pic 9  value 1.
    88  read-with-lock                     value 1.
    88  read-without-lock                  value 2.
01  call-vis                           pic 9 value 0.
01  call-ena                           pic 9 value 0.

01  hex-4-data                         pic x(4).
01  hex-4-visible                      pic 9 value 0.
01  hex-8-data                         pic x(8).
01  hex-8-visible                      pic 9 value 1.
01  hex-error-visible                  pic 9 value 0.
01  hex-label-visible                  pic 9 value 0.

01  ftest-key-save                     pic x(4).
01  ftest-key-display                  pic x(4).
01  ftest-key-hex                      pic x(4).
01  ftest-key1-seg1-save               pic xx.
01  ftest-key1-seg1-display            pic xx.
01  ftest-key1-seg1-hex                pic xx.
01  ftest-key1-seg2-save               pic xx.
01  ftest-key1-seg2-display            pic xx.
01  ftest-key1-seg2-hex                pic xx.
01  ftest-altkey2-save                 pic x(4).
01  ftest-altkey2-display              pic x(4).
01  ftest-altkey2-hex                  pic x(4).
01  work-4                             pic x(4).
01  work-2                             pic x(2).
01  save-position                      pic 99.
01  save-position2                     pic 99.

* exception codes
78  open-it-input                      value 21.
78  open-it-output                     value 22.
78  open-it-io                         value 23.
78  write-it                           value 24.
78  rewrite-it                         value 25.
78  delete-it                          value 26.
78  read-it-equal                      value 28.
78  read-it-next                       value 29.
78  read-it-previous                   value 30.
78  close-it                           value 31.
78  start-it                           value 32.
78  done-with-program                  value 27.
78  start-it-trans                     value 33.
78  commit-it                          value 34.
78  rollback-it                        value 35.
78  show-about                         value 39.
78  load-file                          value 40.
78  call-sub                           value 41.

78  primary-field                      value 23.
78  alt-seg1-field                     value 24.
78  alt-seg2-field                     value 25.
78  alt2-field                         value 26.
78  fkey-2                             value 2.
78  next-field                         value 15.
78  previous-field                     value 16.

77  call-sub-flag                      pic x.
    88  call-the-sub                     value "Y", "y".
77  last-io-field-used                 pic 99 value 11.
77  4-byte-label                       pic x(16)
    value "4-byte Hex Value".
77  2-byte-label                       pic x(16)
    value "2-byte Hex Value".
77  2-byte-label-visible               pic 9  value 0.
77  4-byte-label-visible               pic 9  value 0.

* Load info
01  group-item.
    05  grp1                           pic xx.
    05  grp2                           pic xx.
01  indx1                              pic 99.
01  indx2                              pic 99.
01  cntr                               pic 99 value 0.
01  alpha-area                         pic x(36) value
    "abcdefghijklmnopqrstuvwxyzABCDEFGHI".
01  mouse-status                       pic 99 value 0.

screen section.

01  main-screen.
    05 label "Acucobol File Testing Facility (FTEST)"
       line 1 font large-font column 21 size 40 center.
    05 label "Version 2.34" line 2 font small-font column 35
       size 12 center.
* key to user area
    05 frame line 4 cline 3 column 14
       lines 3  size 56 "Key to Use" engraved.
    05  push-button line 2 cline 2 column 2 size 10 "&Call Sub."
        exception-value = 41 visible = call-vis enabled = call-ena.
    05  push-button line 4.8 cline 4 column 2 size 10 "&Load File"
        exception-value = 40.
    05 radio-button line 5 cline 4 column 17 using which-key
       "Primary Key" group 1 group-value = 1 enabled = which-enabled.
    05 radio-button column + 3 using which-key
       "Alternate Key 1" group 1 group-value 2 enabled = which-enabled.
    05  radio-button column + 3 using which-key
       "Alternate Key 2" group 1 group-value 3 enabled = which-enabled.
* start type area
    05  frame line 7 cline 6 column 14
        lines 3 size 56 "Start Type" engraved.
    05  radio-button line 8 cline 7 column 17 using start-type
       "LE (<=)"  group 2 group-value 1 enabled = start-type-enabled.
    05  radio-button column + 3 using start-type
       "LT (<)"   group 2 group-value 2 enabled = start-type-enabled.
    05  radio-button column + 3 using start-type
       "EQ (=)"   group 2 group-value 3 enabled = start-type-enabled.
    05  radio-button column + 3 using start-type
       "GE (>=)"  group 2 group-value 4 enabled = start-type-enabled.
    05  radio-button column + 3 using start-type
       "GT (>)"   group 2 group-value 5 enabled = start-type-enabled.
* I-O type area
    05  frame line 10 cline 9 column 2 lines 4
        clines 3 size 40 "I-O Types" engraved.
    05  push-button line 11.4 cline 10 column 4 size 8 "&Write"
        exception-value = 24 enabled = io1-enabled.
    05  push-button column + 4 size 8 "&Rewrite"
        exception-value = 25 enabled = io2-enabled.
    05  push-button column + 4 size 8 "&Delete"
        exception-value = 26 enabled = io3-enabled.
* Read Type area
    05  frame line 14 cline 13 column 2
        clines 3 lines 4 size 40 "Read Types" engraved.
    05  push-button line 15.4 cline 14 column 4 size 8 "Equal"
        exception-value = 28 enabled = read1-enabled.
    05  push-button column + 4 size 8 "&Next"
        exception-value = 29 enabled = read2-enabled.
    05  push-button column + 4 size 8 "&Previous"
        exception-value = 30 enabled = read3-enabled.
* Transaction Mgmt. area
    05  frame line 18 cline 17 column 2
        clines 3 lines 4 size 40 "Transaction Management" engraved.
    05  push-button line 19.4 cline 18 column 4 size 8 "Start Tran"
        exception-value = 33 enabled = start-trans-enabled.
    05  push-button column + 4 size 8 "Commit"
        exception-value = 34 enabled = commit-enabled.
    05  push-button column + 4 size 8 "Rollback"
        exception-value = 35 enabled = rollback-enabled.
* Other (Start) area
    05  frame line 22 cline 21 column 2 lines 4 clines 3
        size 40 "Read with Lock" engraved.
    05  start-push push-button line 7.8 cline 7 col 2
        size 10 "Start File"
        exception-value = 32 enabled = start-enabled.
    05  radio-button line 23.5 cline 22 col 3 using read-lock
        "Read With Lock" group-value 1 group 3 enabled = rlock-enabled.
    05  radio-button line 23.5 cline 22 col 21 ccol 23 using read-lock
        "Read W/O Lock" group-value 2 group 3 enabled = rlock-enabled.
* Record Input and Display area
    05  label "Primary Key:" line 11  column 45 ccol 43.
    05  entry-field from ftest-key-display to ftest-key-save
        column 60 ccol 58 auto enabled = key-enabled
        before procedure is 9070-label-visible
         after procedure is 9080-after-input-field.
    05  label "Pic X(4)"  column 70.
    05  label "Alt. Key 1 Seg 1" line 13 column 45 ccol 43.
    05  entry-field from ftest-key1-seg1-display to ftest-key1-seg1-save
        column 60 ccol 60 auto enabled = key1-seg1-enabled
        before procedure is 9070-label-visible
        after procedure is 9080-after-input-field.
    05  label "Pic X(2)"  column 70.
    05  label "Alt. Key 1 Seg 2" line 15 column 45 ccol 43.
    05  entry-field from ftest-key1-seg2-display to ftest-key1-seg2-save
        column 60 ccol 60 auto enabled = key1-seg2-enabled
        before procedure is 9070-label-visible
       after procedure is 9080-after-input-field.
    05  label "Pic X(2)"  column 70.
    05  label "Alternate Key 2" line 17 column 45 ccol 43.
    05  entry-field from ftest-altkey2-display to ftest-altkey2-save
        column 60 ccol 58 auto enabled = altkey2-enabled
        before procedure is 9070-label-visible
       after procedure is 9080-after-input-field.
    05  label "Pic X(4)"  column 70.
    05  label "Test Data" line 19 column 45 ccol 43 auto.
    05  entry-field using ftest-info column 60 ccol 58 auto
        before procedure is 9090-hex-off
        enabled = info-enabled.
    05  label "Pic X(10)" column 70.
    05  label "Test Number" line 21 column 45 ccol 43.
    05  entry-field using ftest-number column 60 ccol 58 auto
        pic zzzzzz.zz before procedure is 9090-hex-off
        after procedure is 9040-reset-cursor
        enabled = number-enabled.
    05  label "Pic 9(6).99" column 70.
    05  disp-msg label msg-out line 23 cline 22
        column 55 font large-font.
    05  hex-label-field label "Press F2 For Hex Data" visible is
        hex-label-visible line 24 cline 23 column 45.
01  hex-screen.
    05  label "Hex Conversion Screen" line 1 font large-font
        column 4 size 22 center.
    05  label 2-byte-label  line 3 column 2 visible
        is 2-byte-label-visible.
    05  label 4-byte-label  line 3 column 2 visible
        is 4-byte-label-visible auto.
    05  hex-4 entry-field  using hex-4-data  line 3 column 20
        visible is hex-4-visible upper auto
        after procedure is 3001-4-hex-check.
    05  hex-8 entry-field  using hex-8-data  line 3 column 20
        visible is hex-8-visible upper auto
        after procedure is 3002-8-hex-check.
    05  hex-error label "Invalid Hex Data" line 5 column 2
        visible is hex-error-visible.
    05  push-button cancel-button "&Cancel" line 7 column 14.
01  about-screen.
    05  label  "Acucobol File Testing Utility" line 1 font large-font
        column 4 size 30 center.
    05  label "Version 2.34 Copyright Acucorp 1/06" line 2
        ccol 2 column 3 size 36 center.
    05  label "Written by Pete in Tech Support" line 3
        ccol 4 column 7 center.
    05  label "With Inspiration From Many Others" line 4
        ccol 3 column 6 center.
    05  push-button ok-button "&OK" line 6 column 16 size 8.

procedure division chaining call-sub-flag.
declaratives.
ftest-err-handling section.
    use after standard error procedure on ftest-file, ftest2-file.
ftest-err.
    call "C$RERR" using error-status, error-text.
    set default-1 to true.
    move spaces to message-1,
                   message-2,
                   message-3,
                   msg-out.
    display disp-msg.
    set error-type,
        ok-type to true.
    move primary-error to disp-primary-error.
    move secondary-error to disp-secondary-error.
    if disp-secondary-error = spaces or
       disp-secondary-error (1:2) = "00"
         move space to disp-secondary-error
                       disp-comma
    else
         move "," to disp-comma
    end-if.
    move zero to space-count.
    inspect error-line-1 tallying space-count for trailing spaces.
    compute line-pos = (40 - (error-line-1-length - space-count)) / 2.
    if line-pos = zero
       move 1 to line-pos
    end-if.
    move error-line-1 (1:error-line-1-length - space-count) to
         message-1 (line-pos:error-line-1-length - space-count).
    if f-errno = 100
       move 22 to f-errno
       else
       if f-errno = 101
          move 23 to f-errno
       end-if
    end-if.
    if f-errno > zero and not > nr-error-items
       move zero to space-count
       move error-lit (f-errno) to error-line-2-data
       inspect error-line-2 tallying space-count for trailing spaces
       compute line-pos = (40 - (error-line-2-length - space-count)) / 2
       if line-pos = zero
          move 1 to line-pos
       end-if
       move error-line-2 (1:error-line-2-length - space-count) to
            message-2 (line-pos:error-line-2-length - space-count)
    end-if.
    if error-text not = spaces
       move zero to space-count
       inspect error-text tallying space-count for trailing spaces
       compute line-pos =  space-count / 2
       if line-pos = zero
          move 1 to line-pos
       end-if
       move error-text (1:40 - space-count) to
           message-3 (line-pos:40 - space-count)
    end-if.
     set default-1 to true.
     call "message" using message-type,
                          response-type,
                          message-1,
                          message-2,
                          message-3.

ftest-trans-handling section.
    use after standard error procedure on transaction.
ftest-trans.
    call "C$RERR" using error-status, error-text.
    move spaces to message-1,
                   message-2,
                   message-3,
                   msg-out.
    display disp-msg.
    set error-type,
        ok-type to true.
    move primary-error to disp-primary-error.
    move secondary-error to disp-secondary-error.
    if disp-secondary-error = spaces or
       disp-secondary-error (1:2) = "00"
         move space to disp-secondary-error
                       disp-comma
    else
         move "," to disp-comma
    end-if.
    move zero to space-count.
    inspect error-line-1 tallying space-count for trailing spaces.
    compute line-pos = (40 - (error-line-1-length - space-count)) / 2.
    if line-pos = zero
       move 1 to line-pos
    end-if
    move error-line-1 (1:error-line-1-length - space-count) to
         message-1 (line-pos:error-line-1-length - space-count).
    move transaction-status to error-line-3-out.
    move error-line-3 to message-2 (9:).
    if error-text not = spaces
       move zero to space-count
       inspect error-text tallying space-count for trailing spaces
       compute line-pos = (40 - space-count) / 2
       if line-pos = zero
          move 1 to line-pos
       end-if
       move error-text (1:40 - space-count) to
           message-3 (line-pos:40 - space-count)
      end-if.
      set default-1 to true.
      call "message" using message-type,
                           response-type,
                           message-1,
                           message-2,
                           message-3.
      set ftest-ok to false.

end declaratives.

start-program.
    set configuration "KEYSTROKE" to "EDIT=NEXT TERMINATE=13 ^M".
    if call-the-sub
       move 1 to call-vis, call-ena.
    move zero to ftest-number.
    accept terminal-abilities from terminal-info.
    if not has-graphical-interface
       set configuration "KEYSTROKE" to "EDIT=MENU k1"
       call "w$mouse" using enable-mouse, giving mouse-status
    end-if.
    display standard graphical window background-low  title
      "Acucobol File Test Facility" auto-resize
      cell size is label font fixed-font
      handle in main-window-handle
      action is action-maximize.

    move "Test Transaction Processing?" to message-1.
    set yes-no-type,
        default-2,
        information-type to true.
    call "message" using message-type,
                         response-type,
                         message-1.
    if respond-yes
       set use-transaction to true
    else
       move zero to start-trans-enabled,
                    commit-enabled,
                    rollback-enabled
    end-if.
    perform build-ftest-menu.
    call "w$menu" using wmenu-show, menu-handle.
    perform process-screen until all-done.
    if not has-graphical-interface
       display window erase
    end-if.
    stop run.

process-screen.
     display main-screen.
     accept main-screen on exception continue.
     if use-transaction
        perform 2000-trans-eval
     else
        perform 1000-non-trans-eval
     end-if.

1000-non-trans-eval.
     evaluate key-status
        when done-with-program
           continue
        when call-sub
          call "special"  on exception
            move "Call to special failed" to msg-out
           not on exception
            move "Call Succeeded" to msg-out
          end-call
        when open-it-input
           open input ftest-file
           set file-open-input to true
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when open-it-output
           open output ftest-file
           set file-open-input to false
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when open-it-io
           open i-o ftest-file
           set file-open-input to false
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when close-it
           close ftest-file
           if ftest-ok
              move "Close Successful" to msg-out
              perform 9020-close-flags
              set file-open to false
           end-if
        when write-it
           perform 9050-move-data
           write ftest-record
           if ftest-ok
              move "Write Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when rewrite-it
           perform 9050-move-data
           rewrite ftest-record
           if ftest-ok
              move "Rewrite Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when delete-it
           perform 9050-move-data
           delete ftest-file record
           if ftest-ok
              move "Delete Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when read-it-equal
           initialize ftest-record
           perform 9050-move-data
           evaluate true
* which key to use
              when use-primary
                 if read-with-lock
                    read  ftest-file record with lock
                 else
                    read  ftest-file record with no lock
                 end-if
              when use-alt1
                 if read-with-lock
                    read ftest-file record with lock
                         key is ftest-altkey1
                    end-read
                 else
                    read ftest-file record with no lock
                         key is ftest-altkey1
                    end-read
                 end-if
              when use-alt2

                 if read-with-lock
                    read ftest-file record with lock
                         key is ftest-altkey2
                 else
                    read ftest-file record with no lock
                         key is ftest-altkey2
                 end-if
          end-evaluate
          if ftest-ok
             if file-open-input
                move "Read Successful" to msg-out
             else
                if read-with-lock
                   move "Read with Lock Successful" to msg-out
                else
                   move "Read W/O Lock Successful" to msg-out
                end-if
             end-if
             perform 9060-move-data
             move 1 to accept-control
             move primary-field to control-value
          end-if
        when read-it-next
           initialize ftest-record
           if read-with-lock
              read ftest-file next record with lock
           else
              read ftest-file next record with no lock
           end-if
           if ftest-ok
              if file-open-input
                 move "Read Next Successful" to msg-out
              else
                 if read-with-lock
                    move "Next Lock Successful" to msg-out
                 else
                    move "Next No Lock Successful" to msg-out
                 end-if
              end-if
              perform 9060-move-data
              move 1 to accept-control
              move next-field to control-value
           end-if
        when read-it-previous
           initialize ftest-record
           if read-with-lock
              read ftest-file previous record with lock
           else
              read ftest-file previous record with no lock
           end-if
           if ftest-ok
              if file-open-input
                 move "Read Previous Successful" to msg-out
              else
                 if read-with-lock
                    move "Previous Lock Successful" to msg-out
                 else
                    move "Previous No Lock Successful" to msg-out
                 end-if
              end-if
              perform 9060-move-data
              move 1 to accept-control
              move previous-field to control-value
           end-if
        when start-it
           perform 9050-move-data
           evaluate true
* first must get which key
             when use-primary
* then must get type of start
                evaluate true
                   when start-le
                      start ftest-file key is <= ftest-key
                   when start-lt
                      start ftest-file key is < ftest-key
                   when start-eq
                      start ftest-file key is = ftest-key
                   when start-ge
                      start ftest-file key is not <  ftest-key
                   when start-gt
                      start ftest-file key is > ftest-key
                end-evaluate
                if ftest-ok
                   move "Start Primary Successful" to msg-out
                end-if
             when use-alt1
                evaluate true
                   when start-le
                      start ftest-file key is <= ftest-altkey1
                   when start-lt
                      start ftest-file key is < ftest-altkey1
                   when start-eq
                      start ftest-file key is = ftest-altkey1
                   when start-ge
                      start ftest-file key is not < ftest-altkey1
                   when start-gt
                      start ftest-file key is > ftest-altkey1
                end-evaluate
                if ftest-ok
                   move "Start Alt1. Successful" to msg-out
                end-if
             when use-alt2
                evaluate true
                   when start-le
                      start ftest-file key is <= ftest-altkey2
                   when start-lt
                      start ftest-file key is < ftest-altkey2
                   when start-eq
                      start ftest-file key is = ftest-altkey2
                   when start-ge
                      start ftest-file key is >= ftest-altkey2
                   when start-gt
                      start ftest-file key is > ftest-altkey2
                end-evaluate
                if ftest-ok
                   move "Start Alt2. Successful" to msg-out
                end-if
           end-evaluate
        when fkey-2
           if control-value < primary-field or
                            > alt2-field
              move 1 to accept-control
           else
              move control-value to save-position
              perform 3000-hex
              if all-done
                 move 1 to accept-control
                 move save-position to control-value
                 move zero to key-status
              else
                 move 1 to accept-control
                 add 1, save-position giving control-value
              end-if
           end-if
        when show-about
         display floating window line 3 column 30
             size 40 lines 7
             title "About Ftest"
             with system menu cell size is label fixed-font
             background-low boxed shadow
             handle is about-window-handle
          display about-screen
          accept about-screen
          close window about-window-handle
        when load-file
          perform  9999-load-file thru 9999-exit
        when other
           move 1 to accept-control
     end-evaluate.

2000-trans-eval.
     evaluate key-status
        when done-with-program
           continue
        when call-sub
          call "special"  on exception
            move "Call to special failed" to msg-out
           not on exception
            move "Call Succeeded" to msg-out
          end-call
        when open-it-input
           open input ftest2-file
           set file-open-input to true
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when open-it-output
           open output ftest2-file
           set file-open-input to false
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when open-it-io
           open i-o ftest2-file
           set file-open-input to false
           if ftest-ok
              move "Open Successful" to msg-out
              perform 9010-open-flags
              set file-open to true
           end-if
        when close-it
           close ftest2-file
           if ftest-ok
              move "Close Successful" to msg-out
              perform 9020-close-flags
           end-if
        when write-it
           perform 9050-move-data
           write ftest2-record
           if ftest-ok
              move "Write Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when rewrite-it
           perform 9050-move-data
           rewrite ftest2-record
           if ftest-ok
              move "Rewrite Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when delete-it
           perform 9050-move-data
           delete ftest2-file record
           if ftest-ok
              move "Delete Successful" to msg-out
              perform 9030-save-operation
              perform 9060-move-data
           end-if
        when read-it-equal
           initialize ftest-record
           perform 9050-move-data
           evaluate true
* which key to use
              when use-primary
                 if read-with-lock
                    read  ftest2-file record with lock
                 else
                    read  ftest2-file record with no lock
                 end-if
              when use-alt1
                 if read-with-lock
                    read ftest2-file record with lock
                         key is ftest2-altkey1
                 else
                    read ftest2-file record with no lock
                         key is ftest2-altkey1
                 end-if
              when use-alt2
                 if read-with-lock
                    read ftest2-file record with lock
                         key is ftest2-altkey2
                 else
                    read ftest2-file record with no lock
                         key is ftest2-altkey2
                 end-if
          end-evaluate
          if ftest-ok
             if file-open-input
                move "Read Successful" to msg-out
             else
                if read-with-lock
                   move "Read With Lock Successful" to msg-out
                else
                   move "Read W/O Lock Successful" to msg-out
                end-if
             end-if
             perform 9060-move-data
             move 1 to accept-control
             move primary-field to control-value
          end-if
        when read-it-next
           if read-with-lock
              initialize ftest-record
              read ftest2-file next record with lock
           else
              read ftest2-file next record with no lock
           end-if
           if ftest-ok
              if file-open-input
                 move "Read Next Successful" to msg-out
              else
                 if read-with-lock
                    move "Next Lock Successful" to msg-out
                 else
                    move "Next No Lock Successful" to msg-out
                 end-if
              end-if
              perform 9060-move-data
              move 1 to accept-control
              move next-field to control-value
           end-if
        when read-it-previous
           initialize ftest-record
           if read-with-lock
              read ftest2-file previous record with lock
           else
              read ftest2-file previous record with no lock
           end-if
           if ftest-ok
              if file-open-input
                 move "Read Previous Successful" to msg-out
              else
                 if read-with-lock
                    move "Previous Lock Successful" to msg-out
                 else
                    move "Previous No Lock Successful" to msg-out
                 end-if
              end-if
              perform 9060-move-data
              move 1 to accept-control
              move previous-field to control-value
           end-if
        when start-it
           perform 9050-move-data
           evaluate true
* first must get which key
             when use-primary
* then must get type of start
                evaluate true
                   when start-le
                      start ftest2-file key is <= ftest2-key
                   when start-lt
                      start ftest2-file key is < ftest2-key
                   when start-eq
                      start ftest2-file key is = ftest2-key
                   when start-ge
                      start ftest2-file key is >= ftest2-key
                   when start-gt
                      start ftest2-file key is > ftest2-key
                end-evaluate
                if ftest-ok
                   move "Start Primary Successful" to msg-out
                end-if
             when use-alt1
                evaluate true
                   when start-le
                      start ftest2-file key is <= ftest2-altkey1
                   when start-lt
                      start ftest2-file key is < ftest2-altkey1
                   when start-eq
                      start ftest2-file key is =ftest2-altkey1
                   when start-ge
                      start ftest2-file key is >= ftest2-altkey1
                   when start-gt
                      start ftest2-file key is > ftest2-altkey1
                end-evaluate
                if ftest-ok
                   move "Start Alt1. Successful" to msg-out
                end-if
             when use-alt2
                evaluate true
                   when start-le
                      start ftest2-file key is <= ftest2-altkey2
                   when start-lt
                      start ftest2-file key is < ftest2-altkey2
                   when start-eq
                      start ftest2-file key is = ftest2-altkey2
                   when start-ge
                      start ftest2-file key is >= ftest2-altkey2
                   when start-gt
                      start ftest2-file key is > ftest2-altkey2
                end-evaluate
                if ftest-ok
                   move "Start Alt2. Successful" to msg-out
                end-if
           end-evaluate
        when fkey-2
           if control-value < primary-field or
                            > alt2-field
              move 1 to accept-control
           else
              move control-value to save-position
              perform 3000-hex
              if all-done
                 move 1 to accept-control
                 move save-position to control-value
                 move zero to key-status
              else
                 move 1 to accept-control
                 add 1, save-position giving control-value
              end-if
           end-if
        when start-it-trans
           start transaction
           if ftest-ok
              move "Start Successful" to msg-out
           end-if
        when commit-it
           commit
           if ftest-ok
              move "Commit Successful" to msg-out
           end-if
        when rollback-it
           rollback
           if ftest-ok
              move "Rollback Successful" to msg-out
           end-if
        when show-about
           display floating window line 3 column 30
                 size 40 lines 7
                 with system menu cell size is label fixed-font
                 background-low boxed shadow
                 handle is about-window-handle
                 display about-screen
                 accept about-screen
                 close window about-window-handle
        when load-file
          perform  9999-load-file thru 9999-exit
        when other
           move 1 to accept-control
     end-evaluate.

3000-hex.
     move zero to hex-error-visible.
     move control-value to save-position2.
     display floating window line 10 column 25
                             size 30 lines 8
             with system menu cell size is label fixed-font
             background-low boxed shadow
             handle is hex-window-handle.
     evaluate save-position2
        when primary-field
           if primary-is-hex
              move ftest-key-hex to work-4
           else
              move ftest-key to work-4
           end-if
        when alt2-field
           if alt2-is-hex
              move ftest-altkey2-hex to work-4
           else
              move ftest-altkey2 to work-4
           end-if
        when alt-seg1-field
           if key1-seg1-is-hex
              move ftest-key1-seg1-hex to work-2
           else
              move ftest-key1-seg1 to work-2
           end-if
        when alt-seg2-field
           if key1-seg2-is-hex
              move ftest-key1-seg2-hex to work-2
           else
              move ftest-key1-seg2 to work-2
           end-if
     end-evaluate
     if save-position2 = primary-field or
                        alt2-field
        move 0 to hex-4-visible
                  2-byte-label-visible
        move 1 to hex-8-visible
                  4-byte-label-visible
        call "ascii2hex" using work-4 (1:2) hex-8-data (1:4)
        call "ascii2hex" using work-4 (3:2) hex-8-data (5:4)
     else
        move 1 to hex-4-visible
                  2-byte-label-visible
        move 0 to hex-8-visible
                  4-byte-label-visible
        call "ascii2hex" using work-2 hex-4-data
     end-if.
     set data-ok to false.
     perform until data-ok or all-done
        display hex-screen
        accept hex-screen on exception continue
        end-accept
      end-perform.
      close window hex-window-handle.

3001-4-hex-check.
     if hex-4-data is hex-chars
        set data-ok to true
        move 2 to accept-control
        call "hex2ascii" using work-2 hex-4-data
        evaluate save-position2
           when alt-seg1-field
              move work-2 to ftest-key1-seg1-hex
              if work-2 is displayable
                 move work-2 to ftest-key1-seg1-display
                 set key1-seg1-is-hex to false
              else
                 move all "*" to ftest-key1-seg1-display
                 set key1-seg1-is-hex to true
              end-if
           when alt-seg2-field
              move work-2 to ftest-key1-seg2-hex
              if work-2 is displayable
                 move work-2 to ftest-key1-seg2-display
                 set key1-seg2-is-hex to false
              else
                 move all "*" to ftest-key1-seg2-display
                 set key1-seg2-is-hex to true
              end-if
        end-evaluate
     else
        move 1 to hex-error-visible
                  accept-control
        display hex-error
     end-if.


3002-8-hex-check.
     if hex-8-data is hex-chars
        set data-ok to true
        move 2 to accept-control
        call "hex2ascii" using work-4 (1:2) hex-8-data (1:4)
        call "hex2ascii" using work-4 (3:2) hex-8-data (5:4)
        evaluate save-position2
           when primary-field
              move work-4 to ftest-key-hex
              if work-4 is displayable
                 move work-4 to ftest-key-display
                 set primary-is-hex to false
              else
                 move all "*" to ftest-key-display
                 set primary-is-hex to true
              end-if
           when alt2-field
              move work-4 to ftest-altkey2-hex
              if work-4 is displayable
                 move work-4 to ftest-altkey2-display
                 set alt2-is-hex to false
              else
                 move all "*" to ftest-altkey2-display
                 set alt2-is-hex to true
              end-if
        end-evaluate
     else
        move 1 to hex-error-visible
                  accept-control
        display hex-error
     end-if.

9010-open-flags.
     call "w$menu" using wmenu-disable, menu-handle, open-it-input.
     call "w$menu" using wmenu-disable, menu-handle, open-it-output.
     call "w$menu" using wmenu-disable, menu-handle, open-it-io.

     move 1 to close-enabled,
               io1-enabled,
               io2-enabled,
               io3-enabled,
               read1-enabled,
               read2-enabled,
               read3-enabled,
               start-enabled,
               rlock-enabled,
               key-enabled,
               key1-seg1-enabled,
               key1-seg2-enabled,
               altkey2-enabled,
               number-enabled,
               info-enabled,
               start-type-enabled,
               which-enabled.
     initialize ftest-record.
     move spaces to ftest-key-display,
                    ftest-key1-seg1-display,
                    ftest-key1-seg2-display
                    ftest-altkey2-display.
    move 1 to accept-control.
    move primary-field to control-value.

9020-close-flags.
     call "w$menu" using wmenu-enable, menu-handle, open-it-input.
     call "w$menu" using wmenu-enable, menu-handle, open-it-output.
     call "w$menu" using wmenu-enable, menu-handle, open-it-io.
     move 0 to close-enabled,
               io1-enabled,
               io2-enabled,
               io3-enabled,
               read1-enabled,
               read2-enabled,
               read3-enabled,
               start-enabled,
               rlock-enabled,
               key-enabled,
               key1-seg1-enabled,
               key1-seg2-enabled,
               altkey2-enabled,
               number-enabled,
               info-enabled,
               start-type-enabled,
               which-enabled.
     initialize ftest-record.
     move spaces to ftest-key-display,
                    ftest-key1-seg1-display,
                    ftest-key1-seg2-display
                    ftest-altkey2-display.

9030-save-operation.
     move control-value to last-io-field-used.
     move 1 to accept-control.
     move primary-field to control-value.

9040-reset-cursor.
     move 1 to accept-control.
     move last-io-field-used to control-value.

9050-move-data.
     if primary-is-hex
        move ftest-key-hex to ftest-key
     else
        move ftest-key-save to ftest-key
     end-if.
     if key1-seg1-is-hex
        move ftest-key1-seg1-hex to ftest-key1-seg1
     else
        move ftest-key1-seg1-save to ftest-key1-seg1
     end-if.
     if key1-seg2-is-hex
        move ftest-key1-seg2-hex to ftest-key1-seg2
     else
        move ftest-key1-seg2-save to ftest-key1-seg2
     end-if.
     if alt2-is-hex
        move ftest-altkey2-hex to ftest-altkey2
     else
        move ftest-altkey2-save to ftest-altkey2
     end-if.
     set primary-is-hex,
         key1-seg1-is-hex,
         key1-seg2-is-hex,
         alt2-is-hex
            to false.

9060-move-data.
     if ftest-key is displayable
        move ftest-key to ftest-key-display
        set primary-is-hex to false
     else
        set primary-is-hex to true
        move "****" to ftest-key-display
        move ftest-key to ftest-key-hex
     end-if.
     if ftest-key1-seg1 is displayable
        set key1-seg1-is-hex to false
        move ftest-key1-seg1 to ftest-key1-seg1-display
     else
        set key1-seg1-is-hex to true
        move "**" to ftest-key1-seg1-display
        move ftest-key1-seg1 to ftest-key1-seg1-hex
     end-if.
     if ftest-key1-seg2 is displayable
        set key1-seg2-is-hex to false
        move ftest-key1-seg2 to ftest-key1-seg2-display
     else
        move "**" to ftest-key1-seg2-display
        move ftest-key1-seg2 to ftest-key1-seg2-hex
        set key1-seg2-is-hex to true
     end-if.
     if ftest-altkey2 is displayable
        set alt2-is-hex to false
        move ftest-altkey2 to ftest-altkey2-display
     else
        move "****" to ftest-altkey2-display
        set alt2-is-hex to true
        move ftest-altkey2 to ftest-altkey2-hex
     end-if.

9070-label-visible.
     move 1 to hex-label-visible.
     display hex-label-field.

9080-after-input-field.
     move 0 to hex-label-visible.
     display hex-label-field.
     evaluate control-value
       when primary-field
          if ftest-key-save = "****" and primary-is-hex
             continue
          else
             move ftest-key-save to ftest-key-display
             if ftest-key-save is displayable
                set primary-is-hex to false
             end-if
          end-if
       when alt-seg1-field
          if ftest-key1-seg1-save = "**" and
             key1-seg1-is-hex
                continue
          else
             move ftest-key1-seg1-save to ftest-key1-seg1-display
             if ftest-key1-seg1-save is displayable
                set key1-seg1-is-hex to false
             end-if
          end-if
       when alt-seg2-field
          if ftest-key1-seg2-save = "**" and
             key1-seg2-is-hex
                continue
          else
             move ftest-key1-seg2-save to ftest-key1-seg2-display
             if ftest-key1-seg2-save is displayable
                set key1-seg2-is-hex to false
             end-if
          end-if
       when alt2-field
          if ftest-altkey2-save = "****" and alt2-is-hex
             continue
          else
             move ftest-altkey2-save to ftest-altkey2-display
             if ftest-altkey2-save is displayable
                set alt2-is-hex to false
             end-if
          end-if
     end-evaluate.


9090-hex-off.
     move 0 to hex-label-visible.
     display hex-label-field.

9999-load-file.
     set ok-cancel-type,
         default-1,
         warning-type to true.
     move "Loading file will Destroy Contents" to message-1.
     move "Continue?" to message-2.
     call "message" using message-type,
                          response-type,
                          message-1,
                          message-2.
     if respond-cancel
        move "File Load Cancelled" to msg-out
        go to 9999-exit
     end-if.
     if file-open
        if use-transaction
           close ftest2-file
        else
           close ftest-file
        end-if
        perform 9020-close-flags
     end-if.
     open output ftest-file.
     perform varying indx1 from 1 by 1 until indx1 > 5
       after indx2 from 1 by 1 until indx2 > 5
          add 1 to cntr
          move alpha-area (cntr:10) to ftest-info
          move indx1 to grp1, ftest-key1-seg1, ftest-key1-seg2
          move indx2 to grp2
          move group-item to ftest-key, ftest-altkey2
          move indx1 to ftest-number
          write ftest-record
    end-perform.
    close ftest-file.
    move zero to ftest-number.
    move spaces to ftest-info.
    move "File Load Complete" to msg-out.
9999-exit.
    exit.


*  copy "ftest.cpy".
* Build menu FTEST-MENU and return handle in MENU-HANDLE
* Created by GENMENU on 07-Aug-96
* Source file: "ftest.mnu"

 BUILD-FTEST-MENU.
     PERFORM GEN-FTEST-MENU THRU GEN-FTEST-MENU-EXIT.

 GEN-FTEST-MENU.
     CALL "W$MENU" USING WMENU-NEW
     IF RETURN-CODE = ZERO
         GO TO GEN-FTEST-MENU-EXIT
     END-IF
     MOVE RETURN-CODE TO MENU-HANDLE

     CALL "W$MENU" USING WMENU-NEW
     IF RETURN-CODE = ZERO
         MOVE ZERO TO MENU-HANDLE
         GO TO GEN-FTEST-MENU-EXIT
     END-IF
     MOVE RETURN-CODE TO SUB-HANDLE-1

     CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                         "&File", 0, SUB-HANDLE-1
     CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                         "E&xit", 27

     CALL "W$MENU" USING WMENU-NEW
     IF RETURN-CODE = ZERO
         MOVE ZERO TO MENU-HANDLE
         GO TO GEN-FTEST-MENU-EXIT
     END-IF
     MOVE RETURN-CODE TO SUB-HANDLE-1

     CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                         "&Open Modes", 0, SUB-HANDLE-1
     CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                         "I&nput", 21
     CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                         "&Output", 22
     CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                         "&I-O", 23

     CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                         "&Close", 31

     CALL "W$MENU" USING WMENU-NEW
     IF RETURN-CODE = ZERO
         MOVE ZERO TO MENU-HANDLE
         GO TO GEN-FTEST-MENU-EXIT
     END-IF
     MOVE RETURN-CODE TO SUB-HANDLE-1

     CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                         "&Help", 0, SUB-HANDLE-1
     CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                         "&About", 39.

 GEN-FTEST-MENU-EXIT.
     MOVE ZERO TO RETURN-CODE.
