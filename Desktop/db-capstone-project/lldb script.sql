
create view OrdersView as select OrderID, Quantity, Cost from orders
where Quantity > 2;

select * from OrdersView;

delimiter //
create procedure GetMaxQuantity()
begin
select max(Quantity) as 'Max Quantity in Orders' from orders;
end //
delimiter ;

call GetMaxQuantity();

prepare GetOrderDetail from 'select * from OrdersView where OrderID = ?';

set @id = 1;
execute GetOrderDetail using @id;

delimiter //
create procedure CancelOrder(ID int)
begin
declare confirmation varchar(255);
set confirmation = concat('Order ', ID, ' is Cancelled');
delete from orders
where OrderID = ID;
select confirmation;
end //
delimiter ;

drop procedure CancelOrder;

call CancelOrder(5);
