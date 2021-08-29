### operators

# create operator group
resource "gitlab_group" "operators_group" {
    name = "operators_group"
    path = "operators"
    description = "group for operators"
    visibility_level = "public"
}

# create operator users

resource "gitlab_user" "operator_users" {
	count 			  = var.ressources_count_number
    name             = "operator ${count.index}"
    username         = "operator-${count.index}"
    password         = "haslo123"
    email            = "operator-${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = false
    reset_password   = false
}

# add users to group
resource "gitlab_group_membership" "operators_team_members" {
  count 	   = var.ressources_count_number
  group_id     = gitlab_group.operators_group.id
  user_id      = gitlab_user.operator_users[count.index].id
  access_level = "owner"
  expires_at   = "2030-12-31"
}


# create operator projects
resource "gitlab_project" "operators_sample_projects" {
    count = var.ressources_count_number
    name = "operators_project_${count.index}"
    namespace_id = gitlab_group.operators_group.id
    description = "operators project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

#resource "gitlab_project_membership" "operators_projects_membership" {
#  count 	   = var.ressources_count_number
#  project_id   = gitlab_project.operators_sample_projects[count.index].id
#  user_id      =  gitlab_user.operator_users[count.index].id
#  access_level = "maintainer"
#}

# Add operators' projects to the operator group
#resource "gitlab_project" "operators_group_project" {
#    count = var.ressources_count_number
#    name = "operators_project_${count.index}"
#    namespace_id = gitlab_group.operators_group.id
#}

