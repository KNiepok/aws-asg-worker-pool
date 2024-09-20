how to work with that:

1. use https://docs.spacelift.io/concepts/worker-pools#generate-worker-private-key to create a key pair
2. create a worker pool in spacelift with the spacelift.csr generated via step 1 
3. store the config generated
4. create a Terraform stack, tracking this repository
5. attach a working AWS cloud integration to the stack 
6. set env vars in the stack:
    - TF_VAR_spacelift_token: the token stored in step 3
    - TF_VAR_spacelift_pool_private_key: the based spacelift.key generated in step 1 (cat spacelift.key | base64 -b 0 | pbcopy)
    - TF_VAR_ami_id: the ami id to use for the worker pool (get it https://github.com/spacelift-io/spacelift-worker-image/releases)
    - (optional) TF_VAR_worker_pool_size: the number of workers in the pool
7. run the stack
8. wait a a minute for ASG to scale up the workers, then a minute more for Spacelift to register workers
9. ???
10. profit
