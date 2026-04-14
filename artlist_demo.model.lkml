connection: "b2c_saas"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"

datagroup: daily_refresh {
  sql_trigger: SELECT MAX(registered_at) FROM users ;;
  max_cache_age: "24 hours"
}

# ── Raw table explores ────────────────────────────────────────────────────────

explore: users {
  label: "Users & Subscriptions"
  description: "Full user journey — acquisition, profile, subscription, payments, churn"
  persist_with: daily_refresh

  join: user_profiles {
    type: left_outer
    sql_on: ${users.user_id} = ${user_profiles.user_id} ;;
    relationship: one_to_one
  }

  join: dim_geo {
    type: left_outer
    sql_on: ${users.country_code} = ${dim_geo.country_code} ;;
    relationship: many_to_one
  }

  join: subscriptions {
    type: left_outer
    sql_on: ${users.user_id} = ${subscriptions.user_id} ;;
    relationship: one_to_many
  }

  join: dim_plans {
    type: left_outer
    sql_on: ${subscriptions.plan_id} = ${dim_plans.plan_id} ;;
    relationship: many_to_one
  }

  join: payments {
    type: left_outer
    sql_on: ${subscriptions.subscription_id} = ${payments.subscription_id} ;;
    relationship: one_to_many
  }

  join: churn_signals {
    type: left_outer
    sql_on: ${subscriptions.subscription_id} = ${churn_signals.subscription_id} ;;
    relationship: one_to_many
  }

  join: feature_interactions {
    type: left_outer
    sql_on: ${users.user_id} = ${feature_interactions.user_id} ;;
    relationship: one_to_many
  }
}

explore: funnel {
  label: "Conversion Funnel"
  description: "Visitor-to-paid funnel with channel, device, and experiment breakdown"
  from: funnel_checkpoints
  persist_with: daily_refresh

  join: dim_geo {
    type: left_outer
    sql_on: ${funnel.country_code} = ${dim_geo.country_code} ;;
    relationship: many_to_one
  }

  join: dim_campaigns {
    type: left_outer
    sql_on: ${funnel.acquisition_channel} = ${dim_campaigns.campaign_id} ;;
    relationship: many_to_one
  }
}

explore: web_events {
  label: "Web Events & Tracking"
  description: "Raw event log — use to detect volume anomalies and tracking gaps"
  persist_with: daily_refresh
}

explore: experiments {
  label: "A/B Experiments"
  description: "Experiment assignments and conversion outcomes"
  persist_with: daily_refresh

  join: users {
    type: left_outer
    sql_on: ${experiments.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: dim_geo {
    type: left_outer
    sql_on: ${users.country_code} = ${dim_geo.country_code} ;;
    relationship: many_to_one
  }
}

# ── Postgres view explores ────────────────────────────────────────────────────

explore: v_users_enriched {
  label: "Users enriched (view)"
  description: "Flat user record with geo and profile — no joins needed"
  persist_with: daily_refresh
}

explore: v_subscriptions_enriched {
  label: "Subscriptions enriched (view)"
  description: "Subscription + plan + user + geo in one row — Insights 2 & 9"
  persist_with: daily_refresh
}

explore: v_payments_enriched {
  label: "Payments enriched (view)"
  description: "Revenue with VAT, geo, and plan context — Insight 7"
  persist_with: daily_refresh
}

explore: v_funnel_by_channel {
  label: "Funnel by channel (view)"
  description: "Pre-aggregated funnel drop-off by channel, device, and week — Insights 1 & 3"
  persist_with: daily_refresh
}

explore: v_event_volume_daily {
  label: "Event volume daily (view)"
  description: "Daily event counts by name and device — mobile tracking break detection (Insight 3)"
  persist_with: daily_refresh
}

explore: v_feature_adoption_churn {
  label: "Feature adoption & churn (view)"
  description: "AI Collections early adoption vs churn outcome — Insights 4 & 9"
  persist_with: daily_refresh
}

explore: v_monthly_cohorts {
  label: "Monthly cohorts (view)"
  description: "Registration cohorts with CVR, revenue, and seasonality — Insights 1, 5, 10"
  persist_with: daily_refresh
}

explore: v_churn_signals_enriched {
  label: "Churn signals enriched (view)"
  description: "Churn signals with full plan, geo, and profile context — Insights 8 & 9"
  persist_with: daily_refresh
}

explore: v_arpu_by_month {
  label: "ARPU by month (view)"
  description: "Plan mix, ARPU, and MRR trends over time — Insight 2"
  persist_with: daily_refresh
}

explore: v_experiment_results {
  label: "Experiment results (view)"
  description: "Pre-aggregated A/B test CVR by variant and region"
  persist_with: daily_refresh
}
