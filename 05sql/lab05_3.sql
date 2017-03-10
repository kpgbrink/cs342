@lab05_load

-- a. Produce an appropriate phone-book entry for “traditional” 
--    family entries, e.g.: 
--    VanderLinden, Keith and Brenda - 111-222-3333 - 2347 Oxford St.
select h.lastName || ', ' || h.firstName || ' and ' || w.firstName || 
' - ' || hh.phoneNumber || ' - ' || hh.street
from HouseHold hh
join Person h on hh.ID = h.houseHoldID and h.householdRole = 'husband'
join Person w on hh.ID = w.houseHoldID and w.householdRole = 'wife';

-- b. Extend your solution to handle families in which both spouses 
--    keep their own names, e.g.:
--    VanderLinden, Keith and Brenda Roorda - 111-222-3333 - 2347 Oxford St.
select h.lastName || ', ' || h.firstName || ' and ' || w.firstName || ' ' || w.lastName || 
' - ' || hh.phoneNumber || ' - ' || hh.street
from HouseHold hh
join Person h on hh.ID = h.houseHoldID and h.householdRole = 'husband'
join Person w on hh.ID = w.houseHoldID and w.householdRole = 'wife';

-- c. Finally, extend your solution to include single-adult families, e.g.:
--    Doe, Jane - 111-222-3333 - 2347 Main St.
select h.lastName || ', ' || h.firstName || ' and ' || w.firstName || ' ' || w.lastName || 
' - ' || hh.phoneNumber || ' - ' || hh.street
from HouseHold hh
join Person h on hh.ID = h.houseHoldID and h.householdRole = 'husband'
join Person w on hh.ID = w.houseHoldID and w.householdRole = 'wife'
union
select s.lastName || ', ' || s.firstName || 
' - ' || hh.phoneNumber || ' - ' || hh.street
from HouseHold hh
join Person s on hh.ID = s.houseHoldID and s.householdRole = 'single';