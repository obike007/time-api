# time-api
use of time-api-returns-current-server-time

To run this time-api you need to execute:
$ terraform init
$ terraform plan
$ terraform apply

Name and Version
terraform	>= 1.3
aws	>= 5.0
local	>= 2.5
null	>= 2.0
tls	>= 3.1

Name	Version
aws	>= 5.37
local	>= 2.5
null	>= 2.0
tls	>= 3.1

When this ran terraform will output:
terraform output alb_dns_name

curl or paste the output alb_dns to see the server-time api in real time
curl http://<ALB_DNS_NAME>

