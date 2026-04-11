view: v_users_enriched {
  sql_table_name: artlist_demo.v_users_enriched ;;

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
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

  dimension: is_superbowl_cohort {
    type: yesno
    sql: ${TABLE}.is_superbowl_cohort ;;
    label: "Super Bowl cohort"
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

  dimension: sub_region {
    type: string
    sql: ${TABLE}.sub_region ;;
    label: "Sub-region"
  }

  dimension: creator_economy_tier {
    type: string
    sql: ${TABLE}.creator_economy_tier ;;
    label: "Creator economy tier"
  }

  dimension: is_vat_eligible {
    type: yesno
    sql: ${TABLE}.is_vat_eligible ;;
    label: "VAT eligible"
  }

  dimension: default_currency {
    type: string
    sql: ${TABLE}.default_currency ;;
    label: "Currency"
  }

  dimension: creator_type {
    type: string
    sql: ${TABLE}.creator_type ;;
    label: "Creator type"
  }

  dimension: experience_level {
    type: string
    sql: ${TABLE}.experience_level ;;
    label: "Experience level"
  }

  dimension: primary_need {
    type: string
    sql: ${TABLE}.primary_need ;;
    label: "Primary need"
  }

  dimension: publishing_frequency {
    type: string
    sql: ${TABLE}.publishing_frequency ;;
    label: "Publishing frequency"
  }

  dimension: team_size {
    type: string
    sql: ${TABLE}.team_size ;;
    label: "Team size"
  }

  dimension: survey_version {
    type: string
    sql: ${TABLE}.survey_version ;;
    label: "Survey version"
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
}
