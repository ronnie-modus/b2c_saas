- dashboard: retention_churn
  title: "Retention & Churn"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Churn signals, AI Collections retention lift, intent mismatch, dunning"

  filters:
    - name: date_range
      title: "Subscription started"
      type: field_filter
      explore: users
      field: subscriptions.started_date
      default_value: "365 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: plan_category
      title: "Plan category"
      type: field_filter
      explore: users
      field: dim_plans.plan_category
      ui_config:
        type: checkboxes
        display: popover

  elements:
    - title: "Overall churn rate"
      name: kpi_churn_rate
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.churn_rate]
      comparison_type: change
      comparison_reverse_colors: true
      show_comparison_label: true
      listen:
        date_range: subscriptions.started_date
        plan_category: dim_plans.plan_category
      row: 0
      col: 0
      width: 6
      height: 4

    - title: "Intent mismatch churn rate"
      name: kpi_mismatch_churn
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.mismatch_churn_rate]
      comparison_type: value
      comparison_reverse_colors: true
      show_comparison_label: true
      listen:
        date_range: subscriptions.started_date
      row: 0
      col: 6
      width: 6
      height: 4
      note_state: expanded
      note_display: below
      note_text: "Users who said AI tools but bought stock plan — 1.8x higher churn"

    - title: "Churn signal save rate"
      name: kpi_save_rate
      model: artlist_demo
      explore: users
      type: single_value
      fields: [churn_signals.retention_save_rate]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: subscriptions.started_date
      row: 0
      col: 12
      width: 6
      height: 4

    - title: "AI Collections early adopters"
      name: kpi_collections_adopters
      model: artlist_demo
      explore: users
      type: single_value
      fields: [feature_interactions.users_adopted_collections]
      comparison_type: change
      show_comparison_label: true
      row: 0
      col: 18
      width: 6
      height: 4
      note_state: expanded
      note_display: below
      note_text: "Only ~9% of eligible users adopt Collections in week 1 — high leverage opportunity"

    - title: "Churn rate by plan category"
      name: churn_by_plan
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [dim_plans.plan_category, subscriptions.active_subscriptions, subscriptions.cancelled_subscriptions, subscriptions.churn_rate]
      sorts: [subscriptions.churn_rate desc]
      limit: 10
      listen:
        date_range: subscriptions.started_date
      row: 4
      col: 0
      width: 12
      height: 8

    - title: "Churn by cancellation reason"
      name: churn_reasons
      model: artlist_demo
      explore: users
      type: looker_bar
      fields: [subscriptions.cancellation_reason, subscriptions.cancelled_subscriptions]
      filters:
        subscriptions.cancellation_reason: "-NULL"
      sorts: [subscriptions.cancelled_subscriptions desc]
      limit: 10
      listen:
        date_range: subscriptions.started_date
        plan_category: dim_plans.plan_category
      row: 4
      col: 12
      width: 12
      height: 8

    - title: "Churn signals over time by type"
      name: churn_signals_time
      model: artlist_demo
      explore: users
      type: looker_line
      fields: [churn_signals.detected_month, churn_signals.count, churn_signals.signal_type]
      pivots: [churn_signals.signal_type]
      sorts: [churn_signals.detected_month asc]
      limit: 36
      listen:
        plan_category: dim_plans.plan_category
      row: 12
      col: 0
      width: 14
      height: 8

    - title: "Signal resolution breakdown"
      name: signal_resolution
      model: artlist_demo
      explore: users
      type: looker_pie
      fields: [churn_signals.resolution, churn_signals.count]
      filters:
        churn_signals.resolution: "-NULL"
      sorts: [churn_signals.count desc]
      limit: 10
      listen:
        date_range: subscriptions.started_date
      row: 12
      col: 14
      width: 10
      height: 8

    - title: "Churn rate: intent mismatch vs matched"
      name: mismatch_vs_matched
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [subscriptions.is_intent_mismatch, subscriptions.churn_rate, subscriptions.count]
      sorts: [subscriptions.is_intent_mismatch desc]
      listen:
        date_range: subscriptions.started_date
        plan_category: dim_plans.plan_category
      row: 20
      col: 0
      width: 12
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Insight 9: AI-tools intent users who bought stock plans churn 1.8x faster"

    - title: "Feature adoption by type"
      name: feature_adoption
      model: artlist_demo
      explore: users
      type: looker_bar
      fields: [feature_interactions.feature_name, feature_interactions.count]
      sorts: [feature_interactions.count desc]
      limit: 10
      listen:
        date_range: subscriptions.started_date
      row: 20
      col: 12
      width: 12
      height: 8
