USE task;

SELECT 
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name) AS CustomerName,
    cus.city,
    cus.state State_abbrev,
	map.Full_Name as state,
    ord.order_date,
    CAT.category_name,
    br.brand_name,
    prod.product_name,
    CONCAT(sff.first_name, ' ', sff.last_name) AS Sales_Rep,
    st.store_name,
    SUM(ite.quantity) AS Sales_volume,
    SUM((ite.list_price * ite.quantity) * (1 - ite.discount)) AS Revenue

FROM 
	    sales.orders ord
JOIN 
    sales.customers cus 
	ON ord.customer_id = cus.customer_id

JOIN 
    sales.order_items ite 
	ON ite.order_id = ord.order_id
JOIN 
    production.products prod
	ON prod.product_id = ite.product_id
JOIN 
    production.categories CAT
	ON CAT.category_id = prod.category_id
JOIN 
    production.brands br
	ON br.brand_id = prod.brand_id
JOIN 
    sales.stores st 
	ON st.store_id = ord.store_id
JOIN 
  sales.staffs sff 
	ON sff.staff_id = ord.staff_id
join state_mapping map 
on map.Abbrev = cus.state  



GROUP BY 
    ord.order_id, 
    CONCAT(cus.first_name, ' ', cus.last_name), 
    cus.city, 
    cus.state, 
    ord.order_date, 
    prod.product_name,
    CAT.category_name, 
    br.brand_name, 
    st.store_name, 
    CONCAT(sff.first_name, ' ', sff.last_name),
	Full_Name



