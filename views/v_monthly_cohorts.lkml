view: v_monthly_cohorts {
  sql_table_name: artlist_demo.v_monthly_cohorts ;;

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Acquisition channel"
  }

  dimension: is_superbowl_cohort {
    type: yesno
    sql: ${TABLE}.is_superbowl_cohort ;;
    label: "Super Bowl cohort"
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

  dimension_group: cohort {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.cohort_month ;;
    label: "Cohort"
  }

  measure: registrations {
    type: sum
    sql: ${TABLE}.registrations ;;
    label: "Registrations"
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
    label: "Conversions"
  }

  measure: cvr_pct {
    type: average
    sql: ${TABLE}.cvr_pct ;;
    value_format_name: percent_1
    label: "CVR %"
  }

  measure: revenue_usd {
    type: sum
    sql: ${TABLE}.revenue_usd ;;
    value_format_name: usd_0
    label: "Revenue (USD)"
  }

  measure: avg_plan_price {
    type: average
    sql: ${TABLE}.avg_plan_price ;;
    value_format_name: usd
    label: "Avg plan price"
  }
}
