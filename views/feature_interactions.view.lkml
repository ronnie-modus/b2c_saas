view: feature_interactions {
  sql_table_name: public.feature_interactions ;;

  dimension: interaction_id {
    type: string
    sql: ${TABLE}.interaction_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: feature_name {
    type: string
    sql: ${TABLE}.feature_name ;;
    label: "Feature"
  }

  dimension: interaction_type {
    type: string
    sql: ${TABLE}.interaction_type ;;
    label: "Interaction type"
  }

  dimension: days_since_registration {
    type: number
    sql: ${TABLE}.days_since_registration ;;
    label: "Days since registration"
  }

  dimension: is_collections_feature {
    type: yesno
    sql: ${TABLE}.feature_name = 'ai_collections' ;;
    label: "AI Collections"
  }

  dimension: is_early_week {
    type: yesno
    sql: ${TABLE}.days_since_registration <= 7 ;;
    label: "Within first 7 days"
  }

  dimension_group: interacted {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.interacted_at ;;
    label: "Interacted"
  }

  measure: count {
    type: count_distinct
    sql: ${interaction_id} ;;
    label: "Feature interactions"
  }

  measure: users_adopted_collections {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [
      is_collections_feature: "Yes",
      is_early_week: "Yes"
    ]
    label: "Users w/ early Collections adoption"
  }
}
