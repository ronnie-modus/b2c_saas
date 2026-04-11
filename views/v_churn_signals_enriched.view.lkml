view: v_churn_signals_enriched {
  sql_table_name: artlist_demo.v_churn_signals_enriched ;;

  dimension: signal_id {
    type: string
    sql: ${TABLE}.signal_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: signal_type {
    type: string
    sql: ${TABLE}.signal_type ;;
    label: "Signal type"
  }

  dimension: resolution {
    type: string
    sql: ${TABLE}.resolution ;;
    label: "Resolution"
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

  dimension: is_intent_mismatch {
    type: yesno
    sql: ${TABLE}.is_intent_mismatch ;;
    label: "Intent mismatch"
  }

  dimension: cancellation_reason {
    type: string
    sql: ${TABLE}.cancellation_reason ;;
    label: "Cancellation reason"
  }

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Acquisition channel"
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

  dimension: creator_economy_tier {
    type: string
    sql: ${TABLE}.creator_economy_tier ;;
    label: "Creator economy tier"
  }

  dimension: creator_type {
    type: string
    sql: ${TABLE}.creator_type ;;
    label: "Creator type"
  }

  dimension: primary_need {
    type: string
    sql: ${TABLE}.primary_need ;;
    label: "Primary need"
  }

  dimension: experience_level {
    type: string
    sql: ${TABLE}.experience_level ;;
    label: "Experience level"
  }

  dimension_group: detected {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.detected_at ;;
    label: "Detected"
  }

  dimension_group: resolved {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.resolved_at ;;
    label: "Resolved"
  }

  measure: signal_count {
    type: count_distinct
    sql: ${signal_id} ;;
    label: "Churn signals"
  }

  measure: retained_count {
    type: count_distinct
    sql: ${signal_id} ;;
    filters: [resolution: "retained"]
    label: "Retained"
  }

  measure: save_rate {
    type: number
    sql: ${retained_count} * 1.0 / NULLIF(${signal_count}, 0) ;;
    value_format_name: percent_1
    label: "Save rate"
  }
}
