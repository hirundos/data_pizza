/*1차 가공 데이터*/
CREATE TABLE bronze AS
    SELECT o.order_id, od.order_detail_id, p.pizza_id, pt.pizza_type_id, o.member_id, m.member_nm, o.date, o.time, od.quantity, p.size, 
		p.price, pt.pizza_nm, pt.pizza_categ, b.bran_id, b.bran_nm, tp.pizza_topping_nm
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


/*2차 가공본*/
-- dim_pizza
CREATE TABLE dim_pizza
AS
SELECT DISTINCT pizza_id, pizza_type_id, size, price
FROM bronze

--dim_mem
CREATE TABLE dim_mem 
AS
SELECT DISTINCT mem_id, mem_nm 
FROM bronze

--dim pizza_type
CREATE TABLE dim_pizza_type 
AS
SELECT DISTINCT pizza_type_id, name, category, ingredients
FROM bronze 

--dim date
CREATE TABLE dim_date
AS
SELECT
  TO_DATE(date, 'YYYY-MM-DD') AS date,
  EXTRACT(YEAR FROM TO_DATE(date, 'YYYY-MM-DD')) AS year,
  EXTRACT(MONTH FROM TO_DATE(date, 'YYYY-MM-DD')) AS month,
  EXTRACT(DAY FROM TO_DATE(date, 'YYYY-MM-DD')) AS day,
  TO_CHAR(TO_DATE(date, 'YYYY-MM-DD'), 'Day') AS weekday,
  CASE 
        WHEN EXTRACT(DOW FROM TO_DATE(date, 'YYYY-MM-DD')) IN (0, 6) 
		THEN 1
        ELSE 0
  END as is_weekend
  FROM 
  (
  	SELECT DISTINCT date
	FROM bronze b 
)

--dim branch
CREATE TABLE dim_branch
AS
SELECT DISTINCT bran_id, bran_nm
FROM pizza.bronze 

-- fact_order_detail
CREATE TABLE fact_order_detail
AS
SELECT DISTINCT order_details_id, order_id, date, mem_id, pizza_id, pizza_type_id , time, size, quantity, 
	price as unit_price, bran_id, (price * quantity ) total_price
FROM bronze