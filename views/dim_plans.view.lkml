view: dim_plans {
  sql_table_name: artlist_demo.dim_plans ;;

  dimension: plan_id {
    type: string
    sql: ${TABLE}.plan_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: plan_name {
    type: string
    sql: ${TABLE}.plan_name ;;
    label: "Plan name"
  }

  dimension: plan_category {
    type: string
    sql: ${TABLE}.plan_category ;;
    label: "Plan category"
  }

  dimension: billing_period {
    type: string
    sql: ${TABLE}.billing_period ;;
    label: "Billing period"
  }

  dimension: price_monthly_usd {
    type: number
    sql: ${TABLE}.price_monthly_usd ;;
    value_format_name: usd
    label: "Plan price (monthly USD)"
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Plan active"
  }

  dimension: is_ai_plan {
    type: yesno
    sql: ${TABLE}.plan_category = 'ai_suite' ;;
    label: "AI plan"
  }

  dimension: is_max_plan {
    type: yesno
    sql: ${TABLE}.plan_category = 'max' ;;
    label: "Max plan"
  }
}
