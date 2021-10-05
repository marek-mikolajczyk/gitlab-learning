# Configure the GitLab Provider
terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.6.0"
    }
  }
}
#  backend "s3" {
#
#    bucket = "gitlab-marekexample"
#    key    = "tf-state"
#    region = "eu-west-1"
#  }
#		github = {
#     source  = "integrations/github"
#     version = "~> 4.0"
#    }
  

 provider "gitlab" {
    token = var.GITLAB_TOKEN
		base_url = "https://gitlab-geo.marekexample.com/api/v4/"
		insecure = true
}

#provider "github" {
#  token = var.GITLAB_TOKEN
#  base_url = "http://gitlab-geo.marekexample.com/"
#}
