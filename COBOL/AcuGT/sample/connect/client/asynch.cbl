identification division.
program-id. asynch.
author. MJE.
remarks.
      Used to test asynchronous calls.  Need prog2  on server.

working-storage section.
01  h-call-prog2                              handle.
01  state-of-call                             pic s9.
01  call-status                               pic xx.
      88  call-complete        value "ok".
01  customer-info.
      05  requested-age.
           10  low-age                     pic x(2).
           10  high-age                    pic x(2).
      05  age-group-count                pic 9(3).

procedure division.
main-logic.
      move "35" to low-age.
      move "39" to high-age.
      call "C$ASYNCRUN" using h-call-prog2 "prog2" customer-info.
      if return-code not equal zero
           display "CALL ERROR#: " return-code
           accept omitted
           stop run
      end-if.
      display "age-group-count immediately after async call: "
          age-group-count.
      display "Begin sleep for 5".
      call "C$SLEEP" using 5.
      display "End sleep, call asyncpoll".
      perform until call-complete
       call "C$ASYNCPOLL" using
           h-call-prog2 state-of-call customer-info
       if return-code not equal zero
           display "CALL ERROR#: " return-code
           accept omitted
           stop run
       end-if
       if state-of-call = 1
           display "Number of customers between " low-age " and "
                   high-age ": " age-group-count
           set call-complete to true
           accept omitted
       end-if
      end-perform.
      stop run.
