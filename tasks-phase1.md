IMPORTANT ❗ ❗ ❗ Please remember to destroy all the resources after each work session. You can recreate infrastructure by creating new PR and merging it to master.
  
![img.png](doc/figures/destroy.png)

1. Authors:

   *Z1*

   *https://github.com/PCzerska/tbd-workshop-1.git*
   
2. Follow all steps in README.md.

3. In boostrap/variables.tf add your emails to variable "budget_channels".

4. From avaialble Github Actions select and run destroy on main branch.
   
5. Create new git branch and:
    1. Modify tasks-phase1.md file.
    
    2. Create PR from this branch to **YOUR** master and merge it to make new release. 
    
![img.png](doc/figures/p5.png)


6. Analyze terraform code. Play with terraform plan, terraform graph to investigate different modules.

     Moduł data-pipelines odpowiada za przygotowanie infratruktury do przechowywania kodu i danych niezbędnych do przetwarzania w gcp. Tworzy w Google Cloud Storage 2 buckety - na dane (tbd-data-bucket) i na kod (tbd-code-bucket). Do bucketów przesyłane są pliki z kodem Spark, DAG-ami oraz projektami jako obiekty GCS. Moduł przypisuje również odpowiednie role, umożliwiające dostęp do zasobów wybranym kontom serwisowym. 
     ![img.png](modules/data-pipeline/data-pipelines-graph.png)
   
8. Reach YARN UI
   
   gcloud compute ssh tbd-cluster-m --project=tbd-2025l-313596 --zone=europe-west1-d --tunnel-through-iap -- -L 8088:localhost:8088
   ![obraz](https://github.com/user-attachments/assets/53656485-a08e-40f6-bdec-e0da198c694c)


   
10. Draw an architecture diagram (e.g. in draw.io) that includes:
    1. VPC topology with service assignment to subnets
    2. Description of the components of service accounts
    3. List of buckets for disposal
    4. Description of network communication (ports, why it is necessary to specify the host for the driver) of Apache Spark running from Vertex AI Workbech
  
    ***place your diagram here***

11. Create a new PR and add costs by entering the expected consumption into Infracost
For all the resources of type: `google_artifact_registry`, `google_storage_bucket`, `google_service_networking_connection`
create a sample usage profiles and add it to the Infracost task in CI/CD pipeline. Usage file [example](https://github.com/infracost/infracost/blob/master/infracost-usage-example.yml) 

   ***place the expected consumption you entered here***

   ***place the screenshot from infracost output here***

11. Create a BigQuery dataset and an external table using SQL
    
    ***place the code and output here***
   
    ***why does ORC not require a table schema?***

12. Find and correct the error in spark-job.py

    ***describe the cause and how to find the error***

13. Add support for preemptible/spot instances in a Dataproc cluster

    ***place the link to the modified file and inserted terraform code***
    
    
