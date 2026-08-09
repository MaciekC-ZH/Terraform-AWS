# 1. Zwykły String (Napis)
variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

# 2. LISTA (Array/List) – Użyjemy jej do podania listy portów do otwarcia!
variable "ingress_ports" {
  description = "Lista portów wejściowych w Security Group"
  type        = list(number)
  default     = [22, 80, 443] # SSH, HTTP, HTTPS
}

# 3. MAPA (Słownik/Dictionary) – Użyjemy jej do przechowywania tagów środowiskowych!
variable "project_tags" {
  description = "Mapa tagów przypisywana do zasobów"
  type        = map(string)
  default = {
    Environment = "Development"
    Owner       = "Maciek"
    Project     = "Terraform-Course"
  }
}