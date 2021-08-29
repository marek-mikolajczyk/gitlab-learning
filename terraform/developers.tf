### developers

# create developer group
resource "gitlab_group" "developers_group" {
    name = "developers_group"
    path = "developers"
    description = "group for developers"
    visibility_level = "public"
}

# create developer users

resource "gitlab_user" "developer_users" {
	count 			  = var.ressources_count_number
    name             = "developer ${count.index}"
    username         = "developer-${count.index}"
    password         = "haslo123"
    email            = "developer-${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = true
    reset_password   = false
}

# add users to group
resource "gitlab_group_membership" "developers_team_members" {
  count 	   = var.ressources_count_number
  group_id     = gitlab_group.developers_group.id
  user_id      = gitlab_user.developer_users[count.index].id
  access_level = "owner"
  expires_at   = "2030-12-31"
}


resource "gitlab_deploy_key" "developers_deploy_key" {
  count = var.ressources_count_number
  project = gitlab_project.developers_sample_projects[count.index].path_with_namespace
  title   = "id rsa"
  key     = file("~/.ssh/id_rsa.pub")
}
# add ssh key for users to download my github projects
#resource "github_user_ssh_key" "developers_github_ssh" {
#    title = "developers Github SSH"
#    key   = file("~/.ssh/id_rsa.pub")
#}

# create developer projects
resource "gitlab_project" "developers_sample_projects" {
    count = var.ressources_count_number
    name = "developers_project_${count.index}"
    namespace_id = gitlab_group.developers_group.id
    description = "developers project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

# Add developers' projects to the developer group
#resource "gitlab_project" "developers_group_project" {
#    count = var.ressources_count_number
#    name = "developers_project_${count.index}"
#    namespace_id = gitlab_group.developers_group.id
#}

