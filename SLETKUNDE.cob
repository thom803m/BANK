       IDENTIFICATION DIVISION.
       PROGRAM-ID. SLETKUNDE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEFIL ASSIGN TO "kunder.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TEMPFIL ASSIGN TO "kunder_tmp.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEFIL.
       01 KUNDE-LINJE      PIC X(200).

       FD TEMPFIL.
       01 TEMP-LINJE       PIC X(200).

       WORKING-STORAGE SECTION.
       01 SØGE-ID          PIC X(10).
       01 FELT-ID          PIC X(10).
       01 FELT-FORNAVN     PIC X(50).
       01 FELT-EFTERNAVN   PIC X(50).

       01 TRIM-LINJE       PIC X(200).

       01 EOF-FLAG         PIC X VALUE "N".
          88 EOF           VALUE "Y".
          88 NOT-EOF       VALUE "N".

       01 KUNDE-FUNDET     PIC X VALUE "N".
          88 KUNDE-EXISTERER VALUE "Y".
          88 KUNDE-IKKE-FUNDET VALUE "N".

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== SLET KUNDE ===".
           DISPLAY "Indtast Kunde-ID: " WITH NO ADVANCING.
           ACCEPT SØGE-ID.

           MOVE "N" TO KUNDE-FUNDET
           MOVE "N" TO EOF-FLAG

           OPEN INPUT KUNDEFIL
           OPEN OUTPUT TEMPFIL

           PERFORM UNTIL EOF
               READ KUNDEFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       MOVE FUNCTION TRIM(KUNDE-LINJE) TO TRIM-LINJE
                       IF TRIM-LINJE NOT = SPACES
                           UNSTRING KUNDE-LINJE
                               DELIMITED BY ";"
                               INTO FELT-ID FELT-FORNAVN FELT-EFTERNAVN

                           IF FUNCTION NUMVAL(FELT-ID) = 
                               FUNCTION NUMVAL(SØGE-ID)
                               DISPLAY "Kunde med ID " 
                               FUNCTION TRIM(SØGE-ID) " er slettet."
                               SET KUNDE-EXISTERER TO TRUE
                           ELSE
                               WRITE TEMP-LINJE FROM KUNDE-LINJE
                           END-IF
                       END-IF
               END-READ
           END-PERFORM

           CLOSE KUNDEFIL
           CLOSE TEMPFIL

           IF KUNDE-EXISTERER
               CALL 'SYSTEM' USING "move /Y kunder_tmp.txt kunder.txt"
           ELSE
               DISPLAY "Ingen kunde med ID " FUNCTION TRIM(SØGE-ID) 
               " blev fundet."
               CALL 'SYSTEM' USING "del /Q kunder_tmp.txt"
           END-IF

           MOVE 0 TO RETUR
           EXIT PROGRAM.
