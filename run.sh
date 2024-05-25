docker build -t csf .
docker kill csf
docker rm csf

docker run -e TZ=Asia/Bangkok -ti -d --name csf -p 8087:8080 csf
