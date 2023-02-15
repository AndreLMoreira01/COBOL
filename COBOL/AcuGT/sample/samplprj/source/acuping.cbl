identification division.
program-id.     acuping.
environment division.
configuration section.
special-names.
input-output section.
file-control.
    select optional acuping-file
        assign to log-file-name
        organization is indexed
        access mode is dynamic
        record key is fl-msg-id
        file status is acuping-status.
data division.
file section.
fd  acuping-file.
01  acuping-record.
    05  fl-msg-type              pic 9.
    05  acuping-rec.
        10  fl-msg-id            pic 9(6).
        10  fl-time-at-client    pic 9(8).
        10  fl-time-at-server    pic 9(8).
        10  fl-round-trip-time   pic 9(8).
        10  fl-error-code        pic x(4).

working-storage section.
78  page-size                           value 11.

    copy "def/acucobol.def".
    copy "def/acugui.def".
    copy "def/crtvars.def".

01  key-status is special-names crt status pic 9(5) value 0.
    88  exit-pressed            value 27.
    88  send-pressed            value 100.
    88  clear-pressed           value 200.

01  acuping-status              pic xx.

77  large-font                  usage handle of font large-font.
77  default-font                handle of font default-font.
77  AcuPing-Window-Handle       handle of window.

77  scr-log-file-name           pic x(40).
01  current-time                pic 9(8).
01  newline                     pic x value H"0A".
01  log-file-name               pic x(40) value "acuping.log".

01  error-received              pic 9(4).

01  delay-btwn-pings            pic 9(4)     value 0.
01  num-of-pings                pic 9999     value 1.
01  this-delay                  pic 999v9.

01  server-name                 pic x(30).
01  server-message.
    05  msg-type                pic 9    value 1.
    05  server-msg.
        10  msg-id              pic 9(6) value 0.
        10  time-at-client.
            15  tac1            pic 99.
            15  tac2            pic 99.
            15  tac3            pic 99.
            15  tac4            pic 99.
        10  time-at-server      pic 9(8).
        10  time-at-server-fields redefines time-at-server.
            15  tas1            pic 99.
            15  tas2            pic 99.
            15  tas3            pic 99.
            15  tas4            pic 99.
        10  round-trip-time.
            15  rtt1            pic 99.
            15  rtt2            pic 99.
            15  rtt3            pic 99.
            15  rtt4            pic 99.
        10  error-code          pic x(4).

01  server-message-disp.
    05  msg-type-d              pic 9    value 1.
    05  server-msg-d.
        10  msg-id-d            pic 9(6) value 0.
        10  time-at-client-d.
            15  tac1-d          pic 99.
            15  filler          pic x    value ":".
            15  tac2-d          pic 99.
            15  filler          pic x    value ":".
            15  tac3-d          pic 99.
            15  filler          pic x    value ".".
            15  tac4-d          pic 99.
        10  time-at-server-d.
            15  tas1-d          pic 99.
            15  filler          pic x    value ":".
            15  tas2-d          pic 99.
            15  filler          pic x    value ":".
            15  tas3-d          pic 99.
            15  filler          pic x    value ":".
            15  tas4-d          pic 99.
        10  round-trip-time-d.
            15  rtt1-d          pic 99.
            15  filler          pic x    value ":".
            15  rtt2-d          pic 99.
            15  filler          pic x    value ":".
            15  rtt3-d          pic 99.
            15  filler          pic x    value ".".
            15  rtt4-d          pic 99.
        10  error-code-d        pic x(4).

01  number-reads-needed         pic 99.

77  state-flag                          pic x.
    88  reading-forwards                value "f".
    88  reading-backwards               value "b".
    88  at-start                        value "s".
    88  at-end                          value "e".

screen section.
01  AcuPing-Screen.
    03  graphical.
        05  label line 2 col 1 size 66 centered
            title "AcuPing Server Diagnostic" font large-font.

        05  label line 6 col 4
            title "Log File Name".
        05  entry-field line 6 col 24 3-d
            value scr-log-file-name,
            max-text 40
            after procedure is ck-log-file-name.

        05  label line 10 col 4
            title "Server to Ping".
        05  entry-field line 10 col 24 3-d
            value server-name
            max-text 30.

        05  label line 12 col 4
            title "Number of Pings".
        05  entry-field line 12 col 24 3-d
            value num-of-pings.

        05  label line 14 col 4
            title "Ping Delay (1/10 sec)".
        05  entry-field line 14 col 24 3-d
            value delay-btwn-pings.

        05  label line 20 col 4 size 11 centered
            title "Msg ID".
        05  label line 20 col 15 size 15 centered
            title "Time At Client".
        05  label line 20 col 30 size 15 centered
            title "Time At Server".
        05  label line 20 col 45 size 15 centered
            title "Round Trip Time".
        05  list-of-pings list-box line 22 col 4 lines 11 size 55
            unsorted paged 3-d
            data-columns ( 1, 7, 18, 29 )
            display-columns ( 1, 12, 27, 42 )
            alignment ( "c", "c", "c", "c" )
            separation ( 2, 2, 2, 0 )
            dividers ( 2, 2, 2, 0 )
            exception procedure is list-of-pings-handler.

        05  push-button line 34 col 35
            exception-value 100 title "&Send" self-act.
        05  push-button line 34 col 45
            exception-value 200 title "&Clear" self-act.
        05  push-button line 34 col 55
            exception-value 27 title "E&xit" cancel-button self-act.

    03  character.
        05  "AcuPing Server Diagnostic" line 1 col 1 size 66 output centered.

        05  "Log File Name" line 3 col 5.
        05  using scr-log-file-name col 35
            after procedure is ck-log-file-name.

        05  "Server to Ping" line 5 col 5.
        05  using server-name col 35.

        05  "Number of Pings" line 7 col 5.
        05  using num-of-pings pic zzz9 col 35.

        05  "Ping Delay (1/10 sec)" line 9 col 5.
        05  using delay-btwn-pings pic zzz9 col 35.

        05  "Msg ID  Time At Client  Time At Server  Round Trip Time"
            line 11 col 9.
        05  list-of-pings list-box line 12 col 5 lines 11 size 60
            unsorted paged
            data-columns ( 1, 7, 18, 29 )
            display-columns ( 1, 12, 28, 44 )
            alignment ( "r", "l", "l", "l" )
            separation ( 20, 2, 2, 0 )
            dividers ( 2, 2, 2, 0 )
            exception procedure is list-of-pings-handler.

        05  "F1=Send  F2=Clear  ESC=Exit" line 24 col 1.


procedure division.
main-logic.
* initialize data.
    accept terminal-abilities from terminal-info.

* Display the window
    if has-graphical-interface
        display standard graphical window lines 37 size 66
            control font default-font
            title-bar with system menu auto-minimize auto-resize erase
            no scroll no wrap color is 65793
            title "AcuPing"
            handle is AcuPing-Window-Handle
        set environment "CURSOR-MODE" to 2
    else
        display window erase
        set environment "KEYSTROKE" to "EXCEPTION=100 k1"
        set environment "KEYSTROKE" to "EXCEPTION=200 k2"
        set environment "KEYSTROKE" to "EXCEPTION=27  ^["
    end-if.

    perform initialize-data.
    open output acuping-file.
    close acuping-file.
    open i-o acuping-file.
    initialize acuping-record.

    move zero to key-status.
    display AcuPing-Screen.
    perform until exit-pressed
        accept AcuPing-Screen
            on exception
                if send-pressed
                    perform send-message
                end-if
                if clear-pressed
                    perform clear-list-box
                end-if
        end-accept
    end-perform.

    destroy AcuPing-Window-Handle.
    close acuping-file.
    set environment "CURSOR-MODE" to 3.
    exit program.
    stop run.

initialize-data.
    move log-file-name to scr-log-file-name.
    set at-end to true.

send-message.
    perform send-msg num-of-pings times.

send-msg.
    if num-of-pings = 0
        exit paragraph
    end-if.
    add 1 to msg-id.
    set at-end to true.
    accept current-time from TIME.
    move current-time to time-at-client.

    call "C$PING" using server-name time-at-server.
    move return-code to error-received.

    accept current-time from TIME.
    move current-time to round-trip-time.

*  We need to calculate the round-trip time.
    if rtt4 < tac4
        compute rtt4 = 100 + rtt4 - tac4
        if rtt3 = 0
            move 59 to rtt3
            if rtt2 = 0
                move 59 to rtt2
                if rtt1 = 0
                    move 24 to rtt1
                else
                    subtract 1 from rtt1
                end-if
            else
                subtract 1 from rtt2
            end-if
        else
            subtract 1 from rtt3
        end-if
    else
        subtract tac4 from rtt4
    end-if.
    if rtt3 < tac3
        compute rtt3 = 60 + rtt3 - tac3
        if rtt2 = 0
            move 59 to rtt2
            if rtt1 = 0
                move 24 to rtt1
            else
                subtract 1 from rtt1
            end-if
        else
            subtract 1 from rtt2
        end-if
    else
        subtract tac3 from rtt3
    end-if.
    if rtt2 < tac2
        compute rtt2 = 60 + rtt2 - tac2
        if rtt1 = 0
            move 24 to rtt1
        else
            subtract 1 from rtt1
        end-if
    else
        subtract tac2 from rtt2
    end-if.
    if rtt1 < tac1
        compute rtt1 = 24 + rtt1 - tac1
    else
        subtract tac1 from rtt1
    end-if.

    perform set-server-message-disp.
    modify list-of-pings
        item-to-add = server-msg-d.

    move   msg-type          to  fl-msg-type.
    move   msg-id            to  fl-msg-id.
    move   time-at-server    to  fl-time-at-server.
    move   time-at-client    to  fl-time-at-client.
    move   error-code        to  fl-error-code.

    write acuping-record
        invalid key
               continue
    end-write.
    if error-received not = 0
        move 0 to num-of-pings
        display message box
            "Error Received " error-received newline
            "Please Reset Parameters to Continue"
        type mb-ok
        display AcuPing-Screen
        exit paragraph
    end-if.
    if num-of-pings > 1
        divide delay-btwn-pings by 10 giving this-delay
        call "C$SLEEP" using this-delay
    end-if.

set-server-message-disp.
    move  msg-id to msg-id-d
    move  tac1   to tac1-d.
    move  tac2   to tac2-d.
    move  tac3   to tac3-d.
    move  tac4   to tac4-d.
    move  tas1   to tas1-d.
    move  tas2   to tas2-d.
    move  tas3   to tas3-d.
    move  tas4   to tas4-d.
    move  rtt1   to rtt1-d.
    move  rtt2   to rtt2-d.
    move  rtt3   to rtt3-d.
    move  rtt4   to rtt4-d.


clear-list-box.
    set at-start to true.
    modify list-of-pings reset-list = 1.

list-of-pings-handler.
    if key-status = w-event
       evaluate event-type
          when ntf-pl-next
             perform get-next-item

          when ntf-pl-prev
             perform get-prev-item

          when ntf-pl-nextpage
             modify list-of-pings, mass-update = 1
             perform get-next-item page-size times
             modify list-of-pings, mass-update = 0

          when ntf-pl-prevpage
             modify list-of-pings, mass-update = 1
             perform get-prev-item page-size times
             modify list-of-pings, mass-update = 0

          when ntf-pl-first
             move low-values to fl-msg-id
             start acuping-file, key not < fl-msg-id
                invalid key
                    exit paragraph
             end-start
             set reading-forwards to true
             modify list-of-pings mass-update = 1 reset-list = 1
             perform get-next-item page-size times
             modify list-of-pings, mass-update = 0

          when ntf-pl-last
             move high-values to fl-msg-id
             start acuping-file, key not > fl-msg-id
                invalid key
                    exit paragraph
             end-start
             set reading-backwards to true
             modify list-of-pings mass-update = 1 reset-list = 1
             perform get-prev-item page-size times
             modify list-of-pings, mass-update = 0

          when ntf-pl-search
             inquire list-of-pings, search-text in fl-msg-id
             start acuping-file, key not < fl-msg-id
                invalid key
                    move ntf-pl-last to event-type
                    go to list-of-pings-handler
             end-start
             set reading-forwards to true
             modify list-of-pings, mass-update = 1
             perform get-next-item page-size times
             modify list-of-pings, mass-update = 0
             if at-end
                move ntf-pl-last to event-type
                go to list-of-pings-handler
             end-if
       end-evaluate
    end-if.

get-next-item.
    evaluate true
       when at-start
          move low-values to fl-msg-id
          start acuping-file, key not < fl-msg-id
             invalid key
                 exit paragraph
          end-start
          add 1 to page-size giving number-reads-needed
       when at-end
          exit paragraph
       when reading-backwards
          move page-size to number-reads-needed
       when reading-forwards
          move 1 to number-reads-needed
    end-evaluate.

    perform number-reads-needed times
       read acuping-file next record
          at end
              set at-end to true
              exit paragraph
       end-read
    end-perform.

    perform add-record-to-list.
    perform set-server-message-disp.
    modify list-of-pings, item-to-add = server-msg-d.
    set reading-forwards to true.

get-prev-item.
    evaluate true
       when at-end
          move high-values to fl-msg-id
          start acuping-file, key not > fl-msg-id
             invalid key
                 exit paragraph
          end-start
          add 1 to page-size giving number-reads-needed
       when at-start
          exit paragraph
       when reading-forwards
          move page-size to number-reads-needed
       when reading-backwards
          move 1 to number-reads-needed
    end-evaluate.

    perform number-reads-needed times
       read acuping-file previous record
          at end
              set at-start to true
              exit paragraph
          end-read
    end-perform.

    perform add-record-to-list.
    perform set-server-message-disp.
    modify list-of-pings,
       insertion-index = 1
       item-to-add = server-msg-d.

    set reading-backwards to true.

add-record-to-list.
    move fl-msg-type to msg-type.
    move fl-msg-id to msg-id.
    move fl-time-at-server to time-at-server.
    move fl-time-at-client to time-at-client.
    move fl-error-code to error-code.

ck-log-file-name.
    if log-file-name not = scr-log-file-name
        close acuping-file
        move scr-log-file-name to log-file-name
        open output acuping-file
        close acuping-file
        open i-o acuping-file
        move 0 to msg-id
        perform clear-list-box
    end-if.
