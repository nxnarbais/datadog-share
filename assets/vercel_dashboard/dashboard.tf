resource "datadog_dashboard_json" "vercel_dashboard" {
  dashboard = <<EOF
{
	"title": "[Dataiker][Vercel] Advanced Dash.${var.title_suffix}",
	"description": "Use this dashboard to dive deeper in the data provided from Vercel about your app.\n\n[[suggested_dashboards]]\n\n${var.managed_by_terraform}",
	"widgets": [
			{
					"id": 3429595338095840,
					"definition": {
							"type": "note",
							"content": "# Vercel\n\nAdvanced dashboard to leverage all data from an app deployed with Vercel. \n\nCheck [this blog](https://blog.dataiker.com/level-up-your-vercel-monitoring-advanced-datadog-integration-techniques/) for more details on this dashboard.",
							"background_color": "gray",
							"font_size": "14",
							"text_align": "left",
							"vertical_align": "top",
							"show_tick": false,
							"tick_pos": "50%",
							"tick_edge": "left",
							"has_padding": true
					},
					"layout": {
							"x": 0,
							"y": 0,
							"width": 4,
							"height": 2
					}
			},
			{
					"id": 4222289635635510,
					"definition": {
							"type": "note",
							"content": "### Shorcuts\n\n* [Service Page](/apm/entity/service%3A$service.value?env=$env.value)\n* [Log Explorer](/logs?query=source%3Avercel%20$service%20$env)",
							"background_color": "gray",
							"font_size": "14",
							"text_align": "left",
							"vertical_align": "top",
							"show_tick": false,
							"tick_pos": "50%",
							"tick_edge": "left",
							"has_padding": true
					},
					"layout": {
							"x": 4,
							"y": 0,
							"width": 2,
							"height": 2
					}
			},
			{
					"id": 629528867458554,
					"definition": {
							"title": "Menu - env",
							"title_size": "16",
							"title_align": "left",
							"type": "query_table",
							"requests": [
									{
											"queries": [
													{
															"name": "query1",
															"data_source": "logs",
															"search": {
																	"query": "source:vercel"
															},
															"indexes": [
																	"*"
															],
															"group_by": [
																	{
																			"facet": "env",
																			"limit": 10,
																			"sort": {
																					"aggregation": "count",
																					"order": "desc",
																					"metric": "count"
																			},
																			"should_exclude_missing": true
																	},
																	{
																			"facet": "environment",
																			"limit": 10,
																			"sort": {
																					"aggregation": "count",
																					"order": "desc",
																					"metric": "count"
																			},
																			"should_exclude_missing": true
																	}
															],
															"compute": {
																	"aggregation": "count"
															},
															"storage": "hot"
													}
											],
											"response_format": "scalar",
											"sort": {
													"count": 100,
													"order_by": [
															{
																	"type": "formula",
																	"index": 0,
																	"order": "desc"
															}
													]
											},
											"formulas": [
													{
															"cell_display_mode": "number",
															"alias": "#",
															"formula": "query1"
													}
											]
									}
							],
							"has_search_bar": "auto"
					},
					"layout": {
							"x": 6,
							"y": 0,
							"width": 3,
							"height": 2
					}
			},
			{
					"id": 4900426386950693,
					"definition": {
							"title": "Menu - service",
							"title_size": "16",
							"title_align": "left",
							"type": "query_table",
							"requests": [
									{
											"queries": [
													{
															"name": "query1",
															"data_source": "logs",
															"search": {
																	"query": "source:vercel $service $env"
															},
															"indexes": [
																	"*"
															],
															"group_by": [
																	{
																			"facet": "service",
																			"limit": 10,
																			"sort": {
																					"aggregation": "count",
																					"order": "desc",
																					"metric": "count"
																			},
																			"should_exclude_missing": true
																	},
																	{
																			"facet": "project_name",
																			"limit": 10,
																			"sort": {
																					"aggregation": "count",
																					"order": "desc",
																					"metric": "count"
																			},
																			"should_exclude_missing": true
																	}
															],
															"compute": {
																	"aggregation": "count"
															},
															"storage": "hot"
													}
											],
											"response_format": "scalar",
											"sort": {
													"count": 100,
													"order_by": [
															{
																	"type": "formula",
																	"index": 0,
																	"order": "desc"
															}
													]
											},
											"formulas": [
													{
															"cell_display_mode": "number",
															"formula": "query1"
													}
											]
									}
							],
							"has_search_bar": "auto"
					},
					"layout": {
							"x": 9,
							"y": 0,
							"width": 3,
							"height": 2
					}
			},
			{
					"id": 1884567339389049,
					"definition": {
							"title": "RED Metrics from APM",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 533953704804834,
											"definition": {
													"title": "RED Metrics",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:trace.web.request.hits{$env, $service} by {env,service,resource_name}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:trace.web.request.errors{$env, $service} by {env,service,resource_name}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query3",
																					"query": "p90:trace.web.request{$env, $service} by {env,service,resource_name}",
																					"aggregator": "percentile"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query4",
																					"query": "p95:trace.web.request{$env, $service} by {env,service,resource_name}",
																					"aggregator": "percentile"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 500,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "hits",
																					"formula": "query1"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "errors",
																					"formula": "query2"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "p90",
																					"formula": "query3"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "p95",
																					"formula": "query4"
																			},
																			{
																					"alias": "error rate %",
																					"formula": "query2 / query1 * 100"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 8,
													"height": 4
											}
									},
									{
											"id": 3706867694242843,
											"definition": {
													"title": "Hits",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"number_format": {
																							"unit": {
																									"label": "req",
																									"type": "custom_unit_label"
																							}
																					},
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:trace.web.request.hits{*}.as_count()",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 8414125123540558,
											"definition": {
													"title": "Error Rate",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1 / query2 * 100",
																					"number_format": {
																							"unit": {
																									"type": "canonical_unit",
																									"unit_name": "percent"
																							}
																					}
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:trace.web.request.errors{*}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:trace.web.request.hits{*}.as_count()",
																					"aggregator": "sum"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"value": 0,
																					"palette": "white_on_red"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"type": "area",
															"yaxis": {
																	"include_zero": true
															}
													}
											},
											"layout": {
													"x": 10,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 3325028808584117,
											"definition": {
													"title": "Latency p90",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "p90:trace.web.request{*}",
																					"aggregator": "percentile"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"value": ${var.latency_p90_threshold / 1000},
																					"palette": "white_on_yellow"
																			},
																			{
																					"comparator": "<=",
																					"value": ${var.latency_p90_threshold / 1000},
																					"palette": "green_on_white"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "area"
													}
											},
											"layout": {
													"x": 8,
													"y": 2,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4235672985745799,
											"definition": {
													"title": "Latency p95",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "p95:trace.web.request{*}",
																					"aggregator": "percentile"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"value": ${var.latency_p95_threshold / 1000},
																					"palette": "white_on_yellow"
																			},
																			{
																					"comparator": "<=",
																					"value": ${var.latency_p95_threshold / 1000},
																					"palette": "green_on_white"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "area"
													}
											},
											"layout": {
													"x": 10,
													"y": 2,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 183880093195641,
											"definition": {
													"title": "APM Spans",
													"title_size": "16",
													"title_align": "left",
													"requests": [
															{
																	"response_format": "event_list",
																	"query": {
																			"data_source": "trace_stream",
																			"query_string": "@_top_level:1 $env $service",
																			"indexes": []
																	},
																	"columns": [
																			{
																					"field": "timestamp",
																					"width": "auto"
																			},
																			{
																					"field": "service",
																					"width": "auto"
																			},
																			{
																					"field": "resource_name",
																					"width": "auto"
																			},
																			{
																					"field": "@duration",
																					"width": "auto"
																			},
																			{
																					"field": "@http.method",
																					"width": "auto"
																			},
																			{
																					"field": "@http.status_code",
																					"width": "auto"
																			}
																	]
															}
													],
													"type": "list_stream"
											},
											"layout": {
													"x": 0,
													"y": 4,
													"width": 6,
													"height": 3
											}
									},
									{
											"id": 8705633787732603,
											"definition": {
													"title": "APM Spans - Errors or High Latency",
													"title_size": "16",
													"title_align": "left",
													"requests": [
															{
																	"response_format": "event_list",
																	"query": {
																			"data_source": "trace_stream",
																			"query_string": "@_top_level:1 $env $service (status:error OR @duration:>=${var.latency_p95_threshold}ms)",
																			"indexes": []
																	},
																	"columns": [
																			{
																					"field": "timestamp",
																					"width": "auto"
																			},
																			{
																					"field": "status",
																					"width": "auto"
																			},
																			{
																					"field": "service",
																					"width": "auto"
																			},
																			{
																					"field": "resource_name",
																					"width": "auto"
																			},
																			{
																					"field": "@duration",
																					"width": "auto"
																			},
																			{
																					"field": "@http.method",
																					"width": "auto"
																			},
																			{
																					"field": "@http.status_code",
																					"width": "auto"
																			}
																	]
															}
													],
													"type": "list_stream"
											},
											"layout": {
													"x": 6,
													"y": 4,
													"width": 6,
													"height": 3
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 2,
							"width": 12,
							"height": 8
					}
			},
			{
					"id": 7393034645831897,
					"definition": {
							"title": "RED Metrics from Logs (and derived metrics)",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 7494277218277661,
											"definition": {
													"title": "Total Request Count - from logs",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1",
																					"number_format": {
																							"unit": {
																									"label": "req",
																									"type": "custom_unit_label"
																							}
																					}
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"search": {
																							"query": "source:vercel START* $service $env"
																					},
																					"data_source": "logs",
																					"compute": {
																							"aggregation": "count"
																					},
																					"name": "query1",
																					"indexes": [
																							"*"
																					],
																					"group_by": []
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"type": "bars",
															"yaxis": {}
													}
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 3,
													"height": 2
											}
									},
									{
											"id": 5427991397401298,
											"definition": {
													"title": "Total Request Count (no Synthetics) - from logs",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"number_format": {
																							"unit": {
																									"label": "req",
																									"type": "custom_unit_label"
																							}
																					},
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"name": "query1",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel START* $service -@proxy.path_utm_source:synthetics $env"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [],
																					"compute": {
																							"aggregation": "count"
																					},
																					"storage": "hot"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"type": "bars",
															"yaxis": {}
													}
											},
											"layout": {
													"x": 3,
													"y": 0,
													"width": 3,
													"height": 2
											}
									},
									{
											"id": 3705206015330791,
											"definition": {
													"title": "Total Errors - from logs",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "default_zero(query1)",
																					"number_format": {
																							"unit": {
																									"label": "err",
																									"type": "custom_unit_label"
																							}
																					}
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"palette": "white_on_red",
																					"value": 0
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"search": {
																							"query": "source:vercel status:error $service $env"
																					},
																					"data_source": "logs",
																					"compute": {
																							"aggregation": "count"
																					},
																					"name": "query1",
																					"indexes": [
																							"*"
																					],
																					"group_by": []
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"type": "bars",
															"yaxis": {}
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 3,
													"height": 2
											}
									},
									{
											"id": 5992867183700447,
											"definition": {
													"title": "Error Rate (no Synthetics) - from logs",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "default_zero(query1) / default_zero(query2) * 100",
																					"number_format": {
																							"unit": {
																									"type": "canonical_unit",
																									"unit_name": "percent"
																							}
																					}
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"palette": "white_on_red",
																					"value": 0
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"search": {
																							"query": "source:vercel status:error $service $env"
																					},
																					"data_source": "logs",
																					"compute": {
																							"aggregation": "count"
																					},
																					"name": "query1",
																					"indexes": [
																							"*"
																					],
																					"group_by": []
																			},
																			{
																					"name": "query2",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel START* $service -@proxy.path_utm_source:synthetics $env"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [],
																					"compute": {
																							"aggregation": "count"
																					},
																					"storage": "hot"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"type": "bars",
															"yaxis": {}
													}
											},
											"layout": {
													"x": 9,
													"y": 0,
													"width": 3,
													"height": 2
											}
									},
									{
											"id": 7371796139910294,
											"definition": {
													"title": "Requests & Duration",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:vercel.requests{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query5",
																					"query": "sum:vercel.functions.invocations{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query4",
																					"query": "sum:vercel.requests.by_utm_source{!proxy.path_utm_source:synthetics,$environment,projectname:$project_name.value} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:vercel.requests{!status_code:200,$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query3",
																					"query": "sum:vercel.functions.duration{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query6",
																					"query": "p90:vercel.functions.duration{$environment,$project_name} by {path}",
																					"aggregator": "percentile"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query7",
																					"query": "p95:vercel.functions.duration{$environment,$project_name} by {path}",
																					"aggregator": "percentile"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query8",
																					"query": "sum:vercel.functions.execution{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query9",
																					"query": "p90:vercel.functions.execution{$environment,$project_name} by {path}",
																					"aggregator": "percentile"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query10",
																					"query": "p95:vercel.functions.execution{$environment,$project_name} by {path}",
																					"aggregator": "percentile"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 500,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "requests",
																					"formula": "query1"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "Invocations",
																					"formula": "query5"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "requests (no synth.)",
																					"formula": "query4"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "not 200",
																					"formula": "query2"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "duration (tot)",
																					"formula": "query3"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "duration p90",
																					"formula": "query6"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "duration p95",
																					"formula": "query7"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "exec (tot)",
																					"formula": "query8"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "exec p90",
																					"formula": "query9"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "exec p95",
																					"formula": "query10"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 8,
													"height": 4
											}
									},
									{
											"id": 616380971134418,
											"definition": {
													"title": "Requests",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"number_format": {
																							"unit": {
																									"label": "req",
																									"type": "custom_unit_label"
																							}
																					},
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:vercel.requests{$environment,$project_name}.as_count()",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 2,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 3344098583099025,
											"definition": {
													"title": "Errors",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"number_format": {
																							"unit": {
																									"type": "canonical_unit",
																									"unit_name": "percent"
																							}
																					},
																					"formula": "query1 / query2 * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"palette": "white_on_red",
																					"value": 0
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:vercel.functions.errors{$environment,$project_name}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:vercel.requests{$environment,$project_name}.as_count()",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 2,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 2124696804049148,
											"definition": {
													"title": "Latency p90",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "p90:vercel.functions.duration{$environment, $project_name}",
																					"aggregator": "percentile"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"value": ${var.latency_p90_threshold * 1000000},
																					"palette": "white_on_yellow"
																			},
																			{
																					"comparator": "<=",
																					"value": ${var.latency_p90_threshold * 1000000},
																					"palette": "green_on_white"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "area"
													}
											},
											"layout": {
													"x": 8,
													"y": 4,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 5963801882236876,
											"definition": {
													"title": "Latency p95",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "p95:vercel.functions.duration{$environment, $project_name}",
																					"aggregator": "percentile"
																			}
																	],
																	"conditional_formats": [
																			{
																					"comparator": ">",
																					"value": ${var.latency_p95_threshold * 1000000},
																					"palette": "white_on_yellow"
																			},
																			{
																					"comparator": "<=",
																					"value": ${var.latency_p95_threshold * 1000000},
																					"palette": "green_on_white"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 1,
													"timeseries_background": {
															"yaxis": {},
															"type": "area"
													}
											},
											"layout": {
													"x": 10,
													"y": 4,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 8336159122334634,
											"definition": {
													"title": "Requests /status_code",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "a",
																					"query": "sum:vercel.requests{$environment,$project_name} by {status_code}.as_count()"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "a"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 4,
													"height": 3
											}
									},
									{
											"id": 243611967172482,
											"definition": {
													"title": "Requests /path (no Synthetics)",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "a",
																					"query": "sum:vercel.requests.by_utm_source{!proxy.path_utm_source:synthetics,$environment,projectname:$project_name.value} by {path}.as_count()"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "a"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 4,
													"y": 6,
													"width": 4,
													"height": 3
											}
									},
									{
											"id": 7336122640580879,
											"definition": {
													"title": "Duration p90, p95",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "a",
																					"query": "p90:vercel.functions.duration{$environment,$project_name}"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "p95:vercel.functions.duration{$environment,$project_name}"
																			}
																	],
																	"formulas": [
																			{
																					"alias": "p90",
																					"formula": "a"
																			},
																			{
																					"alias": "p95",
																					"formula": "query1"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "line"
															}
													]
											},
											"layout": {
													"x": 8,
													"y": 6,
													"width": 4,
													"height": 3
											}
									},
									{
											"id": 4627326479648813,
											"definition": {
													"title": "Vercel Logs",
													"title_size": "16",
													"title_align": "left",
													"requests": [
															{
																	"query": {
																			"query_string": "source:vercel $service $env",
																			"sort": {
																					"column": "timestamp",
																					"order": "desc"
																			},
																			"data_source": "logs_stream",
																			"storage": "hot",
																			"indexes": []
																	},
																	"response_format": "event_list",
																	"columns": [
																			{
																					"field": "status_line",
																					"width": "auto"
																			},
																			{
																					"field": "timestamp",
																					"width": "auto"
																			},
																			{
																					"field": "service",
																					"width": "auto"
																			},
																			{
																					"field": "content",
																					"width": "compact"
																			}
																	]
															}
													],
													"type": "list_stream"
											},
											"layout": {
													"x": 0,
													"y": 9,
													"width": 6,
													"height": 4
											}
									},
									{
											"id": 1219881057859274,
											"definition": {
													"title": "Error Logs",
													"title_size": "16",
													"title_align": "left",
													"requests": [
															{
																	"query": {
																			"query_string": "source:vercel $service $env status:error",
																			"sort": {
																					"column": "timestamp",
																					"order": "desc"
																			},
																			"data_source": "logs_stream",
																			"storage": "hot",
																			"indexes": []
																	},
																	"response_format": "event_list",
																	"columns": [
																			{
																					"field": "status_line",
																					"width": "auto"
																			},
																			{
																					"field": "timestamp",
																					"width": "auto"
																			},
																			{
																					"field": "service",
																					"width": "auto"
																			},
																			{
																					"field": "content",
																					"width": "compact"
																			}
																	]
															}
													],
													"type": "list_stream"
											},
											"layout": {
													"x": 6,
													"y": 9,
													"width": 6,
													"height": 4
											}
									},
									{
											"id": 7917870705258875,
											"definition": {
													"title": "Metrics /path",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:vercel.requests{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query4",
																					"query": "sum:vercel.requests.by_utm_source{!proxy.path_utm_source:synthetics,$environment,projectname:$project_name.value} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:vercel.requests{!status_code:200,$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query5",
																					"query": "sum:vercel.functions.invocations{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query6",
																					"query": "sum:vercel.functions.memorysize{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query7",
																					"query": "sum:vercel.functions.max_memory_used{$environment,$project_name} by {path}.as_count()",
																					"aggregator": "sum"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 500,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "requests",
																					"formula": "query1"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "requests (no synth.)",
																					"formula": "query4"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "not 200",
																					"formula": "query2"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "Invocations",
																					"formula": "query5"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "MemSize",
																					"formula": "query6"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "MemUsed",
																					"formula": "query7"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 0,
													"y": 13,
													"width": 6,
													"height": 4
											}
									},
									{
											"id": 7109411884011652,
											"definition": {
													"title": "Requests not 200 /path",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "query1",
																					"query": "sum:vercel.requests{$environment,$project_name ,!status_code:200} by {path,status_code}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query4",
																					"query": "sum:vercel.requests.by_utm_source{!proxy.path_utm_source:synthetics,$environment,projectname:$project_name.value , !statuscode:200} by {path,statuscode}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query2",
																					"query": "sum:vercel.requests{!status_code:200,$environment,$project_name} by {path,status_code}.as_count()",
																					"aggregator": "sum"
																			},
																			{
																					"data_source": "metrics",
																					"name": "query5",
																					"query": "sum:vercel.functions.invocations{$environment,$project_name ,!status_code:200} by {path,status_code}.as_count()",
																					"aggregator": "sum"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 500,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "requests",
																					"formula": "query1"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "requests (no synth.)",
																					"formula": "query4"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "not 200",
																					"formula": "query2"
																			},
																			{
																					"cell_display_mode": "number",
																					"alias": "Invocations",
																					"formula": "query5"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 6,
													"y": 13,
													"width": 6,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 10,
							"width": 12,
							"height": 18
					}
			},
			{
					"id": 6458430103720128,
					"definition": {
							"title": "Analytics",
							"background_color": "blue",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 8998988739944969,
											"definition": {
													"title": "Requests by City (no Synthetics)",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"name": "a",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel @source:lambda -@proxy.path_utm_source:synthetics $env $service"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [
																							{
																									"facet": "@network.client.geoip.city.name",
																									"limit": 10,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							}
																					],
																					"compute": {
																							"aggregation": "count",
																							"metric": "*"
																					},
																					"storage": "hot"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "a"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 4,
													"height": 3
											}
									},
									{
											"id": 7950862531621997,
											"definition": {
													"title": "Requests by City (no Synthetics)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"name": "a",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel @source:lambda -@proxy.path_utm_source:synthetics $env $service"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [
																							{
																									"facet": "@network.client.geoip.continent.name",
																									"limit": 5,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							},
																							{
																									"facet": "@network.client.geoip.city.name",
																									"limit": 100,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							},
																							{
																									"facet": "@isAdmin",
																									"limit": 2,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							}
																					],
																					"compute": {
																							"aggregation": "count",
																							"metric": "*"
																					},
																					"storage": "hot"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 1000,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "requests",
																					"formula": "a"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 4,
													"y": 0,
													"width": 4,
													"height": 3
											}
									},
									{
											"id": 4794001386505476,
											"definition": {
													"title": "Requests (no Synthetics)",
													"title_size": "16",
													"title_align": "left",
													"type": "geomap",
													"requests": [
															{
																	"response_format": "event_list",
																	"query": {
																			"data_source": "logs_stream",
																			"query_string": "source:vercel @source:lambda -@proxy.path_utm_source:synthetics $env $service",
																			"indexes": []
																	},
																	"columns": [
																			{
																					"field": "@network.client.geoip.location.latitude",
																					"width": "auto"
																			},
																			{
																					"field": "@network.client.geoip.location.longitude",
																					"width": "auto"
																			},
																			{
																					"field": "@network.client.geoip.country.iso_code",
																					"width": "auto"
																			},
																			{
																					"field": "@network.client.geoip.subdivision.name",
																					"width": "auto"
																			}
																	]
															}
													],
													"style": {
															"palette": "hostmap_blues",
															"palette_flip": false
													},
													"view": {
															"focus": "WORLD"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 4,
													"height": 5
											}
									},
									{
											"id": 4277393670728105,
											"definition": {
													"title": "Requests by City",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"name": "a",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel @source:lambda $env $service"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [
																							{
																									"facet": "@network.client.geoip.city.name",
																									"limit": 10,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							}
																					],
																					"compute": {
																							"aggregation": "count",
																							"metric": "*"
																					},
																					"storage": "hot"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "a"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 0,
													"y": 3,
													"width": 4,
													"height": 2
											}
									},
									{
											"id": 7468952032806422,
											"definition": {
													"title": "Requests by City",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"name": "a",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel @source:lambda $env $service"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [
																							{
																									"facet": "@network.client.geoip.continent.name",
																									"limit": 10,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							},
																							{
																									"facet": "@network.client.geoip.city.name",
																									"limit": 1000,
																									"sort": {
																											"aggregation": "count",
																											"order": "desc",
																											"metric": "*"
																									},
																									"should_exclude_missing": true
																							}
																					],
																					"compute": {
																							"aggregation": "count",
																							"metric": "*"
																					},
																					"storage": "hot"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 10000,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "number",
																					"alias": "requests",
																					"formula": "a"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 4,
													"y": 3,
													"width": 4,
													"height": 2
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 28,
							"width": 12,
							"height": 6
					}
			},
			{
					"id": 6915180608010413,
					"definition": {
							"title": "Build",
							"background_color": "gray",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 1873418283655375,
											"definition": {
													"title": "Build Count",
													"title_size": "16",
													"title_align": "left",
													"show_legend": false,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "a",
																					"query": "sum:vercel.projects.build_count{*} by {project_id,project_name}.as_count()"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "a"
																			}
																	],
																	"style": {
																			"palette": "dog_classic"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 4,
													"height": 2
											}
									},
									{
											"id": 7733112663460502,
											"definition": {
													"title": "Build Count",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"queries": [
																			{
																					"data_source": "metrics",
																					"name": "a",
																					"query": "sum:vercel.projects.build_count{*} by {project_id,project_name}.as_count()",
																					"aggregator": "avg"
																			}
																	],
																	"response_format": "scalar",
																	"sort": {
																			"count": 500,
																			"order_by": [
																					{
																							"type": "formula",
																							"index": 0,
																							"order": "desc"
																					}
																			]
																	},
																	"formulas": [
																			{
																					"cell_display_mode": "bar",
																					"alias": "builds",
																					"formula": "a"
																			}
																	]
															}
													],
													"has_search_bar": "auto"
											},
											"layout": {
													"x": 4,
													"y": 0,
													"width": 4,
													"height": 2
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 34,
							"width": 12,
							"height": 3
					}
			},
			{
					"id": 16751497773518,
					"definition": {
							"title": "Billing",
							"background_color": "gray",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 5116164713874521,
											"definition": {
													"title": "Billed Duration",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"queries": [
																			{
																					"name": "query1",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel $service $env"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [],
																					"compute": {
																							"aggregation": "sum",
																							"metric": "@lambda.billed_duration"
																					},
																					"storage": "hot"
																			}
																	],
																	"response_format": "scalar"
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars",
															"yaxis": {}
													}
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 4,
													"height": 2
											}
									},
									{
											"id": 5548201595478468,
											"definition": {
													"title": "Billed Duration",
													"title_size": "16",
													"title_align": "left",
													"show_legend": true,
													"legend_layout": "auto",
													"legend_columns": [
															"avg",
															"min",
															"max",
															"value",
															"sum"
													],
													"type": "timeseries",
													"requests": [
															{
																	"response_format": "timeseries",
																	"queries": [
																			{
																					"name": "query1",
																					"data_source": "logs",
																					"search": {
																							"query": "source:vercel $service $env"
																					},
																					"indexes": [
																							"*"
																					],
																					"group_by": [],
																					"compute": {
																							"aggregation": "sum",
																							"metric": "@lambda.billed_duration"
																					},
																					"storage": "hot"
																			}
																	],
																	"formulas": [
																			{
																					"formula": "query1"
																			}
																	],
																	"style": {
																			"palette": "dog_classic",
																			"order_by": "values",
																			"line_type": "solid",
																			"line_width": "normal"
																	},
																	"display_type": "bars"
															}
													]
											},
											"layout": {
													"x": 4,
													"y": 0,
													"width": 4,
													"height": 2
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 37,
							"width": 12,
							"height": 3
					}
			},
			{
					"id": 2940957746168424,
					"definition": {
							"type": "note",
							"content": "**with <3 from [Dataiker](https://app.dataiker.com?utm_source=datadog_dashboard)** - [original dashboard](https://github.com/nxnarbais/datadog-share/tree/main/assets/vercel_advanced_dashboard)",
							"background_color": "blue",
							"font_size": "14",
							"text_align": "center",
							"vertical_align": "center",
							"show_tick": false,
							"tick_pos": "50%",
							"tick_edge": "right",
							"has_padding": true
					},
					"layout": {
							"x": 0,
							"y": 0,
							"width": 12,
							"height": 1
					}
			}
	],
	"template_variables": [
			{
					"name": "env",
					"prefix": "env",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "environment",
					"prefix": "environment",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "service",
					"prefix": "service",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "project_name",
					"prefix": "project_name",
					"available_values": [],
					"default": "*"
			}
	],
	"layout_type": "ordered",
	"notify_list": [],
	"template_variable_presets": [
			{
					"name": "Dataiker",
					"description": "",
					"template_variables": [
							{
									"name": "env",
									"value": "production"
							},
							{
									"name": "environment",
									"value": "production"
							},
							{
									"name": "service",
									"value": "app.dataiker.com"
							},
							{
									"name": "project_name",
									"value": "dataiker-app"
							}
					]
			}
	],
	"reflow_type": "fixed",
	"tags": [${join(",", [for t in var.teams : format("\"%s\"", t)])}]
}
EOF
}