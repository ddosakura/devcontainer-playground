```bash
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
# docker image ls --format="{{json .}}"
# if Error response from daemon: conflict: unable to delete bb6d5b4f3b9f (must be forced) - image is referenced in multiple repositories
docker rmi $(docker image ls --format="{{.Repository}}:{{.Tag}}")
```
