*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDT_CUS_CRED_829................................*
DATA:  BEGIN OF STATUS_ZDT_CUS_CRED_829              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDT_CUS_CRED_829              .
CONTROLS: TCTRL_ZDT_CUS_CRED_829
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDT_CUS_CRED_829              .
TABLES: ZDT_CUS_CRED_829               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
