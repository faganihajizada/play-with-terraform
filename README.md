# play-with-terraform1
play with terraform: part1 - create ec2 instance and run apache web server

Step 1: Check required files and change variables if required

    - provider.tf
    - main.tf
    - variable.tf
    - outputs.tf

Step 2: terraform init and validate

    - terraform init
    - terraform validate

Step 3: Plan and Apply

    -  terraform plan 
    -  terraform apply

    note: (-var="image_id=ami-abc123" & -var-file="variables.tf")

Step 4: Validate services created on AWS