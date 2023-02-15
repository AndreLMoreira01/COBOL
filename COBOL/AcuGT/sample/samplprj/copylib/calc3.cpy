      * Build menu CALC-MENU and return handle in MENU-HANDLE
      * Created by GENMENU on 14-Sep-1999
      * Source file: "calc3.mnu"

       BUILD-CALC-MENU.
           PERFORM GEN-CALC-MENU THRU GEN-CALC-MENU-EXIT.

       GEN-CALC-MENU.
           CALL "W$MENU" USING WMENU-NEW GIVING MENU-HANDLE
           IF MENU-HANDLE = ZERO
               GO TO GEN-CALC-MENU-EXIT
           END-IF

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "E&xit", MENU-EXIT

           CALL "W$MENU" USING WMENU-NEW GIVING SUB-HANDLE-1
           IF SUB-HANDLE-1 = ZERO
               MOVE ZERO TO MENU-HANDLE
               GO TO GEN-CALC-MENU-EXIT
           END-IF

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "&Edit", 0, SUB-HANDLE-1
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "Change &sign", MENU-CHANGE-SIGN
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, W-SEPARATOR
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "Clear &entry", MENU-CLEAR-ENTRY
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "&Clear all", MENU-CLEAR-ALL

           CALL "W$MENU" USING WMENU-NEW GIVING SUB-HANDLE-1
           IF SUB-HANDLE-1 = ZERO
               MOVE ZERO TO MENU-HANDLE
               GO TO GEN-CALC-MENU-EXIT
           END-IF

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "&View", 0, SUB-HANDLE-1
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, W-CHECKED,
                               "&2 digits", MENU-2-DIGITS
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "&6 digits", MENU-6-DIGITS
           .

       GEN-CALC-MENU-EXIT.
           MOVE ZERO TO RETURN-CODE.
