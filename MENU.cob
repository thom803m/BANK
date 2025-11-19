       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENU.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 BRUGERVALG-TXT PIC X(2).

       LINKAGE SECTION.
       01 MENU-VALG PIC 9.

       PROCEDURE DIVISION USING MENU-VALG.

           DISPLAY "---------------------------------------".
           DISPLAY "     BANK CICS-SYSTEM v1.0".
           DISPLAY "---------------------------------------".
           DISPLAY "1. Vis kunde".
           DISPLAY "2. Vis konto".
           DISPLAY "3. Liste alle kunder".
           DISPLAY "4. Opret ny kunde".
           DISPLAY "5. Afslut".
           DISPLAY "---------------------------------------".
           DISPLAY "Valg: " WITH NO ADVANCING.

           ACCEPT BRUGERVALG-TXT.

           *> Konverter til tal
           MOVE FUNCTION NUMVAL(BRUGERVALG-TXT) TO MENU-VALG.

           EXIT PROGRAM.
