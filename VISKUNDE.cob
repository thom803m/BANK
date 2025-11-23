       IDENTIFICATION DIVISION.
       PROGRAM-ID. VISKUNDE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEFIL ASSIGN TO "kunder.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEFIL.
       01 KUNDE-LINJE          PIC X(200).

       WORKING-STORAGE SECTION.
       01 SØGE-ID              PIC 9(3).
       01 FUNDET               PIC X VALUE "N".
       01 EOF-FLAG             PIC X VALUE "N".
          88 EOF               VALUE "Y".
          88 NOT-EOF           VALUE "N".

       01 FELT1                PIC X(10).
       01 FELT2                PIC X(20).
       01 FELT3                PIC X(20).

       LINKAGE SECTION.
       01 RETUR                PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== VIS KUNDE ===".
           DISPLAY "Indtast Kunde-ID: " WITH NO ADVANCING.
           ACCEPT SØGE-ID

           MOVE "N" TO EOF-FLAG
           MOVE "N" TO FUNDET

           OPEN INPUT KUNDEFIL

           PERFORM UNTIL EOF
               READ KUNDEFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       UNSTRING KUNDE-LINJE DELIMITED BY ";"
                           INTO FELT1 FELT2 FELT3
                       IF FUNCTION NUMVAL(FELT1) = SØGE-ID
                           DISPLAY "Kunde fundet:"
                           DISPLAY "ID: " FUNCTION NUMVAL(FELT1)
                           DISPLAY "Navn: " FUNCTION TRIM(FELT2) " "
                          FUNCTION TRIM(FELT3)
                           MOVE "Y" TO FUNDET
                       END-IF
               END-READ
           END-PERFORM

           CLOSE KUNDEFIL

           IF FUNDET NOT = "Y"
               DISPLAY "Ingen kunde med ID: " SØGE-ID
           END-IF

           MOVE 0 TO RETUR
           EXIT PROGRAM.
