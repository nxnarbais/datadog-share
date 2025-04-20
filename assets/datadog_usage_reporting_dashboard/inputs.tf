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

variable "usage_breakdown_tag_1" {
  type    = string
  default = "cost_center"
}

variable "usage_breakdown_tag_2" {
  type    = string
  default = "department"
}

variable "usage_breakdown_tag_3" {
  type    = string
  default = "team"
}
