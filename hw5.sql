USE goit_rdb_hw_03;

SELECT 
    id,
    order_id,
    product_id,
    quantity,
    divide_float(quantity, 2) AS divided_quantity
FROM order_details;