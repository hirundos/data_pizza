-- ODS 스키마 생성 및 권한 설정
CREATE SCHEMA IF NOT EXISTS ods; -- ​스테이징/원시 적재용 스키마 생성

/*1차 가공 데이터*/
CREATE TABLE ods_orders AS
    SELECT o.order_id, od.order_detail_id, p.pizza_id, pt.pizza_type_id, o.member_id, m.member_nm, o.date, o.time, od.quantity, p.size, 
		p.price, pt.pizza_nm, pt.pizza_categ, b.bran_id, b.bran_nm, ptto.pizza_topping_id, tp.pizza_topping_nm
	FROM order_detail od
	JOIN orders o 
	ON od.order_id = o.order_id
	JOIN pizza p 
	ON od.pizza_id = p.pizza_id
	JOIN pizza_types pt 
	ON p.pizza_type_id = pt.pizza_type_id
	LEFT JOIN branch b
	ON o.bran_id = b.bran_id
	LEFT JOIN member m 
	ON o.member_id = m.member_id
	LEFT JOIN pizza_type_topping ptto
	ON pt.pizza_type_id = ptto.pizza_type_id
	LEFT JOIN topping tp
	ON ptto.pizza_topping_id = tp.pizza_topping_id
