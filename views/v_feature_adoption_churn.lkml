view: v_feature_adoption_churn {
  sql_table_name: artlist_demo.v_feature_adoption_churn ;;

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

  dimension: primary_need {
    type: string
    sql: ${TABLE}.primary_need ;;
    label: "Primary need"
  }

  dimension: creator_type {
    type: string
    sql: ${TABLE}.creator_type ;;
    label: "Creator type"
  }

  dimension: adopted_collections_week1 {
    type: yesno
    sql: ${TABLE}.adopted_collections_week1 = 1 ;;
    label: "Adopted AI Collections (week 1)"
  }

  dimension: used_any_ai_tool {
    type: yesno
    sql: ${TABLE}.used_any_ai_tool = 1 ;;
    label: "Used any AI tool"
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

  dimension: subscription_status {
    type: string
    sql: ${TABLE}.subscription_status ;;
    label: "Subscription status"
  }

  dimension: is_intent_mismatch {
    type: yesno
    sql: ${TABLE}.is_intent_mismatch ;;
    label: "Intent mismatch"
  }

  dimension_group: registered {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.registered_at ;;
    label: "Registered"
  }

  measure: user_count {
    type: count_distinct
    sql: ${user_id} ;;
    label: "Users"
  }

  measure: collections_adopters {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [adopted_collections_week1: "Yes"]
    label: "Collections early adopters"
  }

  measure: churned_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [subscription_status: "cancelled"]
    label: "Churned users"
  }

  measure: churn_rate {
    type: number
    sql: ${churned_users} * 1.0 / NULLIF(${user_count}, 0) ;;
    value_format_name: percent_1
    label: "Churn rate"
  }

  measure: collections_adoption_rate {
    type: number
    sql: ${collections_adopters} * 1.0 / NULLIF(${user_count}, 0) ;;
    value_format_name: percent_1
    label: "Collections adoption rate"
  }
}
