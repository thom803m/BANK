       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENU.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 MENU-VALG PIC 9.

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "---------------------------------------".
           DISPLAY "1. Vis kunde".
           DISPLAY "2. Vis konto".
           DISPLAY "3. Liste alle kunder".
           DISPLAY "4. Opret ny kunde".
           DISPLAY "5. Afslut".
           DISPLAY "---------------------------------------".
           DISPLAY "Valg: " WITH NO ADVANCING.

           ACCEPT MENU-VALG.

           MOVE MENU-VALG TO RETUR.

           EXIT PROGRAM.
