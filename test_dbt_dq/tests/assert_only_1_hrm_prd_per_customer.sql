select
  customer
 ,period_end
 ,count(distinct product) as count_hrm_products
from {{ ref('v_invoicing_lineitems') }}
where category = 'HRM'
group by 1,2
having count(distinct product) > 1
