- dashboard: conversion_funnel
  title: "Conversion Funnel"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Visitor-to-paid funnel by channel, device, and campaign"

  filters:
    - name: date_range
      title: "Date range"
      type: field_filter
      explore: funnel
      field: funnel.step_date
      default_value: "90 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: device_type
      title: "Device"
      type: field_filter
      explore: funnel
      field: funnel.device_type
      ui_config:
        type: button_toggles
        display: inline

    - name: acquisition_channel
      title: "Channel"
      type: field_filter
      explore: funnel
      field: funnel.acquisition_channel
      ui_config:
        type: checkboxes
        display: popover

  elements:
    - title: "Funnel drop-off by step"
      name: funnel_steps
      model: artlist_demo
      explore: funnel
      type: looker_funnel
      fields: [funnel.funnel_step, funnel.visitors]
      sorts: [funnel.funnel_step_order asc]
      limit: 10
      listen:
        date_range: funnel.step_date
        device_type: funnel.device_type
        acquisition_channel: funnel.acquisition_channel
      row: 0
      col: 0
      width: 12
      height: 10

    - title: "Visitors by funnel step & channel"
      name: funnel_by_channel
      model: artlist_demo
      explore: funnel
      type: looker_bar
      fields: [funnel.funnel_step, funnel.visitors, funnel.acquisition_channel]
      pivots: [funnel.acquisition_channel]
      sorts: [funnel.funnel_step_order asc]
      limit: 10
      listen:
        date_range: funnel.step_date
        device_type: funnel.device_type
      row: 0
      col: 12
      width: 12
      height: 10

    - title: "Weekly funnel entries by channel"
      name: weekly_funnel
      model: artlist_demo
      explore: funnel
      type: looker_line
      fields: [funnel.step_week, funnel.visitors, funnel.acquisition_channel]
      pivots: [funnel.acquisition_channel]
      filters:
        funnel.funnel_step: "landing"
      sorts: [funnel.step_week asc]
      limit: 52
      listen:
        device_type: funnel.device_type
      row: 10
      col: 0
      width: 16
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Super Bowl spike visible week of Feb 8 2026. Instagram campaign surge Mar 15-31."

    - title: "Channel conversion comparison"
      name: channel_cvr
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [users.acquisition_channel, users.count, subscriptions.active_subscriptions, subscriptions.conversion_rate]
      sorts: [users.count desc]
      limit: 10
      listen:
        date_range: users.registered_date
      row: 10
      col: 16
      width: 8
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Instagram spring campaign: high volume, low CVR (Insight 1)"

    - title: "Funnel by device type"
      name: funnel_device
      model: artlist_demo
      explore: funnel
      type: looker_column
      fields: [funnel.funnel_step, funnel.visitors, funnel.device_type]
      pivots: [funnel.device_type]
      sorts: [funnel.funnel_step_order asc]
      limit: 10
      listen:
        date_range: funnel.step_date
        acquisition_channel: funnel.acquisition_channel
      row: 18
      col: 0
      width: 14
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Mobile pricing_card_viewed drops 55%+ after Feb 3 2026 — tracking bug, not real drop"

    - title: "Plan explored at CTA"
      name: plan_explored
      model: artlist_demo
      explore: funnel
      type: looker_pie
      fields: [funnel.plan_considered, funnel.visitors]
      filters:
        funnel.funnel_step: "plan_explored"
      sorts: [funnel.visitors desc]
      limit: 10
      listen:
        date_range: funnel.step_date
        device_type: funnel.device_type
        acquisition_channel: funnel.acquisition_channel
      row: 18
      col: 14
      width: 10
      height: 8
