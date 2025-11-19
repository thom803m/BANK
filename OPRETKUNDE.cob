       IDENTIFICATION DIVISION.
       PROGRAM-ID. OPRETKUNDE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT KUNDEFIL ASSIGN TO "kunder.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD KUNDEFIL.
       01 KUNDE-LINJE PIC X(200).

       WORKING-STORAGE SECTION.
       01 NY-ID         PIC 9(3).
       01 NY-FORNAVN    PIC X(20).
       01 NY-EFTERNAVN  PIC X(20).
       01 TRIM-FORNAVN  PIC X(20).
       01 TRIM-EFTERNAVN PIC X(20).
       01 MAX-ID        PIC 9(3) VALUE 0.
       01 FELT1         PIC X(10).
       01 FELT2         PIC X(20).
       01 FELT3         PIC X(20).
       01 EOF-FLAG      PIC X VALUE "N".
          88 EOF        VALUE "Y".
          88 NOT-EOF    VALUE "N".

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== Opret ny kunde ===".

           *> Læs fil for at finde max eksisterende ID
           MOVE "N" TO EOF-FLAG
           OPEN INPUT KUNDEFIL
           PERFORM UNTIL EOF
               READ KUNDEFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       UNSTRING KUNDE-LINJE DELIMITED BY ";"
                           INTO FELT1 FELT2 FELT3
                       IF FUNCTION NUMVAL(FELT1) > MAX-ID
                           MOVE FUNCTION NUMVAL(FELT1) TO MAX-ID
                       END-IF
               END-READ
           END-PERFORM
           CLOSE KUNDEFIL

           ADD 1 TO MAX-ID
           MOVE MAX-ID TO NY-ID

           DISPLAY "Fornavn: " WITH NO ADVANCING.
           ACCEPT NY-FORNAVN

           DISPLAY "Efternavn: " WITH NO ADVANCING.
           ACCEPT NY-EFTERNAVN

           MOVE FUNCTION TRIM(NY-FORNAVN) TO TRIM-FORNAVN
           MOVE FUNCTION TRIM(NY-EFTERNAVN) TO TRIM-EFTERNAVN

           *> Byg linje til fil
           MOVE ALL SPACES TO KUNDE-LINJE
           STRING
               NY-ID DELIMITED BY SIZE
               ";" DELIMITED BY SIZE
               TRIM-FORNAVN DELIMITED BY SIZE
               ";" DELIMITED BY SIZE
               TRIM-EFTERNAVN DELIMITED BY SIZE
               INTO KUNDE-LINJE
           END-STRING

           OPEN EXTEND KUNDEFIL
           WRITE KUNDE-LINJE AFTER ADVANCING 1 LINE
           CLOSE KUNDEFIL

           DISPLAY "Kunde oprettet! ID: " NY-ID

           MOVE 0 TO RETUR
           EXIT PROGRAM.
