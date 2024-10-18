include .env
export

# The target deployment for tf commands: setup / app / usecase / ...
TARGET ?= domain
# The target deployment for docker commands (./docker folder): setup / app / usecase / ...
# The target environment (./environments folder): prod / dev / sandbox
ENV ?= sandbox


#
DOCKER_DIR ?= docker
VERSION ?= $(shell date +"%Y.%m.%d")
TAG ?= latest

# If working with dockers, they'll be calculated lazy
AWS_ACCOUNT_ID=$(shell aws sts get-caller-identity --query "Account" --output text)
AWS_REGION=$(shell aws configure get region)

PORKBUN_API_KEY:=$(PORKBUN_API_KEY)

.PHONY :  aws/ tf/

# LOGIN
aws/login :
	@aws sso login

## TERRAFORM COMMANDS: TARGET / INIT
# TARGET=deployment app
tf/init:
	terraform -chdir=./deployments/$(TARGET) init -backend-config=../../environments/$(ENV)/$(TARGET)/backend.conf

tf/apply:
	terraform -chdir=./deployments/$(TARGET) apply -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars

tf/apply/module:
	terraform -chdir=./deployments/$(TARGET) apply -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars -target=module.$(MODULE)

tf/apply/y:
	terraform -chdir=./deployments/$(TARGET) apply -auto-approve -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars

tf/destroy:
	terraform -chdir=./deployments/$(TARGET) destroy -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars

tf/destroy/module:
	terraform -chdir=./deployments/$(TARGET) destroy -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars -target=module.$(MODULE)

tf/destroy/y:
	terraform -chdir=./deployments/$(TARGET) destroy -auto-approve -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars

tf/plan:
	terraform -chdir=./deployments/$(TARGET) plan -var-file=../../environments/$(ENV)/$(TARGET)/terraform.tfvars
