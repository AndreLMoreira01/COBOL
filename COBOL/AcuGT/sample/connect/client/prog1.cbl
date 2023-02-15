identification division.
program-id. prog1.
working-storage section.
01  err-code                    pic x(2).
01  err-message                 pic x(70).
01  customer-info.
      05  requested-age.
       10  low-age                     pic x(2).
       10  high-age                    pic x(2).
      05  age-group-count                 pic 9(3).
procedure division.
main-logic.
      move "35" to low-age.
      move "39" to high-age.
      call "prog2" using customer-info
       on exception
           perform exception-handling
       end-call.
      display "Number of customers between " low-age " and "
       high-age ": " age-group-count.
      accept omitted.
      stop run.

exception-handling.
      call "C$CALLERR" using err-code, err-message.
      display "Error#: " err-code ", " err-message.
      accept omitted.
      stop run.
