create or replace procedure transferRank(movieOneId integer, movieTwoId integer, transferAmount integer) as
    negativeException exception;
    rankBelowZero exception;
    checkSize integer;
begin
    lock table Movie in exclusive mode;

	-- check if transfer amount is negative.
	if transferAmount < 0 then
		raise negativeException;
	end if;
    
    select rank into checkSize from Movie where id=movieOneId;
    
    if transferAmount > checkSize then
        raise rankBelowZero;
    end if;

	--take value from Movie 1
	update Movie m
		set rank=rank-transferAmount
		where m.id=movieOneId;

	--to add to Movie 2
	update Movie m
		set rank=rank+transferAmount
		where m.id=movieTwoId;

    commit;
    
    exception
        when negativeException then
            raise_application_error(-20001, 'Failed to transfer negative');
            
        when rankBelowZero then
            raise_application_error(-20001, 'Rank cannot be zero');
            
end;
/
show errors;
