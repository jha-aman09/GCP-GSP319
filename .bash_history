gcloud config set project qwiklabs-gcp-02-dcfc016e9520
git clone https://github.com/GoogleCloudPlatform/monolith-to-microservices.git
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
cd monolith-to-microservices
./setup.sh
nvm install --lts
cd monolith
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-monolith-307:1.0.0 .
gcloud container clusters create fancy-production-867   --zone=us-east4-c   --num-nodes=3   --machine-type=e2-medium
kubectl create deployment fancy-monolith-307   --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-monolith-307:1.0.0
kubectl expose deployment fancy-monolith-307   --type=LoadBalancer   --port=80   --target-port=8080
kubectl get service
cd ~/monolith-to-microservices/microservices/src/orders
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-orders-692:1.0.0 .
cd ~/monolith-to-microservices/microservices/src/products
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-products-347:1.0.0 .
kubectl create deployment fancy-orders-692   --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-orders-692:1.0.0
kubectl expose deployment fancy-orders-692   --type=LoadBalancer   --port=80   --target-port=8081
kubectl create deployment fancy-products-347   --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-products-347:1.0.0
kubectl expose deployment fancy-products-347   --type=LoadBalancer   --port=80   --target-port=8082
kubectl get service
nano .env
npm run build
cd ~/monolith-to-microservices/react-app
nano .env
npm run build
cd ~/monolith-to-microservices/microservices/src/frontend
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-frontend-729:1.0.0 .
kubectl create deployment fancy-frontend-729   --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-frontend-729:1.0.0
kubectl expose deployment fancy-frontend-729   --type=LoadBalancer   --port=80   --target-port=8080
kubectl get service
