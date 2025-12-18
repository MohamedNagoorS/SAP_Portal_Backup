*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDT_SF_LOGIN_829................................*
DATA:  BEGIN OF STATUS_ZDT_SF_LOGIN_829              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDT_SF_LOGIN_829              .
CONTROLS: TCTRL_ZDT_SF_LOGIN_829
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDT_SF_LOGIN_829              .
TABLES: ZDT_SF_LOGIN_829               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
