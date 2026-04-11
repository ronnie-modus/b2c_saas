- dashboard: revenue_arpu
  title: "Revenue & ARPU"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Revenue breakdown, ARPU compression, VAT, plan mix, geo revenue"

  filters:
    - name: date_range
      title: "Payment date"
      type: field_filter
      explore: users
      field: payments.payment_date
      default_value: "365 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: billing_period
      title: "Billing period"
      type: field_filter
      explore: users
      field: subscriptions.billing_period
      ui_config:
        type: button_toggles
        display: inline

  elements:
    - title: "Total revenue"
      name: kpi_total_rev
      model: artlist_demo
      explore: users
      type: single_value
      fields: [payments.total_revenue]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: payments.payment_date
        billing_period: subscriptions.billing_period
      row: 0
      col: 0
      width: 6
      height: 4

    - title: "New revenue"
      name: kpi_new_rev
      model: artlist_demo
      explore: users
      type: single_value
      fields: [payments.new_revenue]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: payments.payment_date
        billing_period: subscriptions.billing_period
      row: 0
      col: 6
      width: 6
      height: 4

    - title: "Avg plan price (ARPU)"
      name: kpi_arpu
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.avg_price_paid]
      comparison_type: change
      comparison_reverse_colors: false
      show_comparison_label: true
      listen:
        date_range: payments.payment_date
        billing_period: subscriptions.billing_period
      row: 0
      col: 12
      width: 6
      height: 4
      note_state: expanded
      note_display: below
      note_text: "Watch for compression post Jan 2026 as AI Starter ($13.99) surges"

    - title: "VAT collected"
      name: kpi_vat
      model: artlist_demo
      explore: users
      type: single_value
      fields: [payments.total_vat]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: payments.payment_date
      row: 0
      col: 18
      width: 6
      height: 4

    - title: "Monthly revenue: new vs renewal"
      name: monthly_revenue
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [payments.payment_month, payments.new_revenue, payments.renewal_revenue]
      sorts: [payments.payment_month asc]
      limit: 36
      listen:
        billing_period: subscriptions.billing_period
      row: 4
      col: 0
      width: 16
      height: 8

    - title: "Revenue by plan category"
      name: revenue_by_plan
      model: artlist_demo
      explore: users
      type: looker_pie
      fields: [dim_plans.plan_category, payments.total_revenue]
      sorts: [payments.total_revenue desc]
      limit: 10
      listen:
        date_range: payments.payment_date
      row: 4
      col: 16
      width: 8
      height: 8

    - title: "ARPU trend by plan category"
      name: arpu_trend
      model: artlist_demo
      explore: users
      type: looker_line
      fields: [subscriptions.started_month, subscriptions.avg_price_paid, dim_plans.plan_category]
      pivots: [dim_plans.plan_category]
      sorts: [subscriptions.started_month asc]
      limit: 36
      listen:
        billing_period: subscriptions.billing_period
      row: 12
      col: 0
      width: 14
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Insight 2: overall ARPU trend flattens/declines post AI relaunch as cheaper plans dominate mix"

    - title: "Revenue by region"
      name: revenue_by_region
      model: artlist_demo
      explore: users
      type: looker_bar
      fields: [dim_geo.region, payments.total_revenue, payments.new_revenue]
      sorts: [payments.total_revenue desc]
      limit: 10
      listen:
        date_range: payments.payment_date
        billing_period: subscriptions.billing_period
      row: 12
      col: 14
      width: 10
      height: 8

    - title: "Billing period mix over time"
      name: billing_mix
      model: artlist_demo
      explore: users
      type: looker_area
      fields: [subscriptions.started_month, subscriptions.count, subscriptions.billing_period]
      pivots: [subscriptions.billing_period]
      sorts: [subscriptions.started_month asc]
      limit: 36
      row: 20
      col: 0
      width: 12
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Monthly billing share rose from ~17% to ~20% post-relaunch — monthly subs churn 3x faster"

    - title: "Payment failures by reason"
      name: payment_failures
      model: artlist_demo
      explore: users
      type: looker_bar
      fields: [payments.failure_reason, payments.failed_payments]
      filters:
        payments.failure_reason: "-NULL"
      sorts: [payments.failed_payments desc]
      limit: 10
      listen:
        date_range: payments.payment_date
      row: 20
      col: 12
      width: 12
      height: 8
