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
       01 NY-ID         PIC X(20).
       01 NY-FORNAVN    PIC X(50).
       01 NY-EFTERNAVN  PIC X(50).

       01 LINJE PIC X(200).

       LINKAGE SECTION.
       01 RETUR PIC 9.

       PROCEDURE DIVISION USING RETUR.

           DISPLAY "=== Opret ny kunde ===".

           DISPLAY "Fornavn: " WITH NO ADVANCING.
           ACCEPT NY-FORNAVN.

           DISPLAY "Efternavn: " WITH NO ADVANCING.
           ACCEPT NY-EFTERNAVN.

           DISPLAY "Kunde-ID: " WITH NO ADVANCING.
           ACCEPT NY-ID.

           MOVE ALL SPACES TO KUNDE-LINJE

           STRING
               FUNCTION TRIM(NY-ID) DELIMITED BY SIZE
               ";"
               FUNCTION TRIM(NY-FORNAVN) DELIMITED BY SIZE
               ";"
               FUNCTION TRIM(NY-EFTERNAVN) DELIMITED BY SIZE
               INTO KUNDE-LINJE
           END-STRING

           OPEN EXTEND KUNDEFIL
           WRITE KUNDE-LINJE
           CLOSE KUNDEFIL


           DISPLAY "Kunde oprettet!".

           MOVE 0 TO RETUR
           EXIT PROGRAM.
