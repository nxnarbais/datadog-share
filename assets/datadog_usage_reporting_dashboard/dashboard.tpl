{
	"title": "[Dataiker][Datadog] Usage Reporting - Managed by Terraform",
	"description": "Use this dashboard to identify usage outliers.\n\n[[suggested_dashboards]]\n\nmanaged_by:terraform",
	"widgets": [
			{
					"id": 75114508277608,
					"definition": {
							"type": "note",
							"content": "# Usage Optimization\n\nThis dashboard aims at providing a few examples of utilization of estimated_usage metric to identify usage anomalies and outliers.",
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
							"width": 3,
							"height": 3
					}
			},
			{
					"id": 1371410848677903,
					"definition": {
							"type": "note",
							"content": "## How to\n\nAdapt it to your needs:\n1. Export the dashboard\n2. Replace `${tag1}`, `${tag2}`, `${tag3}` by the relevant tags\n3. Import back the dashboard",
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
							"x": 3,
							"y": 0,
							"width": 3,
							"height": 3
					}
			},
			{
					"id": 5798956784712660,
					"definition": {
							"type": "note",
							"content": "",
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
							"x": 6,
							"y": 0,
							"width": 3,
							"height": 3
					}
			},
			{
					"id": 6782550994251432,
					"definition": {
							"type": "image",
							"url": "https://images.unsplash.com/photo-1599658880436-c61792e70672",
							"sizing": "cover",
							"has_background": true,
							"has_border": true,
							"vertical_align": "center",
							"horizontal_align": "center"
					},
					"layout": {
							"x": 9,
							"y": 0,
							"width": 3,
							"height": 3
					}
			},
			{
					"id": 5752211109891192,
					"definition": {
							"title": "Infra Hosts",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 5101317465310234,
											"definition": {
													"type": "note",
													"content": "# Infra Hosts\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 7202344696000754,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 8895626067930296,
											"definition": {
													"title": "Infra Hosts",
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
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 6264230336136828,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 5185748561788506,
											"definition": {
													"title": "% spike increase vs avg",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query2 - query1) / query1 * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_yellow",
																					"value": 40,
																					"comparator": ">"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "max"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 2656776606008230,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 1,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 7611714691797082,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n*Warning: A host can be counted multiple times if it is matching multiple key value pairs.*",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 1999956100499630,
											"definition": {
													"title": "Infra Hosts per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 8210231338103008,
											"definition": {
													"type": "note",
													"content": "## Other metrics\n\nThat table is not as accurate as the official estimated_usage metric but will support more tag exploration.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 3763907719865922,
											"definition": {
													"title": "Infra Hosts (through datadog.agent.running metric)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.agent.running{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.agent.running{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.agent.running{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.agent.running{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 3,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 8136772231131352,
					"definition": {
							"title": "APM Hosts",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 1422533852819438,
											"definition": {
													"type": "note",
													"content": "# APM Hosts\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 2898160046070126,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4203506769192586,
											"definition": {
													"title": "APM Hosts",
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
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4318518076426402,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 5418610554789352,
											"definition": {
													"title": "% spike increase vs avg",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query2 - query1) / query1 * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_yellow",
																					"value": 40,
																					"comparator": ">"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "max"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 7299594088912686,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 1,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 3143090271919372,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n*Warning: A host can be counted multiple times if it is matching multiple key value pairs.*",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 7422578875783284,
											"definition": {
													"title": "APM Hosts per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm_hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 5874735922330956,
											"definition": {
													"type": "note",
													"content": "## Other metrics\n\nThat table is not as accurate as the official estimated_usage metric but will support more tag exploration.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 563283013111836,
											"definition": {
													"title": "APM Hosts (through datadog.apm.host_instance metric)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.apm.host_instance{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.apm.host_instance{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.apm.host_instance{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.apm.host_instance{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 14,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 6192609890466632,
					"definition": {
							"title": "Indexed Custom Metrics",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 6314557812258056,
											"definition": {
													"type": "note",
													"content": "# Indexed Custom Metrics\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 7247140776587052,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 6755516204211322,
											"definition": {
													"title": "Indexed Custom Metrics",
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
																					"query": "sum:datadog.estimated_usage.metrics.custom{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 6324374501177172,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 4638128396530226,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 2933728200943558,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n*Warning: A host can be counted multiple times if it is matching multiple key value pairs.*",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 4830096976060494,
											"definition": {
													"title": "Indexed Custom Metrics per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 791166045293216,
											"definition": {
													"type": "note",
													"content": "## By metric name\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 1621983712986996,
											"definition": {
													"title": "Indexed Custom Metrics per metric name",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_metric{*} by {metric_name}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_metric{*} by {metric_name}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.metrics.custom.by_metric{*} by {metric_name}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 25,
							"width": 12,
							"height": 11,
							"is_column_break": true
					}
			},
			{
					"id": 3227381642599784,
					"definition": {
							"title": "APM - Ingested Bytes",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 3689196365341452,
											"definition": {
													"type": "note",
													"content": "# APM - Ingested Bytes\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4700690466259416,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 1014030980646182,
											"definition": {
													"title": "Ingested Bytes",
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
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4333521505546690,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 7054912560522022,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 1487236256453658,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 2190857486001652,
											"definition": {
													"title": "Indexed Bytes per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 8161189780706760,
											"definition": {
													"type": "note",
													"content": "## By service\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 8831993071008736,
											"definition": {
													"title": "Ingested Bytes per service",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.ingested_bytes.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 36,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 2182259987660396,
					"definition": {
							"title": "APM - Indexed Spans",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 8546813538264552,
											"definition": {
													"type": "note",
													"content": "# APM - Indexed Spans\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4290420698344740,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4861090161556998,
											"definition": {
													"title": "Indexed Spans",
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
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 6648600398004022,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 1609608003168126,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 6522892773716868,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 8397106523500072,
											"definition": {
													"title": "Indexed Spans per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 7013617776366964,
											"definition": {
													"type": "note",
													"content": "## By service\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 6108646640982102,
											"definition": {
													"title": "Indexed Spans per service",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.apm.indexed_spans.by_tag{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 47,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 6223703276775402,
					"definition": {
							"title": "Logs - Ingested Bytes",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 201272265616014,
											"definition": {
													"type": "note",
													"content": "# Logs - Ingested Bytes\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 6550203148276658,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4748604130026064,
											"definition": {
													"title": "Ingested Bytes",
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
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 6905329202222836,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 4224950985047334,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 8231115129734214,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 3513232724587004,
											"definition": {
													"title": "Indexed Bytes per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 2585609763915664,
											"definition": {
													"type": "note",
													"content": "## By index\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 1,
													"height": 4
											}
									},
									{
											"id": 8867063414507312,
											"definition": {
													"title": "Ingested Bytes per service",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 1,
													"y": 6,
													"width": 5,
													"height": 4
											}
									},
									{
											"id": 4942214599213202,
											"definition": {
													"type": "note",
													"content": "## By service\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 6,
													"y": 6,
													"width": 1,
													"height": 4
											}
									},
									{
											"id": 719754897029754,
											"definition": {
													"title": "Ingested Bytes per service",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_bytes{${filter_string}} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 7,
													"y": 6,
													"width": 5,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 58,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 2545727345104424,
					"definition": {
							"title": "Logs - Indexed Logs",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 711634132932782,
											"definition": {
													"type": "note",
													"content": "# Indexed Logs\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 2521874983023276,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 8391947056439634,
											"definition": {
													"title": "Indexed Logs",
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
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 6311603430603696,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 2587595121216658,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 6956395776054862,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 145757428802580,
											"definition": {
													"title": "Indexed Logs per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 7856816016315036,
											"definition": {
													"type": "note",
													"content": "## By index \n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 1,
													"height": 4
											}
									},
									{
											"id": 2075702226680938,
											"definition": {
													"title": "Indexed Logs per index",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {datadog_index}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 1,
													"y": 6,
													"width": 5,
													"height": 4
											}
									},
									{
											"id": 1367594356371306,
											"definition": {
													"type": "note",
													"content": "## By service\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 6,
													"y": 6,
													"width": 1,
													"height": 4
											}
									},
									{
											"id": 887820460959204,
											"definition": {
													"title": "Indexed Logs per service",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.logs.ingested_events{${filter_string},datadog_is_excluded:false} by {service}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 7,
													"y": 6,
													"width": 5,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 69,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 7697135426111742,
					"definition": {
							"title": "Synthetics - API",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 1466649369640070,
											"definition": {
													"type": "note",
													"content": "# Synthetics API\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 3311546142707288,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 5674473038396314,
											"definition": {
													"title": "Synthetics API",
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
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 3143551197357598,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 7680181380254548,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 483476897336100,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 832790649404880,
											"definition": {
													"title": "Synthetics API per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 7071587091395514,
											"definition": {
													"type": "note",
													"content": "## By url\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 5644122297479358,
											"definition": {
													"title": "Synthetics API per url",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {url}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {url}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.api_test_runs{${filter_string}} by {url}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 80,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 1829691910952808,
					"definition": {
							"title": "Synthetics - Browser",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 8787308055358412,
											"definition": {
													"type": "note",
													"content": "# Synthetics Browser\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 1547440690548928,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 7079547178796894,
											"definition": {
													"title": "Synthetics Browser",
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
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 210495736718778,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 5649896228341154,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 1618567874440198,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 6559424769830304,
											"definition": {
													"title": "Synthetics Browser per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 2383035087714380,
											"definition": {
													"type": "note",
													"content": "## By start url\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 1414788726200366,
											"definition": {
													"title": "Synthetics Browser per start url",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {start_url}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {start_url}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.synthetics.browser_test_runs{${filter_string}} by {start_url}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 91,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 4604551538669590,
					"definition": {
							"title": "Serverless - Lambda Functions",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 7971952097369728,
											"definition": {
													"type": "note",
													"content": "# Lambda Functions\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 6839144467340490,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 6077180670043772,
											"definition": {
													"title": "Lambda Functions",
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
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 26069840781680,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 4413980644595224,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 3305027934900336,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 6712287223522336,
											"definition": {
													"title": "Lambda functions per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.aws_lambda_functions.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 102,
							"width": 12,
							"height": 7
					}
			},
			{
					"id": 208481120396978,
					"definition": {
							"title": "Serverless - Lambda Invocations",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 2308675303183274,
											"definition": {
													"type": "note",
													"content": "# Lambda Invocations\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 3064279932182818,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 3871118954009814,
											"definition": {
													"title": "Lambda Invocations",
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
																					"query": "sum:datadog.estimated_usage.serverless.invocations{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 8421444997538170,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 379390079076790,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 5283152783047844,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 6861209583976646,
											"definition": {
													"title": "Lambda invocations per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.serverless.invocations.by_tag{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 3675082439617824,
											"definition": {
													"type": "note",
													"content": "## By context\n\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 9001553875252850,
											"definition": {
													"title": "Lambda invocations per tag (enhanced metrics)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:aws.lambda.enhanced.invocations{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:aws.lambda.enhanced.invocations{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:aws.lambda.enhanced.invocations{${filter_string}} by {${group_by_string}}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 109,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 2570277140959658,
					"definition": {
							"title": "RUM - Sessions",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 2262956646173994,
											"definition": {
													"type": "note",
													"content": "# RUM - Sessions\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 0,
													"width": 4,
													"height": 8
											}
									},
									{
											"id": 1977734936559222,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 4,
													"y": 0,
													"width": 2,
													"height": 8
											}
									},
									{
											"id": 2356007935784188,
											"definition": {
													"title": "Browser Sessions",
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
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4277418934662608,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 8708794762689538,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 5248729642562502,
											"definition": {
													"title": "Replay Sessions",
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
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 2,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4373898250976320,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 7339922426102042,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
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
											"id": 284749287180896,
											"definition": {
													"title": "Mobile Sessions",
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
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:mobile}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 4,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 3241660305638290,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:mobile}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:mobile}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 8025400534592468,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:mobile}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:mobile}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
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
											"id": 113680119050206,
											"definition": {
													"title": "Legacy Sessions",
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
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:legacy}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 6,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 1631301373651506,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:legacy}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:legacy}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 6,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 1511782349043366,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:legacy}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{sku:legacy}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 6,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 8065846966563400,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 8,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 5742900235724940,
											"definition": {
													"title": "RUM sessions per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{${filter_string}} by {env,application.id,service,source,sku}.as_count()",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{${filter_string}} by {env,application.id,service,source,sku}.as_count()",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "sum"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.rum.sessions{${filter_string}} by {env,application.id,service,source,sku}.as_count()",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "sum"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current ",
																					"formula": "query1"
																			},
																			{
																					"alias": "week before ",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "month before ",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 8,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 120,
							"width": 12,
							"height": 13
					}
			},
			{
					"id": 5294588308933680,
					"definition": {
							"title": "Profiling Hosts",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 5436869818800386,
											"definition": {
													"type": "note",
													"content": "# Profiling Hosts\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 5767069314935888,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 1758886268212618,
											"definition": {
													"title": "Profiling Hosts",
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
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 2264744653406332,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 8401793424659300,
											"definition": {
													"title": "% spike increase vs avg",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query2 - query1) / query1 * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_yellow",
																					"value": 40,
																					"comparator": ">"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "max"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 1884179890154820,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 1,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 5010201739347982,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n*Warning: A host can be counted multiple times if it is matching multiple key value pairs.*",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 3613866941960132,
											"definition": {
													"title": "Profiling Hosts per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.profiling.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 5295588905359024,
											"definition": {
													"type": "note",
													"content": "## Other metrics\n\nThat table is not as accurate as the official estimated_usage metric but will support more tag exploration.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 1974397305519418,
											"definition": {
													"title": "Profiling Hosts (through datadog.profiling.agent metric)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.profiling.agent{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.profiling.agent{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.profiling.agent{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.profiling.agent{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 133,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 5851862163412844,
					"definition": {
							"title": "NPM Hosts (Network)",
							"background_color": "purple",
							"show_title": true,
							"type": "group",
							"layout_type": "ordered",
							"widgets": [
									{
											"id": 7445145361065722,
											"definition": {
													"type": "note",
													"content": "# NPM Hosts\n\nObjectives:\n- Analyse trends\n- Identify outliers\n\nRecommendations:\n- Select a large enough time period (> 1 day)",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 4865923141449742,
											"definition": {
													"type": "note",
													"content": "## Global Trends\n\nCheck if overall the volume is increasing vs previous periods.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
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
											"id": 2245767520196158,
											"definition": {
													"title": "NPM Hosts",
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
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 6,
													"y": 0,
													"width": 2,
													"height": 2
											}
									},
									{
											"id": 4799606885740376,
											"definition": {
													"title": "Count vs week_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-1w', 'UTC')) / calendar_shift(query2, '-1w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 2557516917427320,
											"definition": {
													"title": "% spike increase vs avg",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query2 - query1) / query1 * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_yellow",
																					"value": 40,
																					"comparator": ">"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "max"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 10,
													"y": 0,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 1528656827769680,
											"definition": {
													"title": "Count vs month_before",
													"title_size": "16",
													"title_align": "left",
													"type": "query_value",
													"requests": [
															{
																	"formulas": [
																			{
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			}
																	],
																	"conditional_formats": [
																			{
																					"palette": "white_on_red",
																					"value": 20,
																					"comparator": ">"
																			},
																			{
																					"palette": "white_on_green",
																					"value": -10,
																					"comparator": "<"
																			}
																	],
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts{*}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			}
																	]
															}
													],
													"autoscale": true,
													"custom_unit": "%",
													"precision": 2,
													"timeseries_background": {
															"type": "bars"
													}
											},
											"layout": {
													"x": 8,
													"y": 1,
													"width": 2,
													"height": 1
											}
									},
									{
											"id": 3862491800482774,
											"definition": {
													"type": "note",
													"content": "## By context\n\nIdentify the contexts with the largest increase and contact the owners to justify the additional usage.\n\n*Warning: A host can be counted multiple times if it is matching multiple key value pairs.*",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 2,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 2022938722366534,
											"definition": {
													"title": "NPM Hosts per selected tags",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.estimated_usage.network.hosts.by_tag{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 2,
													"width": 10,
													"height": 4
											}
									},
									{
											"id": 8689973650821660,
											"definition": {
													"type": "note",
													"content": "## Other metrics\n\nThat table is not as accurate as the official estimated_usage metric but will support more tag exploration.",
													"background_color": "gray",
													"font_size": "14",
													"text_align": "left",
													"vertical_align": "top",
													"show_tick": true,
													"tick_pos": "50%",
													"tick_edge": "right",
													"has_padding": true
											},
											"layout": {
													"x": 0,
													"y": 6,
													"width": 2,
													"height": 4
											}
									},
									{
											"id": 7252877993688336,
											"definition": {
													"title": "NPM Hosts (through datadog.system_probe.agent.network_tracer metric)",
													"title_size": "16",
													"title_align": "left",
													"type": "query_table",
													"requests": [
															{
																	"response_format": "scalar",
																	"queries": [
																			{
																					"query": "sum:datadog.system_probe.agent.network_tracer{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query1",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.system_probe.agent.network_tracer{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query2",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.system_probe.agent.network_tracer{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query4",
																					"aggregator": "avg"
																			},
																			{
																					"query": "sum:datadog.system_probe.agent.network_tracer{${filter_string}} by {${group_by_string}}",
																					"data_source": "metrics",
																					"name": "query3",
																					"aggregator": "max"
																			}
																	],
																	"sort": {
																			"count": 50,
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
																					"alias": "current (avg)",
																					"formula": "query1"
																			},
																			{
																					"alias": "month before (avg)",
																					"formula": "calendar_shift(query2, '-4w', 'UTC')"
																			},
																			{
																					"alias": "week before (avg)",
																					"formula": "calendar_shift(query4, '-1w', 'UTC')"
																			},
																			{
																					"alias": "% vs week before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query4, '-1w', 'UTC')) / calendar_shift(query4, '-1w', 'UTC') * 100"
																			},
																			{
																					"alias": "% vs month before",
																					"conditional_formats": [
																							{
																									"palette": "white_on_red",
																									"value": 20,
																									"comparator": ">"
																							},
																							{
																									"palette": "white_on_green",
																									"value": -10,
																									"comparator": "<"
																							}
																					],
																					"formula": "(query1 - calendar_shift(query2, '-4w', 'UTC')) / calendar_shift(query2, '-4w', 'UTC') * 100"
																			},
																			{
																					"alias": "% spike increase vs avg",
																					"conditional_formats": [
																							{
																									"palette": "white_on_yellow",
																									"value": 40,
																									"comparator": ">"
																							}
																					],
																					"formula": "(query3 - query1) / query1 * 100"
																			}
																	]
															}
													]
											},
											"layout": {
													"x": 2,
													"y": 6,
													"width": 10,
													"height": 4
											}
									}
							]
					},
					"layout": {
							"x": 0,
							"y": 144,
							"width": 12,
							"height": 11
					}
			},
			{
					"id": 7034658301114627,
					"definition": {
							"type": "note",
							"content": "**with <3 from [Dataiker](https://app.dataiker.com)** - [original dashboard](https://github.com/nxnarbais/datadog-share/tree/main/assets/datadog_usage_reporting_dashboard)",
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
					"name": "${tag1}",
					"prefix": "${tag1}",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "${tag2}",
					"prefix": "${tag2}",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "${tag3}",
					"prefix": "${tag3}",
					"available_values": [],
					"default": "*"
			},
			{
					"name": "metric_name",
					"prefix": "metric_name",
					"available_values": [],
					"default": "*"
			}
	],
	"layout_type": "ordered",
	"notify_list": [],
	"reflow_type": "fixed",
	"tags": [
			"team:dataiker"
	]
}