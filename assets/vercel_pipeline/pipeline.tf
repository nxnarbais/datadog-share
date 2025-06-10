resource "datadog_logs_custom_pipeline" "vercel_pipeline" {
  filter {
    query = "source:vercel"
  }
  name       = "Vercel Custom${var.name_suffix}"
	tags = var.tags
  is_enabled = true
	processor {
		attribute_remapper {
			name = "@projectName to project_name"
			is_enabled = true
			source_type = "attribute"
			target_type = "tag"
			sources = ["projectName"]
			target = "project_name"
			override_on_conflict = false
			preserve_source = true
		}
	}
	processor {
		attribute_remapper {
			name = "@environment to environment"
			is_enabled = true
			source_type = "attribute"
			target_type = "tag"
			sources = ["environment"]
			target = "environment"
			override_on_conflict = false
			preserve_source = true
		}
	}
	processor {
		attribute_remapper {
			name = "@environment to env"
			is_enabled = true
			source_type = "attribute"
			target_type = "tag"
			sources = ["environment"]
			target = "env"
			override_on_conflict = false
			preserve_source = true
		}
	}
	processor {
    category_processor {
			name       = "Set team per @projectName"
			is_enabled = false
			target = "team"
      category {
        name = "dataiker"
        filter {
          query = "@projectName:dataiker-app"
        }
      }
    }
  }
	processor {
    lookup_processor {
			name           = "Set team per @projectName"
      is_enabled     = true
      source         = "projectName"
      target         = "team"
      lookup_table   = var.vlookup_project_name_to_team
      # default_lookup = "unknown service"
    }
  }
	processor {
		grok_parser {
			name = "Extract utm_source from path"
			is_enabled = true
			grok {
				match_rules = "rule .*(\\?)?(&)?utm_source=%%{word:proxy.path_utm_source}.*"
				support_rules = ""
			}
			source = "proxy.path"
			samples = ["/test?utm_source=test", "/test?utm_source=test&utm_campaign=test", "/test?utm_source=test&utm_campaign=test&utm_content=test", "/test?utm_source=test&utm_campaign=test&utm_content=test&utm_term=test", "some_path?ref=123&utm_source=test&foo=bar"]
		}
	}
	processor {
		attribute_remapper {
			name = "@team to team"
			is_enabled = true
			source_type = "attribute"
			target_type = "tag"
			sources = ["team"]
			target = "team"
			override_on_conflict = false
			preserve_source = true
		}
	}
	processor {
    lookup_processor {
			name           = "isAdmin"
      is_enabled     = true
      source         = "proxy.clientIp"
      target         = "isAdmin"
      lookup_table   = var.vlookup_is_admin
      default_lookup = "false"
    }
  }
}