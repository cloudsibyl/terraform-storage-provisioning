# ============================
#  Terraform Makefile Wrapper
# ============================

# Default tfvars file (can be overridden: make snowflake TFVARS=custom.tfvars)
TFVARS ?= terraform.tfvars

# ---------- Install Terraform on Amazon Linux ----------
init:
	@echo "Checking for Terraform installation..."
	if ! command -v terraform >/dev/null 2>&1; then \
		echo "Terraform not found. Installing..."; \
		sudo yum install -y yum-utils && \
		sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
		sudo yum -y install terraform; \
	else \
		echo "Terraform is already installed."; \
	fi

# ---------- RUN 1: Snowflake only ----------
snowflake:
	terraform init -input=false
	terraform apply -input=false -var-file="$(TFVARS)" -var="enable_cloudsibyl_access=false"

# ---------- RUN 2: Add CloudSibyl access ----------
cloudsibyl:
	terraform init -input=false
	terraform apply -input=false -var-file="$(TFVARS)" -var="enable_cloudsibyl_access=true"

# ---------- Just show what would change ----------
plan:
	terraform init -input=false
	terraform plan -input=false -var-file="$(TFVARS)"

# ---------- Destroy everything ----------
destroy:
	terraform destroy -input=false -var-file="$(TFVARS)"
