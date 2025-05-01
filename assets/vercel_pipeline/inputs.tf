variable "tags" {
  description = "List of tags"
  type        = list(string)
  default     = ["team:dataiker","managed_by:terraform"]
}

variable "name_suffix" {
  type    = string
  default = " - managed by terraform"
}

variable "managed_by_terraform" {
  type    = string
  default = "managed_by:terraform"
}

variable "vlookup_project_name_to_team" {
  description = "Lookup table to map project name to team"
  type        = list(string)
  default     = ["dataiker-app,dataiker"]
}

variable "vlookup_is_admin" {
  description = "Lookup table to map ip to is_admin"
  type        = list(string)
  default     = ["your_home_ip,true","your_work_ip,true"]
}