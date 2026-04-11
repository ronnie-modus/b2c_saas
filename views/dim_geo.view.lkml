view: dim_geo {
  sql_table_name: public.dim_geo ;;

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
    primary_key: yes
    map_layer_name: countries
    label: "Country code"
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
  }

  dimension: sub_region {
    type: string
    sql: ${TABLE}.sub_region ;;
    label: "Sub-region"
  }

  dimension: creator_economy_tier {
    type: string
    sql: ${TABLE}.creator_economy_tier ;;
    label: "Creator economy tier"
  }

  dimension: is_vat_eligible {
    type: yesno
    sql: ${TABLE}.is_vat_eligible ;;
    label: "VAT eligible"
  }

  dimension: default_currency {
    type: string
    sql: ${TABLE}.default_currency ;;
    label: "Currency"
  }
}
