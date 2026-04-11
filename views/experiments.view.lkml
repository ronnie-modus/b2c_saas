view: experiments {
  sql_table_name: public.experiments ;;

  dimension: assignment_id {
    type: string
    sql: ${TABLE}.assignment_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: experiment_name {
    type: string
    sql: ${TABLE}.experiment_name ;;
    label: "Experiment"
  }

  dimension: variant_name {
    type: string
    sql: ${TABLE}.variant_name ;;
    label: "Variant"
  }

  dimension: converted {
    type: yesno
    sql: ${TABLE}.converted ;;
    label: "Converted"
  }

  dimension_group: assigned {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.assigned_at ;;
    label: "Assigned"
  }

  measure: assignments {
    type: count_distinct
    sql: ${assignment_id} ;;
    label: "Assignments"
  }

  measure: conversions {
    type: count_distinct
    sql: ${assignment_id} ;;
    filters: [converted: "Yes"]
    label: "Conversions"
  }

  measure: cvr {
    type: number
    sql: ${conversions} * 1.0 / NULLIF(${assignments}, 0) ;;
    value_format_name: percent_2
    label: "CVR"
  }
}
