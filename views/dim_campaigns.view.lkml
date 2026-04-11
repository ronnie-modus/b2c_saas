view: dim_campaigns {
  sql_table_name: public.dim_campaigns ;;

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
    label: "Campaign name"
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
    label: "Campaign type"
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
    label: "Channel"
  }

  dimension: target_geo {
    type: string
    sql: ${TABLE}.target_geo ;;
    label: "Target geo"
  }
}
