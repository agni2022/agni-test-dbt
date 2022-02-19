select
  customer
 ,count(distinct opportunity) as count_successful_opportunity
from {{ ref('v_sales_opportunities') }}
where status = 'won'
group by 1
having count(distinct opportunity) > 1
