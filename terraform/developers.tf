### developers

# create developer group
resource "gitlab_group" "developers_group" {
    name = "developers_group"
    path = "developers"
    description = "group for developers"
}

# create developer users

resource "gitlab_user" "developer_users" {
	count 					 = 3
    name             = "developer ${count.index}"
    username         = "developer_${count.index}"
    password         = "haslo123"
    email            = "developer_${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = true
    reset_password   = false
}

# add ssh key for users to download my github projects
resource "github_user_ssh_key" "developers_github_ssh" {
    title = "developers Github SSH"
    key   = file("~/.ssh/id_rsa")
}

# create developer projects
resource "gitlab_project" "developers_sample_projects" {
    count = 5
    name = "developers_project_${count.index}"
    description = "developers project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

# Add developers' projects to the developer group
resource "gitlab_project" "developers_group_project" {
    count = 5
    name = "developers_project_${count.index}"
    namespace_id = gitlab_group.developers_group.id
}

