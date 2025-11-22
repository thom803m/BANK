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
       01 FELT-ID        PIC X(10).
       01 FELT-FORNAVN   PIC X(50).
       01 FELT-EFTERNAVN PIC X(50).

       01 LAST-ID        PIC 9(5) VALUE 0.
       01 NEW-ID         PIC 9(5).

       01 NY-FORNAVN     PIC X(50).
       01 NY-EFTERNAVN   PIC X(50).

       01 EOF-FLAG PIC X VALUE "N".
          88 EOF     VALUE "Y".
          88 NOT-EOF VALUE "N".

       01 LINJE PIC X(200).

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== Opret ny kunde ===".

      * Indtast navn
           DISPLAY "Fornavn: " WITH NO ADVANCING.
           ACCEPT NY-FORNAVN.

           DISPLAY "Efternavn: " WITH NO ADVANCING.
           ACCEPT NY-EFTERNAVN.

      * Find seneste ID
           OPEN INPUT KUNDEFIL
           PERFORM UNTIL EOF
               READ KUNDEFIL
                   AT END SET EOF TO TRUE
                   NOT AT END
                       IF FUNCTION 
                       LENGTH(FUNCTION TRIM(KUNDE-LINJE)) > 0
                           UNSTRING KUNDE-LINJE
                               DELIMITED BY ";"
                               INTO FELT-ID FELT-FORNAVN FELT-EFTERNAVN

                           IF FUNCTION NUMVAL(FELT-ID) > LAST-ID
                               MOVE FUNCTION NUMVAL(FELT-ID) TO LAST-ID
                           END-IF
                       END-IF
               END-READ
           END-PERFORM
           CLOSE KUNDEFIL

      * Beregn nyt ID
           ADD 1 TO LAST-ID
           MOVE LAST-ID TO NEW-ID

      * Konstruér linjen
           MOVE ALL SPACES TO LINJE

           STRING
               FUNCTION TRIM(NEW-ID) DELIMITED BY SIZE
               ";"
               FUNCTION TRIM(NY-FORNAVN) DELIMITED BY SIZE
               ";"
               FUNCTION TRIM(NY-EFTERNAVN) DELIMITED BY SIZE
               INTO LINJE
           END-STRING

      * Skriv til fil
           OPEN EXTEND KUNDEFIL
           WRITE KUNDE-LINJE FROM LINJE
           CLOSE KUNDEFIL

           DISPLAY "Kunde oprettet! ID: " FUNCTION TRIM(NEW-ID)

           MOVE 0 TO RETUR
           EXIT PROGRAM.
