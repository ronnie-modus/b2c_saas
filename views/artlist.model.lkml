connection: "artlist_postgres"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"

datagroup: daily_refresh {
  sql_trigger: SELECT MAX(registered_at) FROM users ;;
  max_cache_age: "24 hours"
}

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
