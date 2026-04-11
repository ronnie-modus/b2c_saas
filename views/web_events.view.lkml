view: web_events {
  sql_table_name: public.web_events ;;

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    hidden: yes
  }

  dimension: visitor_id {
    type: string
    sql: ${TABLE}.visitor_id ;;
    hidden: yes
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
    label: "Event name"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    label: "Device type"
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
    label: "App version"
  }

  dimension: user_status {
    type: string
    sql: ${TABLE}.user_status ;;
    label: "User status"
  }

  dimension: is_funnel_cta {
    type: yesno
    sql: ${TABLE}.is_funnel_cta ;;
    label: "Funnel CTA"
  }

  dimension: is_pricing_event {
    type: yesno
    sql: ${TABLE}.event_name = 'pricing_card_viewed' ;;
    label: "Pricing card view event"
  }

  dimension: is_mobile {
    type: yesno
    sql: ${TABLE}.device_type = 'mobile' ;;
    label: "Mobile"
  }

  dimension: is_desktop {
    type: yesno
    sql: ${TABLE}.device_type = 'desktop' ;;
    label: "Desktop"
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.event_timestamp ;;
    label: "Event"
  }

  measure: event_count {
    type: count
    label: "Events"
  }

  measure: unique_visitors {
    type: count_distinct
    sql: ${visitor_id} ;;
    label: "Unique visitors"
  }

  measure: unique_sessions {
    type: count_distinct
    sql: ${session_id} ;;
    label: "Unique sessions"
  }

  measure: mobile_pricing_events {
    type: count
    filters: [
      is_pricing_event: "Yes",
      is_mobile: "Yes"
    ]
    label: "Mobile pricing card views"
  }

  measure: desktop_pricing_events {
    type: count
    filters: [
      is_pricing_event: "Yes",
      is_desktop: "Yes"
    ]
    label: "Desktop pricing card views"
  }
}
