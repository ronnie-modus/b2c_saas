view: user_profiles {
  sql_table_name: public.user_profiles ;;

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
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

  dimension: survey_completed {
    type: yesno
    sql: ${TABLE}.survey_completed_at IS NOT NULL ;;
    label: "Survey completed"
  }
}
