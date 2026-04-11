view: users {
  sql_table_name: public.users ;;

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
    hidden: yes
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

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
    label: "UTM source"
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
    label: "UTM medium"
  }

  dimension: is_superbowl_cohort {
    type: yesno
    sql: ${TABLE}.is_superbowl_cohort ;;
    label: "Super Bowl cohort"
  }

  dimension_group: registered {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.registered_at ;;
    label: "Registered"
  }

  measure: count {
    type: count_distinct
    sql: ${user_id} ;;
    label: "Users"
  }

  measure: superbowl_registrations {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_superbowl_cohort: "Yes"]
    label: "Super Bowl registrations"
  }

  measure: earliest_registration {
    type: string
    sql: CAST(MIN(${TABLE}.registered_at) AS VARCHAR) ;;
    label: "Earliest registration"
  }

  measure: latest_registration {
    type: string
    sql: CAST(MAX(${TABLE}.registered_at) AS VARCHAR) ;;
    label: "Latest registration"
  }
}
