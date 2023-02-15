      * Build menu HELPDEMO-MENU and return handle in MENU-HANDLE
      * Created by GENMENU on 26-Mar-97
      * Source file: "helpmenu.mnu"

       BUILD-HELPDEMO-MENU.
           PERFORM GEN-HELPDEMO-MENU THRU GEN-HELPDEMO-MENU-EXIT.

       GEN-HELPDEMO-MENU.
           CALL "W$MENU" USING WMENU-NEW
           IF RETURN-CODE = ZERO
               GO TO GEN-HELPDEMO-MENU-EXIT
           END-IF
           MOVE RETURN-CODE TO MENU-HANDLE

           CALL "W$MENU" USING WMENU-NEW
           IF RETURN-CODE = ZERO
               MOVE ZERO TO MENU-HANDLE
               GO TO GEN-HELPDEMO-MENU-EXIT
           END-IF
           MOVE RETURN-CODE TO SUB-HANDLE-1

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "&File", 0, SUB-HANDLE-1
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "E&xit", 13

           CALL "W$MENU" USING WMENU-NEW
           IF RETURN-CODE = ZERO
               MOVE ZERO TO MENU-HANDLE
               GO TO GEN-HELPDEMO-MENU-EXIT
           END-IF
           MOVE RETURN-CODE TO SUB-HANDLE-1

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "&Help", 0, SUB-HANDLE-1
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "Help on Current &Item", ITEM-HELP-MODE
           CALL "W$MENU" USING WMENU-ADD, SUB-HANDLE-1, 0, 0,
                               "Help &Cursor", HELP-CURSOR-MODE
           .

       GEN-HELPDEMO-MENU-EXIT.
           MOVE ZERO TO RETURN-CODE.
