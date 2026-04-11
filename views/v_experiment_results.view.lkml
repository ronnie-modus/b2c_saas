view: v_experiment_results {
  sql_table_name: artlist_demo.v_experiment_results ;;

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

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
  }

  dimension_group: assignment {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.assignment_week ;;
    label: "Assignment"
  }

  measure: assigned {
    type: sum
    sql: ${TABLE}.assigned ;;
    label: "Assigned"
  }

  measure: converted {
    type: sum
    sql: ${TABLE}.converted ;;
    label: "Converted"
  }

  measure: cvr_pct {
    type: average
    sql: ${TABLE}.cvr_pct ;;
    value_format_name: percent_2
    label: "CVR %"
  }

  measure: avg_days_to_convert {
    type: average
    sql: ${TABLE}.avg_days_to_convert ;;
    value_format_name: decimal_1
    label: "Avg days to convert"
  }
}
