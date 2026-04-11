- dashboard: acquisition_campaigns
  title: "Acquisition & Campaigns"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Channel quality, Super Bowl cohort, seasonality, geo acquisition"

  filters:
    - name: date_range
      title: "Registration date"
      type: field_filter
      explore: users
      field: users.registered_date
      default_value: "365 days"
      ui_config:
        type: relative_timeframes
        display: inline

    - name: creator_type
      title: "Creator type"
      type: field_filter
      explore: users
      field: user_profiles.creator_type
      ui_config:
        type: checkboxes
        display: popover

  elements:
    - title: "Registrations by channel"
      name: regs_by_channel
      model: artlist_demo
      explore: users
      type: looker_bar
      fields: [users.acquisition_channel, users.count, subscriptions.active_subscriptions, subscriptions.conversion_rate]
      sorts: [users.count desc]
      limit: 12
      listen:
        date_range: users.registered_date
        creator_type: user_profiles.creator_type
      row: 0
      col: 0
      width: 14
      height: 9
      note_state: expanded
      note_display: below
      note_text: "Instagram spring 2026: highest volume, lowest CVR. YouTube creator partnership: moderate volume, highest CVR."

    - title: "Creator type mix by channel"
      name: creator_by_channel
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [users.acquisition_channel, users.count, user_profiles.creator_type]
      pivots: [user_profiles.creator_type]
      sorts: [users.count desc]
      limit: 8
      listen:
        date_range: users.registered_date
      row: 0
      col: 14
      width: 10
      height: 9
      note_state: expanded
      note_display: below
      note_text: "Super Bowl drove higher in_house_brand + production_company share"

    - title: "Weekly registrations — seasonality"
      name: seasonality
      model: artlist_demo
      explore: users
      type: looker_line
      fields: [users.registered_week, users.count]
      sorts: [users.registered_week asc]
      limit: 130
      listen:
        creator_type: user_profiles.creator_type
      row: 9
      col: 0
      width: 24
      height: 8
      note_state: expanded
      note_display: below
      note_text: "Jan spike → summer dip → Oct/Nov brand season → Super Bowl Feb 8 2026 → Instagram campaign Mar 15-31"

    - title: "Super Bowl cohort vs baseline"
      name: superbowl_cohort
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [users.is_superbowl_cohort, users.count, subscriptions.conversion_rate, subscriptions.churn_rate]
      listen:
        creator_type: user_profiles.creator_type
      row: 17
      col: 0
      width: 10
      height: 8
      note_state: expanded
      note_display: below
      note_text: "SB cohort: 2x daily registrations, lower CVR overall, but higher Max Pro selection among converters"

    - title: "Primary need by acquisition channel"
      name: need_by_channel
      model: artlist_demo
      explore: users
      type: looker_column
      fields: [users.acquisition_channel, users.count, user_profiles.primary_need]
      pivots: [user_profiles.primary_need]
      sorts: [users.count desc]
      limit: 8
      listen:
        date_range: users.registered_date
      row: 17
      col: 10
      width: 14
      height: 8

    - title: "Registrations by country"
      name: regs_by_country
      model: artlist_demo
      explore: users
      type: looker_map
      fields: [dim_geo.country_code, users.count]
      sorts: [users.count desc]
      limit: 100
      listen:
        date_range: users.registered_date
        creator_type: user_profiles.creator_type
      row: 25
      col: 0
      width: 14
      height: 10

    - title: "Monthly registrations by region"
      name: regional_growth
      model: artlist_demo
      explore: users
      type: looker_line
      fields: [users.registered_month, users.count, dim_geo.region]
      pivots: [dim_geo.region]
      sorts: [users.registered_month asc]
      limit: 36
      listen:
        creator_type: user_profiles.creator_type
      row: 25
      col: 14
      width: 10
      height: 10
      note_state: expanded
      note_display: below
      note_text: "Insight 7: EU growing fastest post-AI relaunch. Insight 6: Israel spikes in April (Passover)."
