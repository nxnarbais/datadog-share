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

variable "cost_per_cpu_core_per_month" {
  type    = number
  default = 10
}