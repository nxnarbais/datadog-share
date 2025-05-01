variable "teams" {
  description = "List of teams"
  type        = list(string)
  default     = ["team:dataiker"]
}

variable "title_suffix" {
  type    = string
  default = " - managed by terraform"
}

variable "managed_by_terraform" {
  type    = string
  default = "managed_by:terraform"
}

variable "latency_p90_threshold" {
  description = "Latency p90 threshold in ms"
  type    = number
  default = 500
}

variable "latency_p95_threshold" {
  description = "Latency p95 threshold in ms"
  type    = number
  default = 700
}