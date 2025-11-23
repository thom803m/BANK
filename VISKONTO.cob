       IDENTIFICATION DIVISION.
       PROGRAM-ID. VISKONTO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KONTOFIL ASSIGN TO "konti.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KONTOFIL.
       01 KONTO-LINJE PIC X(200).

       WORKING-STORAGE SECTION.
       01 SØGE-KONTO-ID PIC 9(3).   *> numerisk
       01 FUNDET        PIC X VALUE "N".
       01 EOF-FLAG      PIC X VALUE "N".
          88 EOF        VALUE "Y".
          88 NOT-EOF    VALUE "N".

       01 FELT1 PIC X(10).
       01 FELT2 PIC X(10).
       01 FELT3 PIC X(20).
       01 FELT4 PIC X(15).
       01 FELT5 PIC X(5).

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== VIS KONTO ===".
           DISPLAY "Indtast Konto-ID: " WITH NO ADVANCING.
           ACCEPT SØGE-KONTO-ID

           MOVE "N" TO EOF-FLAG
           MOVE "N" TO FUNDET

           OPEN INPUT KONTOFIL

           PERFORM UNTIL EOF
               READ KONTOFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       UNSTRING KONTO-LINJE DELIMITED BY ";"
                           INTO FELT1 FELT2 FELT3 FELT4 FELT5
                       IF FUNCTION NUMVAL(FELT1) = SØGE-KONTO-ID
                           DISPLAY "Konto fundet:"
                           DISPLAY "ID: " FUNCTION NUMVAL(FELT1)
                           DISPLAY "Kunde-ID: " FUNCTION NUMVAL(FELT2)
                           DISPLAY "Type: " FUNCTION TRIM(FELT3)
                           DISPLAY "Balance: " FUNCTION TRIM(FELT4) " "
                          FUNCTION TRIM(FELT5)
                           MOVE "Y" TO FUNDET
                       END-IF
               END-READ
           END-PERFORM

           CLOSE KONTOFIL

           IF FUNDET NOT = "Y"
               DISPLAY "Ingen konto med ID: " SØGE-KONTO-ID
           END-IF

           MOVE 0 TO RETUR
           EXIT PROGRAM.
