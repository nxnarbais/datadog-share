resource "datadog_dashboard_json" "kubernetes_capacity_planning" {
  dashboard = <<EOF
{
    "title": "[Dataiker][Kubernetes] Capacity Planning${var.title_suffix}",
    "description": "Use this dashboard to set a relevant CPU and Memory requests on your pods and save money meanwhile.\n\n[[suggested_dashboards]]\n\n${var.managed_by_terraform}",
    "widgets": [
        {
            "id": 443466849361936,
            "definition": {
                "type": "note",
                "content": "# Kubernetes Capacity Planning\n\nThis dashboard aims to provide the relevant information for Kubernetes administrators and users to identify if the CPU and Mem requests are properly configured and not generating unnecessary waste.",
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
            "id": 446586294053350,
            "definition": {
                "type": "note",
                "content": "## How to\n\n1. Select a large timeframe (recommended 1 week+)\n2. Select a cluster of interest\n3. Once a deployment or daemonset is identified, select it to visualize its usage across time",
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
            "id": 7328840637400146,
            "definition": {
                "type": "note",
                "content": "## Resource Requests and Limits in Kubernetes\n\nRequests specify the minimum amount of resources a container needs to run reliably. For example, if your application needs at least 256MB of memory to function, you’d set the memory request to 256MB. Kubernetes will then ensure that this minimum amount is always available to the container. The container can use more than this if needed — up to a defined limit.\n\nLimits represent the maximum amount of resources a container is allowed to consume. This prevents a single container from monopolizing node resources.\n\nIdentifying Overprovisioned Pods\n\nWhen a pod’s actual usage is consistently much lower than its requested resources, it’s considered overprovisioned. In these cases, adjusting (or right-sizing) the requests to better match actual usage can lead to more efficient scheduling and resource utilization across the cluster.",
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
                "width": 4,
                "height": 3
            }
        },
        {
            "id": 3857869053162142,
            "definition": {
                "type": "image",
                "url": "/static/images/integration_dashboard/kubernetes_hero_2.jpeg",
                "sizing": "cover",
                "has_background": true,
                "has_border": true,
                "vertical_align": "center",
                "horizontal_align": "center"
            },
            "layout": {
                "x": 10,
                "y": 0,
                "width": 2,
                "height": 3
            }
        },
        {
            "id": 6541756623956422,
            "definition": {
                "title": "Cluster Capacity Review",
                "background_color": "purple",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 6307693417703347,
                        "definition": {
                            "type": "note",
                            "content": "",
                            "background_color": "white",
                            "font_size": "14",
                            "text_align": "left",
                            "vertical_align": "top",
                            "show_tick": false,
                            "tick_pos": "50%",
                            "tick_edge": "right",
                            "has_padding": true
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 2413632323292915,
                        "definition": {
                            "title": "CPU Usage",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query7"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
                            }
                        },
                        "layout": {
                            "x": 2,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 1201208760933652,
                        "definition": {
                            "title": "CPU Requests",
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
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
                            }
                        },
                        "layout": {
                            "x": 4,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 4042020651191063,
                        "definition": {
                            "title": "CPU Core Savings (~${var.cost_per_cpu_core_per_month}$/cpu_core/month)",
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
                                                    "unit_name": "dollar"
                                                }
                                            },
                                            "formula": "(query1 - query7 / 1000000000) * ${var.cost_per_cpu_core_per_month}"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 7382252026117212,
                        "definition": {
                            "title": "Mem Usage",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query8"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 3654993424625868,
                        "definition": {
                            "title": "Mem Requests",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query5"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 3018187039179016,
                        "definition": {
                            "type": "note",
                            "content": "## Cluster Capacity Review\n\n### Definitions\n\n```\nCPU Wasted = Total CPU Requests - Total CPU Usage\n```\n```\nMem Wasted = Total Mem Requests - Total Mem Usage\n```",
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
                            "y": 2,
                            "width": 3,
                            "height": 4
                        }
                    },
                    {
                        "id": 898849511779978,
                        "definition": {
                            "title": "CPU and Mem by cluster",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "sort": {
                                        "count": 500,
                                        "order_by": [
                                            {
                                                "type": "formula",
                                                "index": 2,
                                                "order": "desc"
                                            }
                                        ]
                                    },
                                    "formulas": [
                                        {
                                            "alias": "CPU Core Usage Total",
                                            "formula": "query7"
                                        },
                                        {
                                            "alias": "Mem Usage Total",
                                            "formula": "query8"
                                        },
                                        {
                                            "alias": "CPU Core \"Wasted\"",
                                            "conditional_formats": [
                                                {
                                                    "palette": "black_on_light_green",
                                                    "comparator": "<",
                                                    "value": 0
                                                },
                                                {
                                                    "palette": "white_on_yellow",
                                                    "comparator": ">=",
                                                    "value": 40
                                                },
                                                {
                                                    "palette": "black_on_light_yellow",
                                                    "comparator": ">=",
                                                    "value": 0
                                                }
                                            ],
                                            "formula": "query1 - query7 / 1000000000"
                                        },
                                        {
                                            "alias": "MEM  \"Wasted\"",
                                            "conditional_formats": [
                                                {
                                                    "palette": "black_on_light_green",
                                                    "comparator": "<",
                                                    "value": 0
                                                },
                                                {
                                                    "palette": "white_on_yellow",
                                                    "comparator": ">=",
                                                    "value": 50000000000
                                                },
                                                {
                                                    "palette": "black_on_light_yellow",
                                                    "comparator": ">=",
                                                    "value": 0
                                                }
                                            ],
                                            "formula": "query5 - query8"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 3,
                            "y": 2,
                            "width": 6,
                            "height": 4
                        }
                    },
                    {
                        "id": 1154213692680458,
                        "definition": {
                            "title": "Potential Savings (~${var.cost_per_cpu_core_per_month}$/cpu_core/month)",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
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
                                            "alias": "Potential Savings",
                                            "formula": "(query1 - query7 / 1000000000) * ${var.cost_per_cpu_core_per_month}",
                                            "cell_display_mode": "number"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 9,
                            "y": 2,
                            "width": 3,
                            "height": 4
                        }
                    },
                    {
                        "id": 8268929096975252,
                        "definition": {
                            "type": "note",
                            "content": "## Utilization per Kubernetes object\n\nEach line represent a specific Kubernetes object: daemonset, deployment, etc.\n\nThe last two columns represent the average usage vs the request for CPU and Memory.\n\n",
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
                            "height": 5
                        }
                    },
                    {
                        "id": 454023358841718,
                        "definition": {
                            "title": "CPU and Mem by Kubernetes Objects",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
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
                                            "alias": "CPU requests",
                                            "cell_display_mode": "number",
                                            "formula": "query1"
                                        },
                                        {
                                            "alias": "CPU usage",
                                            "cell_display_mode": "number",
                                            "formula": "query7"
                                        },
                                        {
                                            "alias": "MEM requests",
                                            "formula": "query5"
                                        },
                                        {
                                            "alias": "MEM usage",
                                            "formula": "query8"
                                        },
                                        {
                                            "alias": "% CPU requests",
                                            "conditional_formats": [
                                                {
                                                    "palette": "white_on_red",
                                                    "comparator": "<",
                                                    "value": 60
                                                }
                                            ],
                                            "formula": "query7 / (query1 * 1000000000) * 100"
                                        },
                                        {
                                            "alias": "% MEM requests",
                                            "conditional_formats": [
                                                {
                                                    "palette": "white_on_red",
                                                    "comparator": "<",
                                                    "value": 60
                                                }
                                            ],
                                            "formula": "query8 / query5 * 100"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 2,
                            "y": 6,
                            "width": 10,
                            "height": 5
                        }
                    },
                    {
                        "id": 39184828621360,
                        "definition": {
                            "title": "CPU Opportunity - Deployments",
                            "type": "treemap",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name ,kube_deployment:*} by {kube_cluster_name,kube_deployment}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name ,kube_deployment:*} by {kube_cluster_name,kube_deployment}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "formulas": [
                                        {
                                            "alias": "CPU opportunity",
                                            "formula": "query1 - query7 / 1000 / 1000 / 1000"
                                        }
                                    ]
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 11,
                            "width": 6,
                            "height": 3
                        }
                    },
                    {
                        "id": 2889197562919864,
                        "definition": {
                            "title": "MEM Opportunity - Deployment",
                            "type": "treemap",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name ,kube_deployment:*} by {kube_cluster_name,kube_deployment}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name ,kube_deployment:*} by {kube_cluster_name,kube_deployment}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "formulas": [
                                        {
                                            "alias": "% MEM requests",
                                            "formula": "query5 - query8"
                                        }
                                    ]
                                }
                            ]
                        },
                        "layout": {
                            "x": 6,
                            "y": 11,
                            "width": 6,
                            "height": 3
                        }
                    },
                    {
                        "id": 7705765655502342,
                        "definition": {
                            "title": "CPU Opportunity - DaemonSet",
                            "type": "treemap",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name, kube_daemon_set:*} by {kube_cluster_name,kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,kube_daemon_set:*} by {kube_cluster_name,kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "formulas": [
                                        {
                                            "alias": "CPU opportunity",
                                            "formula": "query1 - query7 / 1000 / 1000 / 1000"
                                        }
                                    ]
                                }
                            ]
                        },
                        "layout": {
                            "x": 0,
                            "y": 14,
                            "width": 6,
                            "height": 3
                        }
                    },
                    {
                        "id": 6126760839503358,
                        "definition": {
                            "title": "MEM Opportunity - DaemonSet",
                            "type": "treemap",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,kube_daemon_set:*} by {kube_cluster_name,kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,kube_daemon_set:*} by {kube_cluster_name,kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "formulas": [
                                        {
                                            "alias": "% MEM requests",
                                            "formula": "query5 - query8"
                                        }
                                    ]
                                }
                            ]
                        },
                        "layout": {
                            "x": 6,
                            "y": 14,
                            "width": 6,
                            "height": 3
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 3,
                "width": 12,
                "height": 18
            }
        },
        {
            "id": 554427394930086,
            "definition": {
                "title": "Capacity Review per Kubernetes Object",
                "background_color": "purple",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 6582030986222503,
                        "definition": {
                            "type": "note",
                            "content": "",
                            "background_color": "white",
                            "font_size": "14",
                            "text_align": "left",
                            "vertical_align": "top",
                            "show_tick": false,
                            "tick_pos": "50%",
                            "tick_edge": "right",
                            "has_padding": true
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 6918424267854857,
                        "definition": {
                            "title": "CPU Usage",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query7"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
                            }
                        },
                        "layout": {
                            "x": 2,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 3656791192582287,
                        "definition": {
                            "title": "CPU Requests",
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
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
                            }
                        },
                        "layout": {
                            "x": 4,
                            "y": 0,
                            "width": 2,
                            "height": 2
                        }
                    },
                    {
                        "id": 5912677931185469,
                        "definition": {
                            "title": "CPU Core Savings (~${var.cost_per_cpu_core_per_month}$/cpu_core/month)",
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
                                                    "unit_name": "dollar"
                                                }
                                            },
                                            "formula": "(query1 - query7 / 1000000000) * ${var.cost_per_cpu_core_per_month}"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 2313227357077355,
                        "definition": {
                            "title": "Mem Usage",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query8"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 2937201974343214,
                        "definition": {
                            "title": "Mem Requests",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_value",
                            "requests": [
                                {
                                    "formulas": [
                                        {
                                            "formula": "query5"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        }
                                    ],
                                    "response_format": "scalar"
                                }
                            ],
                            "autoscale": true,
                            "precision": 2,
                            "timeseries_background": {
                                "type": "area"
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
                        "id": 1326422038975066,
                        "definition": {
                            "type": "note",
                            "content": "## How to\n\n1- Select a deployment or daemonset\n\n2- It is preferable to not set a cluster or environment for this section to see the impact cross clusters and environments. This can help observe different behavior and different \"request\" needs for different environments and clusters",
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
                            "y": 2,
                            "width": 2,
                            "height": 4
                        }
                    },
                    {
                        "id": 2350886867040916,
                        "definition": {
                            "title": "CPU and Mem by Kubernetes Objects",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "avg:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query9",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "avg:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query10",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6",
                                            "aggregator": "avg"
                                        }
                                    ],
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
                                            "alias": "CPU requests",
                                            "cell_display_mode": "number",
                                            "formula": "query1"
                                        },
                                        {
                                            "alias": "CPU usage",
                                            "cell_display_mode": "number",
                                            "formula": "query7"
                                        },
                                        {
                                            "alias": "MEM requests",
                                            "formula": "query5"
                                        },
                                        {
                                            "alias": "MEM usage",
                                            "formula": "query8"
                                        },
                                        {
                                            "alias": "% CPU requests",
                                            "conditional_formats": [
                                                {
                                                    "palette": "white_on_red",
                                                    "comparator": "<",
                                                    "value": 60
                                                }
                                            ],
                                            "formula": "query7 / (query1 * 1000000000) * 100"
                                        },
                                        {
                                            "alias": "% MEM requests",
                                            "conditional_formats": [
                                                {
                                                    "palette": "white_on_red",
                                                    "comparator": "<",
                                                    "value": 60
                                                }
                                            ],
                                            "formula": "query8 / query5 * 100"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 2,
                            "y": 2,
                            "width": 10,
                            "height": 4
                        }
                    },
                    {
                        "id": 2377355700631554,
                        "definition": {
                            "type": "note",
                            "content": "3- Identify if overprovisionning resources is justified for spikes\n\n*Note: the y axis is not linear*",
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
                            "height": 3
                        }
                    },
                    {
                        "id": 8138378275514268,
                        "definition": {
                            "title": "CPU utilization vs request",
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
                                    "formulas": [
                                        {
                                            "alias": "% CPU requests",
                                            "formula": "query7 / (query1 * 1000000000) * 100"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ],
                            "yaxis": {
                                "scale": "sqrt",
                                "include_zero": false,
                                "max": "120"
                            },
                            "markers": [
                                {
                                    "value": "y < 60",
                                    "display_type": "error dashed"
                                },
                                {
                                    "value": "y < 80",
                                    "display_type": "warning dashed"
                                },
                                {
                                    "value": "y > 80",
                                    "display_type": "ok dashed"
                                }
                            ]
                        },
                        "layout": {
                            "x": 2,
                            "y": 6,
                            "width": 5,
                            "height": 3
                        }
                    },
                    {
                        "id": 4788165208070154,
                        "definition": {
                            "title": "Mem utilization vs request",
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
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6"
                                        }
                                    ],
                                    "formulas": [
                                        {
                                            "formula": "query8 / query5 * 100",
                                            "alias": "% MEM requests"
                                        }
                                    ],
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ],
                            "yaxis": {
                                "scale": "sqrt",
                                "min": "0",
                                "max": "120"
                            },
                            "markers": [
                                {
                                    "value": "y < 60",
                                    "display_type": "error dashed"
                                },
                                {
                                    "value": "y < 80",
                                    "display_type": "warning dashed"
                                },
                                {
                                    "value": "y > 80",
                                    "display_type": "ok dashed"
                                }
                            ]
                        },
                        "layout": {
                            "x": 7,
                            "y": 6,
                            "width": 5,
                            "height": 3
                        }
                    },
                    {
                        "id": 4085731654655840,
                        "definition": {
                            "type": "note",
                            "content": "4- Estimate the right request to set. Do not hesitate to filter per cluster to improve clarity.\n\n*Note: the y axis is not linear*",
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
                            "y": 9,
                            "width": 2,
                            "height": 3
                        }
                    },
                    {
                        "id": 7078539035969836,
                        "definition": {
                            "title": "CPU utilization vs request",
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
                                    "formulas": [
                                        {
                                            "alias": "usage per pod",
                                            "formula": "query7"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "avg:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7"
                                        },
                                        {
                                            "query": "avg:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                },
                                {
                                    "formulas": [
                                        {
                                            "alias": "request per pod",
                                            "formula": "query0"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "data_source": "metrics",
                                            "name": "query0",
                                            "query": "avg:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "dashed",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ],
                            "yaxis": {
                                "scale": "sqrt",
                                "include_zero": false
                            },
                            "markers": []
                        },
                        "layout": {
                            "x": 2,
                            "y": 9,
                            "width": 5,
                            "height": 3
                        }
                    },
                    {
                        "id": 4295241541769676,
                        "definition": {
                            "title": "Mem utilization vs request",
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
                                    "formulas": [
                                        {
                                            "alias": "usage per pod",
                                            "formula": "query8"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "query": "avg:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query8"
                                        },
                                        {
                                            "query": "avg:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query5"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query1"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query7"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query2"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}",
                                            "data_source": "metrics",
                                            "name": "query6"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "solid",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                },
                                {
                                    "formulas": [
                                        {
                                            "alias": "request per pod",
                                            "formula": "query0"
                                        }
                                    ],
                                    "queries": [
                                        {
                                            "data_source": "metrics",
                                            "name": "query0",
                                            "query": "avg:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name,$kube_deployment,$kube_daemon_set} by {kube_cluster_name,env,kube_deployment,kube_daemon_set,kube_stateful_set}"
                                        }
                                    ],
                                    "response_format": "timeseries",
                                    "style": {
                                        "palette": "dog_classic",
                                        "line_type": "dashed",
                                        "line_width": "normal"
                                    },
                                    "display_type": "line"
                                }
                            ],
                            "yaxis": {
                                "scale": "sqrt",
                                "min": "0"
                            },
                            "markers": []
                        },
                        "layout": {
                            "x": 7,
                            "y": 9,
                            "width": 5,
                            "height": 3
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 21,
                "width": 12,
                "height": 13,
                "is_column_break": true
            }
        },
        {
            "id": 986801580339488,
            "definition": {
                "title": "CPU and Memory utilization per cluster",
                "background_color": "purple",
                "show_title": true,
                "type": "group",
                "layout_type": "ordered",
                "widgets": [
                    {
                        "id": 3899377194392834,
                        "definition": {
                            "title": "CPU by cluster",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.cpu.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query2",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.cpu.usage.total{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query7",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:system.cpu.num_cores{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query3",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "avg:system.cpu.idle{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query4",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "avg:system.cpu.system{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "avg:system.cpu.user{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query6",
                                            "aggregator": "avg"
                                        }
                                    ],
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
                                            "alias": "requests",
                                            "cell_display_mode": "bar",
                                            "formula": "query1"
                                        },
                                        {
                                            "alias": "limits",
                                            "cell_display_mode": "bar",
                                            "formula": "query2"
                                        },
                                        {
                                            "alias": "usage",
                                            "cell_display_mode": "bar",
                                            "formula": "query7"
                                        },
                                        {
                                            "alias": "num cores",
                                            "cell_display_mode": "bar",
                                            "formula": "query3"
                                        },
                                        {
                                            "alias": "cpu idle",
                                            "cell_display_mode": "bar",
                                            "formula": "query4"
                                        },
                                        {
                                            "alias": "cpu system",
                                            "cell_display_mode": "bar",
                                            "formula": "query5"
                                        },
                                        {
                                            "alias": "cpu user",
                                            "cell_display_mode": "bar",
                                            "formula": "query6"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 0,
                            "y": 0,
                            "width": 12,
                            "height": 3
                        }
                    },
                    {
                        "id": 7573198214876406,
                        "definition": {
                            "title": "Memory by cluster",
                            "title_size": "16",
                            "title_align": "left",
                            "type": "query_table",
                            "requests": [
                                {
                                    "response_format": "scalar",
                                    "queries": [
                                        {
                                            "query": "sum:kubernetes.memory.requests{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query1",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.limits{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query2",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:kubernetes.memory.usage{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query6",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:system.mem.total{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query3",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:system.mem.free{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query4",
                                            "aggregator": "avg"
                                        },
                                        {
                                            "query": "sum:system.mem.used{$scope,$env,$kube_namespace,$kube_cluster_name} by {kube_cluster_name,env}",
                                            "data_source": "metrics",
                                            "name": "query5",
                                            "aggregator": "avg"
                                        }
                                    ],
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
                                            "alias": "requests",
                                            "cell_display_mode": "bar",
                                            "formula": "query1"
                                        },
                                        {
                                            "alias": "limits",
                                            "cell_display_mode": "bar",
                                            "formula": "query2"
                                        },
                                        {
                                            "alias": "usage",
                                            "cell_display_mode": "bar",
                                            "formula": "query6"
                                        },
                                        {
                                            "alias": "total",
                                            "cell_display_mode": "bar",
                                            "formula": "query3"
                                        },
                                        {
                                            "alias": "Free",
                                            "cell_display_mode": "bar",
                                            "formula": "query4"
                                        },
                                        {
                                            "alias": "Used",
                                            "cell_display_mode": "bar",
                                            "formula": "query5"
                                        }
                                    ]
                                }
                            ],
                            "has_search_bar": "auto"
                        },
                        "layout": {
                            "x": 0,
                            "y": 3,
                            "width": 12,
                            "height": 3
                        }
                    }
                ]
            },
            "layout": {
                "x": 0,
                "y": 34,
                "width": 12,
                "height": 7
            }
        },
        {
            "id": 7034658301114627,
            "definition": {
                "type": "note",
                "content": "**with <3 from [Dataiker](https://app.dataiker.com)** - [original dashboard](https://github.com/nxnarbais/datadog-share/tree/main/assets/kubernetes_capacity_planning_dashboard)",
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
            "name": "scope",
            "prefix": "*",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "env",
            "prefix": "env",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "kube_cluster_name",
            "prefix": "kube_cluster_name",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "kube_namespace",
            "prefix": "kube_namespace",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "kube_deployment",
            "prefix": "kube_deployment",
            "available_values": [],
            "default": "*"
        },
        {
            "name": "kube_daemon_set",
            "prefix": "kube_daemon_set",
            "available_values": [],
            "default": "*"
        }
    ],
    "layout_type": "ordered",
    "notify_list": [],
    "reflow_type": "fixed",
    "tags": [${join(",", [for t in var.teams : format("\"%s\"", t)])}]
}
EOF
}