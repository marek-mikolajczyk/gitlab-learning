### theoperators

# create theoperator group
resource "gitlab_group" "theoperators_group" {
    name = "theoperators_group"
    path = "theoperators"
    description = "group for theoperators"
    visibility_level = "public"
}

# create theoperator users

resource "gitlab_user" "theoperator_users" {
	count 			  = var.ressources_count_number
    name             = "theoperator ${count.index}"
    username         = "theoperator-${count.index}"
    password         = "haslo123"
    email            = "theoperator-${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = false
    reset_password   = false
}

# add users to group
resource "gitlab_group_membership" "theoperators_team_members" {
  count 	   = var.ressources_count_number
  group_id     = gitlab_group.theoperators_group.id
  user_id      = gitlab_user.theoperator_users[count.index].id
  access_level = "owner"
  expires_at   = "2030-12-31"
}


# create theoperator projects
resource "gitlab_project" "theoperators_sample_projects" {
    count = var.ressources_count_number
    name = "theoperators_project_${count.index}"
    namespace_id = gitlab_group.theoperators_group.id
    description = "theoperators project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

#resource "gitlab_project_membership" "theoperators_projects_membership" {
#  count 	   = var.ressources_count_number
#  project_id   = gitlab_project.theoperators_sample_projects[count.index].id
#  user_id      =  gitlab_user.theoperator_users[count.index].id
#  access_level = "maintainer"
#}

# Add theoperators' projects to the theoperator group
#resource "gitlab_project" "theoperators_group_project" {
#    count = var.ressources_count_number
#    name = "theoperators_project_${count.index}"
#    namespace_id = gitlab_group.theoperators_group.id
#}

