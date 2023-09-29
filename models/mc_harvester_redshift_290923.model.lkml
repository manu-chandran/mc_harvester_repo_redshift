connection: "mc_looker_redshift"

# include all the views
# include: "/views/**/*.view.lkml"

include: "/views/dept.view.lkml"
include: "/views/empsal.view.lkml"
include: "/views/expence.view.lkml"
include: "/mc_havester_redshift_290923.dashboard.lookml"

datagroup: mc_harvester_redshift_290923_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mc_harvester_redshift_290923_default_datagroup

explore: dept {
  join: empsal {
    type: left_outer
    relationship: many_to_one
    sql_on: ${empsal.id} = ${dept.empid} ;;
  }

  join: expence {
    type: left_outer
    relationship: many_to_one
    sql_on: ${expence.expid} = ${dept.empid} ;;
  }
}
