view: churn_signals {
  sql_table_name: artlist_demo.churn_signals ;;

  dimension: signal_id {
    type: string
    sql: ${TABLE}.signal_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
    hidden: yes
  }

  dimension: signal_type {
    type: string
    sql: ${TABLE}.signal_type ;;
    label: "Signal type"
  }

  dimension: resolution {
    type: string
    sql: ${TABLE}.resolution ;;
    label: "Resolution"
  }

  dimension: is_resolved {
    type: yesno
    sql: ${TABLE}.resolved_at IS NOT NULL ;;
    label: "Resolved"
  }

  dimension_group: detected {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.detected_at ;;
    label: "Detected"
  }

  measure: count {
    type: count_distinct
    sql: ${signal_id} ;;
    label: "Churn signals"
  }

  measure: retained {
    type: count_distinct
    sql: ${signal_id} ;;
    filters: [resolution: "retained"]
    label: "Retained"
  }

  measure: retention_save_rate {
    type: number
    sql: ${retained} * 1.0 / NULLIF(${count}, 0) ;;
    value_format_name: percent_1
    label: "Save rate"
  }
}


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

  dimension: is_early_adoption {
    type: yesno
    sql: ${TABLE}.feature_name = 'ai_collections'
      AND ${TABLE}.days_since_registration <= 7
      AND ${TABLE}.interacted_at >= '2026-02-01' ;;
    label: "AI Collections early adopter (≤7 days)"
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
    filters: [is_early_adoption: "Yes"]
    label: "Users w/ early Collections adoption"
  }
}


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

  dimension: is_mobile_pricing_event {
    type: yesno
    sql: ${TABLE}.event_name = 'pricing_card_viewed' AND ${TABLE}.device_type = 'mobile' ;;
    label: "Mobile pricing card view"
  }

  dimension: is_post_break {
    type: yesno
    sql: ${TABLE}.event_timestamp >= '2026-02-03' ;;
    label: "After Feb 3 tracking break"
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.event_timestamp ;;
    label: "Event"
  }

  measure: event_count {
    type: count ;;
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
    type: count ;;
    filters: [is_mobile_pricing_event: "Yes"]
    label: "Mobile pricing card views"
  }

  measure: desktop_pricing_events {
    type: count ;;
    filters: [event_name: "pricing_card_viewed", device_type: "desktop"]
    label: "Desktop pricing card views"
  }
}


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
