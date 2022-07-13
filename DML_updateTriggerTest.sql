/*For testing of TRG_LEASING_PRE_UPDATE_ENDDATE:
    When this update is performed on the testdaten, "total" of leasing record 1 should be updated from 99,95 to 39,98 by the trigger
*/

UPDATE leasing
SET enddate = TO_DATE('12.07.2022','DD.MM.YYYY')
WHERE lid=1;