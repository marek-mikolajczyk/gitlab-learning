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
    is_external      = true
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


resource "gitlab_deploy_key" "operators_deploy_key" {
  count = var.ressources_count_number
  project = gitlab_project.operators_sample_projects[count.index].path_with_namespace
  title   = "id rsa"
  key     = file("~/.ssh/id_rsa.pub")
}
# add ssh key for users to download my github projects
#resource "github_user_ssh_key" "operators_github_ssh" {
#    title = "operators Github SSH"
#    key   = file("~/.ssh/id_rsa.pub")
#}

# create operator projects
resource "gitlab_project" "operators_sample_projects" {
    count = var.ressources_count_number
    name = "operators_project_${count.index}"
    namespace_id = gitlab_group.operators_group.id
    description = "operators project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

# Add operators' projects to the operator group
#resource "gitlab_project" "operators_group_project" {
#    count = var.ressources_count_number
#    name = "operators_project_${count.index}"
#    namespace_id = gitlab_group.operators_group.id
#}

