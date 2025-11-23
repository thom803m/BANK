       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKMAIN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 MENU-VALG            PIC 9.
       01 RC                   PIC 9. *> Record-Code

       PROCEDURE DIVISION.

           PERFORM MAIN-LOOP
           DISPLAY "---------------------------------------"
           DISPLAY "Afslutter systemet..."
           DISPLAY "---------------------------------------"
           STOP RUN.

       MAIN-LOOP.
           DISPLAY "---------------------------------------"
           DISPLAY "     BANK CICS-SYSTEM v1.0"
           DISPLAY "---------------------------------------"

           PERFORM MENU-HEADER
           ACCEPT MENU-VALG

           PERFORM UNTIL MENU-VALG = 6
               EVALUATE MENU-VALG
                   WHEN 1
                       CALL "VISKUNDE" USING RC
                   WHEN 2
                       CALL "VISKONTO" USING RC
                   WHEN 3
                       CALL "LISTEKUNDER" USING RC
                   WHEN 4
                       CALL "OPRETKUNDE" USING RC
                   WHEN 5
                       CALL "SLETKUNDE" USING RC
                   WHEN 6
                       EXIT PERFORM 
                   WHEN OTHER
                       DISPLAY "Ugyldigt valg."
               END-EVALUATE

               IF MENU-VALG NOT = 6
                   DISPLAY "---------------------------------------"
                   DISPLAY "     BANK CICS-SYSTEM v1.0"
                   DISPLAY "---------------------------------------"
                   PERFORM MENU-HEADER
                   ACCEPT MENU-VALG
               END-IF
           END-PERFORM.

       MENU-HEADER.
           DISPLAY "1. Vis kunde"
           DISPLAY "2. Vis konto"
           DISPLAY "3. Liste alle kunder"
           DISPLAY "4. Opret ny kunde"
           DISPLAY "5. Slet kunde"
           DISPLAY "6. Afslut"
           DISPLAY "---------------------------------------"
           DISPLAY "Valg: " WITH NO ADVANCING.
