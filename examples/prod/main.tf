terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_url = var.datadog_api_url
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

module "datadog_usage_reporting_dashboard" {
	source = "../../assets/datadog_usage_reporting_dashboard"
	# source = "git::https://github.com/nxnarbais/datadog-share.git//assets/datadog_usage_reporting_dashboard?ref=0.11"

	teams = ["team:dataiker"]
	title_suffix = " - Managed by Terraform"
	managed_by_terraform = "managed_by:terraform"

	usage_breakdown_tag_1 = "cost_center"
	usage_breakdown_tag_2 = "department"
	usage_breakdown_tag_3 = "team"
}

output "datadog_usage_reporting_dashboard_id" {
  value = module.datadog_usage_reporting_dashboard.dashboard_id
}

module "kubernetes_capacity_planning_dashboard" {
	source = "../../assets/kubernetes_capacity_planning_dashboard"
	# source = "git::https://github.com/nxnarbais/datadog-share.git//assets/kubernetes_capacity_planning_dashboard?ref=0.11"

	teams = ["team:dataiker"]
	title_suffix = " - Managed by Terraform"
	managed_by_terraform = "managed_by:terraform"

	cost_per_cpu_core_per_month = 10
}

output "kubernetes_capacity_planning_dashboard_id" {
  value = module.kubernetes_capacity_planning_dashboard.dashboard_id
}

module "vercel_dashboard" {
	source = "../../assets/vercel_dashboard"
	# source = "git::https://github.com/nxnarbais/datadog-share.git//assets/kubernetes_capacity_planning_dashboard?ref=0.11"

	teams = ["team:dataiker"]
	title_suffix = " - Managed by Terraform"
	managed_by_terraform = "managed_by:terraform"

	latency_p90_threshold = 500
	latency_p95_threshold = 700
}

output "vercel_dashboard_id" {
  value = module.vercel_dashboard.dashboard_id
}

module "vercel_pipeline" {
	source = "../../assets/vercel_pipeline"

	tags = ["team:dataiker", "managed_by:terraform"]
	name_suffix = " - Managed by Terraform"
	
	vlookup_project_name_to_team = ["dataiker-app,dataiker"]
	vlookup_is_admin = ["your_home_ip,true","your_work_ip,true"]
}

resource "datadog_dashboard_list" "datadog_share" {
  name = "datadog-share-by-dataiker"

  dash_item {
    type = "custom_timeboard"
    dash_id = module.datadog_usage_reporting_dashboard.dashboard_id
  }

	dash_item {
		type = "custom_timeboard"
		dash_id = module.kubernetes_capacity_planning_dashboard.dashboard_id
	}

	dash_item {
		type = "custom_timeboard"
		dash_id = module.vercel_dashboard.dashboard_id
	}

	depends_on = [
		module.datadog_usage_reporting_dashboard,
		module.kubernetes_capacity_planning_dashboard,
		module.vercel_dashboard,
	]
}

output "datadog_share_id" {
  value = datadog_dashboard_list.datadog_share.id
}
