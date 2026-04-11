view: payments {
  sql_table_name: artlist_demo.payments ;;

  dimension: payment_id {
    type: string
    sql: ${TABLE}.payment_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Payment status"
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
    label: "Currency"
  }

  dimension: is_renewal {
    type: yesno
    sql: ${TABLE}.is_renewal ;;
    label: "Renewal payment"
  }

  dimension: is_vat_charged {
    type: yesno
    sql: ${TABLE}.is_vat_charged ;;
    label: "VAT charged"
  }

  dimension: failure_reason {
    type: string
    sql: ${TABLE}.failure_reason ;;
    label: "Failure reason"
  }

  dimension_group: payment {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.payment_timestamp ;;
    label: "Payment"
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.amount_usd ;;
    filters: [status: "success"]
    value_format_name: usd_0
    label: "Total revenue (USD)"
    sql_distinct_key: ${payment_id} ;;
  }

  measure: new_revenue {
    type: sum
    sql: ${TABLE}.amount_usd ;;
    filters: [status: "success", is_renewal: "No"]
    value_format_name: usd_0
    label: "New revenue (USD)"
    sql_distinct_key: ${payment_id} ;;
  }

  measure: renewal_revenue {
    type: sum
    sql: ${TABLE}.amount_usd ;;
    filters: [status: "success", is_renewal: "Yes"]
    value_format_name: usd_0
    label: "Renewal revenue (USD)"
    sql_distinct_key: ${payment_id} ;;
  }

  measure: total_vat {
    type: sum
    sql: ${TABLE}.vat_amount_usd ;;
    filters: [status: "success"]
    value_format_name: usd_0
    label: "Total VAT collected (USD)"
    sql_distinct_key: ${payment_id} ;;
  }

  measure: failed_payments {
    type: count_distinct
    sql: ${payment_id} ;;
    filters: [status: "failed"]
    label: "Failed payments"
  }

  measure: payment_failure_rate {
    type: number
    sql: COUNT(DISTINCT CASE WHEN ${TABLE}.status = 'failed' THEN ${payment_id} END) * 1.0
      / NULLIF(COUNT(DISTINCT ${payment_id}), 0) ;;
    value_format_name: percent_1
    label: "Payment failure rate"
  }
}
