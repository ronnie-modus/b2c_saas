- dashboard: executive_overview
  title: "Executive Overview"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Top-level KPIs: registrations, conversions, revenue, churn"

  filters:
    - name: date_range
      title: "Date range"
      type: field_filter
      explore: users
      field: users.registered_date
      default_value: "365 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: region
      title: "Region"
      type: field_filter
      explore: users
      field: dim_geo.region
      ui_config:
        type: checkboxes
        display: popover

  elements:
    - title: "Total registrations"
      name: kpi_registrations
      model: artlist_demo
      explore: users
      type: single_value
      fields: [users.count]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 0
      width: 4
      height: 4

    - title: "Paid conversions"
      name: kpi_conversions
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.active_subscriptions]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 4
      width: 4
      height: 4

    - title: "Convert to pay rate"
      name: kpi_cvr
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.conversion_rate]
      comparison_type: change
      comparison_reverse_colors: false
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 8
      width: 4
      height: 4

    - title: "Total revenue (USD)"
      name: kpi_revenue
      model: artlist_demo
      explore: users
      type: single_value
      fields: [payments.total_revenue]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 12
      width: 4
      height: 4

    - title: "Churn rate"
      name: kpi_churn
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.churn_rate]
      comparison_type: change
      comparison_reverse_colors: true
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 16
      width: 4
      height: 4

    - title: "Avg plan price"
      name: kpi_arpu
      model: artlist_demo
      explore: users
      type: single_value
      fields: [subscriptions.avg_price_paid]
      comparison_type: change
      show_comparison_label: true
      listen:
        date_range: users.registered_date
        region: dim_geo.region
      row: 0
      col: 20
      width: 4
      height: 4

    - title: "Monthly registrations & conversions"
      name: monthly_registrations
      model: artlist_demo
      explore: users
      type: looker_line
      fields: [users.registered_month, users.count, subscriptions.active_subscriptions]
      sorts: [users.registered_month asc]
      limit: 36
      listen:
        region: dim_geo.region
      row: 4
      col: 0
      width: 14
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Seasonality visible: Jan spike, summer dip, Oct/Nov brand season, Super Bowl Feb 2026"

    - title: "Registrations by region"
      name: registrations_by_region
      model: artlist_demo
      explore: users
      type: looker_pie
      fields: [dim_geo.region, users.count]
      sorts: [users.count desc]
      limit: 10
      listen:
        date_range: users.registered_date
      row: 4
      col: 14
      width: 10
      height: 8

    - title: "Revenue by country"
      name: revenue_by_country
      model: artlist_demo
      explore: users
      type: looker_map
      fields: [dim_geo.country_code, payments.total_revenue]
      sorts: [payments.total_revenue desc]
      limit: 100
      listen:
        date_range: users.registered_date
      row: 12
      col: 0
      width: 24
      height: 10

    - title: "Plan category mix over time"
      name: plan_mix
      model: artlist_demo
      explore: users
      type: looker_area
      fields: [subscriptions.started_month, subscriptions.count, dim_plans.plan_category]
      pivots: [dim_plans.plan_category]
      sorts: [subscriptions.started_month asc]
      limit: 36
      listen:
        date_range: subscriptions.started_date
        region: dim_geo.region
      row: 22
      col: 0
      width: 24
      height: 8
      note_state: expanded
      note_display: below
      note_text: "AI Starter plan surge visible from Jan 2026 — watch for ARPU compression"
