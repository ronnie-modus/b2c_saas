- dashboard: product_events_experiments
  title: "Product Events & Experiments"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Event tracking health, mobile tracking break, A/B experiment results"

  filters:
    - name: date_range
      title: "Event date"
      type: field_filter
      explore: web_events
      field: web_events.event_date
      default_value: "180 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: experiment_name
      title: "Experiment"
      type: field_filter
      explore: experiments
      field: experiments.experiment_name
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    - title: "Daily event volume by device"
      name: event_volume_device
      model: artlist_demo
      explore: web_events
      type: looker_line
      fields: [web_events.event_date, web_events.event_count, web_events.device_type]
      pivots: [web_events.device_type]
      sorts: [web_events.event_date asc]
      limit: 180
      listen:
        date_range: web_events.event_date
      row: 0
      col: 0
      width: 16
      height: 8

    - title: "Events by name"
      name: events_by_name
      model: artlist_demo
      explore: web_events
      type: looker_bar
      fields: [web_events.event_name, web_events.event_count, web_events.unique_visitors]
      sorts: [web_events.event_count desc]
      limit: 15
      listen:
        date_range: web_events.event_date
      row: 0
      col: 16
      width: 8
      height: 8

    - title: "Mobile vs desktop: pricing_card_viewed — tracking break detector"
      name: mobile_tracking_break
      model: artlist_demo
      explore: web_events
      type: looker_line
      fields: [web_events.event_date, web_events.mobile_pricing_events, web_events.desktop_pricing_events]
      filters:
        web_events.event_name: "pricing_card_viewed"
      sorts: [web_events.event_date asc]
      limit: 180
      row: 8
      col: 0
      width: 24
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Insight 3: Mobile pricing_card_viewed drops 55% after Feb 3 2026 — instrumentation bug. Desktop shows no corresponding drop. This masked Super Bowl funnel data."

    - title: "Experiment assignments by variant"
      name: exp_assignments
      model: artlist_demo
      explore: experiments
      type: looker_column
      fields: [experiments.experiment_name, experiments.assignments, experiments.variant_name]
      pivots: [experiments.variant_name]
      sorts: [experiments.assignments desc]
      limit: 10
      listen:
        experiment_name: experiments.experiment_name
      row: 16
      col: 0
      width: 12
      height: 7

    - title: "Experiment CVR: control vs variant"
      name: exp_cvr
      model: artlist_demo
      explore: experiments
      type: looker_column
      fields: [experiments.experiment_name, experiments.cvr, experiments.variant_name]
      pivots: [experiments.variant_name]
      sorts: [experiments.experiment_name asc]
      limit: 10
      listen:
        experiment_name: experiments.experiment_name
      row: 16
      col: 12
      width: 12
      height: 7
      note_state: expanded
      note_display: below
      note_text: "onboarding-collections-prompt variant shows strongest lift — supports AI Collections adoption strategy"

    - title: "Experiment conversions over time"
      name: exp_conversions_time
      model: artlist_demo
      explore: experiments
      type: looker_line
      fields: [experiments.assigned_week, experiments.conversions, experiments.variant_name]
      pivots: [experiments.variant_name]
      sorts: [experiments.assigned_week asc]
      limit: 52
      listen:
        experiment_name: experiments.experiment_name
        date_range: experiments.assigned_date
      row: 23
      col: 0
      width: 16
      height: 8

    - title: "Experiment CVR by region"
      name: exp_cvr_region
      model: artlist_demo
      explore: experiments
      type: looker_bar
      fields: [dim_geo.region, experiments.cvr, experiments.variant_name]
      pivots: [experiments.variant_name]
      sorts: [experiments.cvr desc]
      limit: 10
      listen:
        experiment_name: experiments.experiment_name
        date_range: experiments.assigned_date
      row: 23
      col: 16
      width: 8
      height: 8
