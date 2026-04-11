view: v_event_volume_daily {
  sql_table_name: artlist_demo.v_event_volume_daily ;;

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
    label: "Event name"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    label: "Device"
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
    label: "App version"
  }

  dimension: is_mobile_pricing {
    type: yesno
    sql: ${TABLE}.event_name = 'pricing_card_viewed' AND ${TABLE}.device_type = 'mobile' ;;
    label: "Mobile pricing event"
  }

  dimension: is_post_break {
    type: yesno
    sql: ${TABLE}.event_date >= '2026-02-03' ;;
    label: "After Feb 3 break"
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.event_date ;;
    label: "Event"
  }

  measure: total_events {
    type: sum
    sql: ${TABLE}.event_count ;;
    label: "Events"
  }

  measure: total_unique_visitors {
    type: sum
    sql: ${TABLE}.unique_visitors ;;
    label: "Unique visitors"
  }

  measure: total_unique_sessions {
    type: sum
    sql: ${TABLE}.unique_sessions ;;
    label: "Unique sessions"
  }
}
