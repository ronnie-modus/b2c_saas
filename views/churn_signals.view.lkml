view: churn_signals {
  sql_table_name: public.churn_signals ;;

  dimension: signal_id {
    type: string
    sql: ${TABLE}.signal_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
    hidden: yes
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
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

  dimension: is_resolved {
    type: yesno
    sql: ${TABLE}.resolved_at IS NOT NULL ;;
    label: "Resolved"
  }

  dimension_group: detected {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.detected_at ;;
    label: "Detected"
  }

  measure: count {
    type: count_distinct
    sql: ${signal_id} ;;
    label: "Churn signals"
  }

  measure: retained {
    type: count_distinct
    sql: ${signal_id} ;;
    filters: [resolution: "retained"]
    label: "Retained"
  }

  measure: retention_save_rate {
    type: number
    sql: ${retained} * 1.0 / NULLIF(${count}, 0) ;;
    value_format_name: percent_1
    label: "Save rate"
  }
}
