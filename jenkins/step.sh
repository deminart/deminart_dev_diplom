# First step
echo "-----Update repo-----"
cd /git/sf_diplom_build && git pull
echo "-----Image build-----"
docker build -t xxja7xx/diplom-sf .
echo "-----Image push to docker registry-----"
docker push xxja7xx/diplom-sf

# Second step 
echo "-----Connect to master server-----"
ssh root@master-0 helm upgrade --install app /helm/Chart-app --atomic

# Thirst step
echo "-----Show pods-----"
ssh root@master-0 kubectl get pods
echo "-----Show svc-----"
ssh root@master-0 kubectl get svc
