       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISTEKUNDER.

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
       01 FELT1                PIC X(10).
       01 FELT2                PIC X(20).
       01 FELT3                PIC X(20).

       01 EOF-FLAG             PIC X VALUE "N".
          88 EOF               VALUE "Y".
          88 NOT-EOF           VALUE "N".

       LINKAGE SECTION.
       01 RETUR                PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== LISTE OVER KUNDER ===".

           MOVE "N" TO EOF-FLAG.

           OPEN INPUT KUNDEFIL.

           PERFORM UNTIL EOF
               READ KUNDEFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       IF FUNCTION 
                       LENGTH(FUNCTION TRIM(KUNDE-LINJE)) > 0
                           UNSTRING KUNDE-LINJE
                               DELIMITED BY ";"
                               INTO FELT1 FELT2 FELT3

                           DISPLAY FUNCTION TRIM(FELT1)
                                   "  "
                                   FUNCTION TRIM(FELT2)
                                   " "
                                   FUNCTION TRIM(FELT3)
                       END-IF
               END-READ
           END-PERFORM

           CLOSE KUNDEFIL.

           MOVE 0 TO RETUR
           EXIT PROGRAM.
