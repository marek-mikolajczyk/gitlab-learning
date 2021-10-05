### thedevelopers

# create thedeveloper group
resource "gitlab_group" "thedevelopers_group" {
    name = "thedevelopers_group"
    path = "thedevelopers"
    description = "group for thedevelopers"
    visibility_level = "public"
}

# create thedeveloper users

resource "gitlab_user" "thedeveloper_users" {
	count 			  = var.ressources_count_number
    name             = "thedeveloper ${count.index}"
    username         = "thedeveloper-${count.index}"
    password         = "haslo123"
    email            = "thedeveloper-${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = false
    reset_password   = false
}

# add users to group
resource "gitlab_group_membership" "thedevelopers_team_members" {
  count 	   = var.ressources_count_number
  group_id     = gitlab_group.thedevelopers_group.id
  user_id      = gitlab_user.thedeveloper_users[count.index].id
  access_level = "owner"
  expires_at   = "2030-12-31"
}


# create thedeveloper projects
resource "gitlab_project" "thedevelopers_sample_projects" {
    count = var.ressources_count_number
    name = "thedevelopers_project_${count.index}"
    namespace_id = gitlab_group.thedevelopers_group.id
    description = "thedevelopers project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

#resource "gitlab_project_membership" "thedevelopers_projects_membership" {
#  count 	   = var.ressources_count_number
#  project_id   = gitlab_project.thedevelopers_sample_projects[count.index].id
#  user_id      =  gitlab_user.thedeveloper_users[count.index].id
#  access_level = "maintainer"
#}

# Add thedevelopers' projects to the thedeveloper group
#resource "gitlab_project" "thedevelopers_group_project" {
#    count = var.ressources_count_number
#    name = "thedevelopers_project_${count.index}"
#    namespace_id = gitlab_group.thedevelopers_group.id
#}

