# Copy a .pem or .pub to all AWS regions

### 1. Get the .pub
  - If you have an rsa key then you already have a `.pub` you can skip this step.
  - If you have a `.pem` file then you want to extract the `.pub` and use that so only
    the public half of the `.pem` is copied over. You dont want to transfer the `.pem`.
    ```bash
    ssh-keygen -y -f key.pem > key.pub
    ```

### 2. Using the aws cli copy the specific .pub to all regions
  - If you want to copy to only a subset you can maually set the regions variable or manually filter it.
  - This does require you have the aws cli setup on your machine.
  ```bash
  keypair=$USER  # or some name that is meaningful to you
  publickeyfile=$HOME/.ssh/id_rsa.pub #change this to the new .pub key
  regions=$(aws ec2 describe-regions \
    --output text \
    --query 'Regions[*].RegionName')

  for region in $regions; do
    echo $region
    aws ec2 import-key-pair \
      --region "$region" \
      --key-name "$keypair" \
      --public-key-material "file://$publickeyfile"
  done
  ```
  
  - Note: the command will throw an error if the key already exists in the region. so won't overwrite :)

# Sources
1. https://stackoverflow.com/a/10271238/9455890
2. https://alestic.com/2010/10/ec2-ssh-keys/
3. https://stackoverflow.com/a/10207871/9455890
