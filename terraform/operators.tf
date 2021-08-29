### operators

# create operator group
resource "gitlab_group" "operators_group" {
    name = "operators_group"
    path = "operators"
    description = "group for operators"
}

# create operator users

resource "gitlab_user" "operator_users" {
	count 					 = 3
    name             = "operator ${count.index}"
    username         = "operator_${count.index}"
    password         = "haslo123"
    email            = "operator_${count.index}@marekexample.com"
    is_admin         = true
    can_create_group = false
    is_external      = true
    reset_password   = false
}

# add ssh key for users to download my github projects
resource "github_user_ssh_key" "operators_github_ssh" {
    title = "operators Github SSH"
    key   = file("~/.ssh/id_rsa")
}

# create operator projects
resource "gitlab_project" "operators_sample_projects" {
    count = 5
    name = "operators_project_${count.index}"
    description = "Operators project ${count.index}"
    visibility_level = "public"
    import_url = "https://github.com/marek-mikolajczyk/ansible.git"

} 

# Add operators' projects to the operator group
resource "gitlab_project" "operators_group_project" {
    count = 5
    name = "operators_project_${count.index}"
    namespace_id = gitlab_group.operators_group.id
}

