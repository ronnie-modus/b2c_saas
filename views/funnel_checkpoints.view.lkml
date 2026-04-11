view: funnel_checkpoints {
  sql_table_name: public.funnel_checkpoints ;;

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}.checkpoint_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: visitor_id {
    type: string
    sql: ${TABLE}.visitor_id ;;
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

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    label: "Device type"
  }

  dimension: experiment_variant {
    type: string
    sql: ${TABLE}.experiment_variant ;;
    label: "Experiment variant"
  }

  dimension: plan_considered {
    type: string
    sql: ${TABLE}.plan_considered ;;
    label: "Plan considered"
  }

  dimension: funnel_step {
    type: string
    sql: ${TABLE}.funnel_step ;;
    label: "Funnel step"
    order_by_field: funnel_step_order
  }

  dimension: funnel_step_order {
    type: number
    hidden: yes
    sql: CASE ${TABLE}.funnel_step
      WHEN 'landing'              THEN 1
      WHEN 'ai_tool_engaged'      THEN 2
      WHEN 'pricing_viewed'       THEN 3
      WHEN 'plan_explored'        THEN 4
      WHEN 'cta_clicked'          THEN 5
      WHEN 'signup_modal_opened'  THEN 6
      WHEN 'registered'           THEN 7
      WHEN 'trial_active'         THEN 8
      WHEN 'payment_initiated'    THEN 9
      WHEN 'paid_converted'       THEN 10
      ELSE 99
    END ;;
  }

  dimension_group: step {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.step_timestamp ;;
    label: "Step"
  }

  measure: visitors {
    type: count_distinct
    sql: ${visitor_id} ;;
    label: "Unique visitors"
  }
}
