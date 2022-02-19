with customer_latest_subscription_status as
(
  select
    customer
   ,id
   ,status
   ,row_number() over (partition by customer, id order by date desc) as rn
  from {{ ref('v_invoicing_subscriptions') }}  
)
, active_subscription as
(
  select
    customer
   ,sum(case when status = 'start' then 1 else 0 end) as count_active_subscription
  from customer_latest_subscription_status
  where rn = 1
  group by 1
)
select
  distinct customer
from active_subscription
where count_active_subscription > 1
