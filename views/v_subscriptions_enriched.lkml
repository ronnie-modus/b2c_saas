view: v_subscriptions_enriched {
  sql_table_name: artlist_demo.v_subscriptions_enriched ;;

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Status"
  }

  dimension: billing_period {
    type: string
    sql: ${TABLE}.billing_period ;;
    label: "Billing period"
  }

  dimension: cancellation_reason {
    type: string
    sql: ${TABLE}.cancellation_reason ;;
    label: "Cancellation reason"
  }

  dimension: is_dunning {
    type: yesno
    sql: ${TABLE}.is_dunning ;;
    label: "In dunning"
  }

  dimension: is_intent_mismatch {
    type: yesno
    sql: ${TABLE}.is_intent_mismatch ;;
    label: "Intent mismatch"
  }

  dimension: plan_id {
    type: string
    sql: ${TABLE}.plan_id ;;
    label: "Plan ID"
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

  dimension: plan_is_active {
    type: yesno
    sql: ${TABLE}.plan_is_active ;;
    label: "Plan active"
  }

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Acquisition channel"
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
    label: "UTM campaign"
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

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country"
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

  dimension: days_active {
    type: number
    sql: ${TABLE}.days_active ;;
    label: "Days active"
  }

  dimension_group: started {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.started_at ;;
    label: "Started"
  }

  dimension_group: cancelled {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.cancelled_at ;;
    label: "Cancelled"
  }

  measure: count {
    type: count_distinct
    sql: ${subscription_id} ;;
    label: "Subscriptions"
  }

  measure: active_count {
    type: count_distinct
    sql: ${subscription_id} ;;
    filters: [status: "active"]
    label: "Active subscriptions"
  }

  measure: cancelled_count {
    type: count_distinct
    sql: ${subscription_id} ;;
    filters: [status: "cancelled"]
    label: "Cancelled subscriptions"
  }

  measure: churn_rate {
    type: number
    sql: ${cancelled_count} * 1.0 / NULLIF(${count}, 0) ;;
    value_format_name: percent_1
    label: "Churn rate"
  }

  measure: avg_price_paid {
    type: average
    sql: ${TABLE}.price_paid_usd ;;
    value_format_name: usd
    label: "Avg price paid"
  }

  measure: avg_days_active {
    type: average
    sql: ${TABLE}.days_active ;;
    value_format_name: decimal_1
    label: "Avg days active"
  }

  measure: mismatch_count {
    type: count_distinct
    sql: ${subscription_id} ;;
    filters: [is_intent_mismatch: "Yes"]
    label: "Intent mismatch subscriptions"
  }
}
