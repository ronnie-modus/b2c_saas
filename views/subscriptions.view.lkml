view: subscriptions {
  sql_table_name: artlist_demo.subscriptions ;;

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

  dimension: plan_id {
    type: string
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Subscription status"
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

  dimension: is_cancelled {
    type: yesno
    sql: ${TABLE}.status = 'cancelled' ;;
    label: "Cancelled"
  }

  dimension: is_annual {
    type: yesno
    sql: ${TABLE}.billing_period = 'annual' ;;
    label: "Annual billing"
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

  dimension: days_to_cancel {
    type: number
    sql: EXTRACT(DAY FROM (${TABLE}.cancelled_at - ${TABLE}.started_at)) ;;
    label: "Days to cancel"
  }

  measure: count {
    type: count_distinct
    sql: ${subscription_id} ;;
    label: "Subscriptions"
  }

  measure: active_subscriptions {
    type: count_distinct
    sql: ${subscription_id} ;;
    filters: [status: "active"]
    label: "Active subscriptions"
  }

  measure: cancelled_subscriptions {
    type: count_distinct
    sql: ${subscription_id} ;;
    filters: [status: "cancelled"]
    label: "Cancelled subscriptions"
  }

  measure: churn_rate {
    type: number
    sql: ${cancelled_subscriptions} * 1.0 / NULLIF(${count}, 0) ;;
    value_format_name: percent_1
    label: "Churn rate"
  }

  measure: conversion_rate {
    type: number
    sql: ${count} * 1.0 / NULLIF(${users.count}, 0) ;;
    value_format_name: percent_2
    label: "Convert to pay rate"
  }

  measure: avg_price_paid {
    type: average
    sql: ${TABLE}.price_paid_usd ;;
    value_format_name: usd
    label: "Avg price paid"
  }

  measure: mismatch_churn_rate {
    type: number
    sql: COUNT(DISTINCT CASE WHEN ${TABLE}.status = 'cancelled' AND ${TABLE}.is_intent_mismatch THEN ${subscription_id} END) * 1.0
      / NULLIF(COUNT(DISTINCT CASE WHEN ${TABLE}.is_intent_mismatch THEN ${subscription_id} END), 0) ;;
    value_format_name: percent_1
    label: "Mismatch churn rate"
  }
}
