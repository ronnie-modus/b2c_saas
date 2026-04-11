view: v_arpu_by_month {
  sql_table_name: artlist_demo.v_arpu_by_month ;;

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

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
  }

  dimension: creator_economy_tier {
    type: string
    sql: ${TABLE}.creator_economy_tier ;;
    label: "Creator economy tier"
  }

  dimension_group: month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.month ;;
    label: "Month"
  }

  measure: subscriptions {
    type: sum
    sql: ${TABLE}.subscriptions ;;
    label: "Subscriptions"
  }

  measure: avg_price {
    type: average
    sql: ${TABLE}.avg_price ;;
    value_format_name: usd
    label: "Avg plan price (ARPU)"
  }

  measure: new_mrr {
    type: sum
    sql: ${TABLE}.new_mrr ;;
    value_format_name: usd_0
    label: "New MRR (USD)"
  }

  measure: renewal_mrr {
    type: sum
    sql: ${TABLE}.renewal_mrr ;;
    value_format_name: usd_0
    label: "Renewal MRR (USD)"
  }

  measure: total_mrr {
    type: number
    sql: ${new_mrr} + ${renewal_mrr} ;;
    value_format_name: usd_0
    label: "Total MRR (USD)"
  }
}
