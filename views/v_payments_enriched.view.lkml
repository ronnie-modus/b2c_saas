view: v_payments_enriched {
  sql_table_name: artlist_demo.v_payments_enriched ;;

  dimension: payment_id {
    type: string
    sql: ${TABLE}.payment_id ;;
    primary_key: yes
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
    label: "Renewal"
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

  dimension: plan_id {
    type: string
    sql: ${TABLE}.plan_id ;;
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

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Acquisition channel"
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
    label: "Country code"
    map_layer_name: countries
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
  }

  dimension: is_vat_eligible {
    type: yesno
    sql: ${TABLE}.is_vat_eligible ;;
    label: "VAT eligible"
  }

  dimension: creator_economy_tier {
    type: string
    sql: ${TABLE}.creator_economy_tier ;;
    label: "Creator economy tier"
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
    label: "Total VAT (USD)"
    sql_distinct_key: ${payment_id} ;;
  }

  measure: failed_payments {
    type: count_distinct
    sql: ${payment_id} ;;
    filters: [status: "failed"]
    label: "Failed payments"
  }

  measure: payment_count {
    type: count_distinct
    sql: ${payment_id} ;;
    label: "Payments"
  }

  measure: failure_rate {
    type: number
    sql: ${failed_payments} * 1.0 / NULLIF(${payment_count}, 0) ;;
    value_format_name: percent_1
    label: "Failure rate"
  }
}
