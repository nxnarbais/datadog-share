locals {
  filter_string = format(
    "$%s,$%s,$%s",
    var.usage_breakdown_tag_1,
    var.usage_breakdown_tag_2,
    var.usage_breakdown_tag_3,
  )
	group_by_string = format(
    "%s,%s,%s",
    var.usage_breakdown_tag_1,
    var.usage_breakdown_tag_2,
    var.usage_breakdown_tag_3
  )
}

resource "datadog_dashboard_json" "datadog_usage_reporting" {
  dashboard = templatefile("${path.module}/dashboard.tpl", {
    tag1 = var.usage_breakdown_tag_1
    tag2 = var.usage_breakdown_tag_2
    tag3 = var.usage_breakdown_tag_3
		filter_string = local.filter_string
		group_by_string = local.group_by_string
  })
}