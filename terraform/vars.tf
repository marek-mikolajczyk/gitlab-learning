variable "GITLAB_TOKEN" {
    type            = string
    description     = "This is token for root user"
}


variable "ressources_count_number" {
    type            = number
    description     = "number of ressources like projct or users"
	default			=	2	
}
