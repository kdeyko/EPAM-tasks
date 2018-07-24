# To deploy use:  
```
terraform init
terraform apply -var 'access_key=YOUR-ACCESS-KEY' -var 'secret_key=YOUR-SECRET-KEY' -var 'key_pair_name=YOUR-KEY-PAIR-NAME'
# wait a bit and type "yes" when it ask for
```
You can also use `-var 'region=SOME-REGION'`, but (because of terraform & AWS bug) then you **have to do 2 things**:  
1) change the default value for bucket_name variable in variables.tf  
2) set the same bucket name in userdata.sh (lines start with "proxy_set_header" and "proxy_pass")  
Default region is "us-east-2" (Ohio). The config tested on us-east-1 and us-east-2.  
  
After successful resources creation take a look at outputs: you'll have bastion ip (for ssh-ing to web-server instances through bastion instance) and the ELB DNS-name which you can visit to check if everything works.  
  
# For deletion use:
```
terraform apply -var 'access_key=YOUR-ACCESS-KEY' -var 'secret_key=YOUR-SECRET-KEY' -var 'key_pair_name=YOUR-KEY-PAIR-NAME'
```
If you also specified region or other vars, specify them here too for successful deletion.