sudo: required
services:
  - docker
env:
  global:
    - IMAGE_NAME=cartahub/devops
    - REGISTRY_USER=root
    - REGISTRY_PASS=MyPassword@1234
    - secret: "MyPassword@1234"

before_script:
  - docker pull "$IMAGE_NAME" || true
script:
  - docker build --pull --cache-from "${IMAGE_NAME}:develop" --tag "$IMAGE_NAME" .

after_script:
  - docker images

before_deploy:
  - docker login -u "$REGISTRY_USER" -p "$REGISTRY_PASS"
  - docker tag "$IMAGE_NAME" "${IMAGE_NAME}:latest"
  - docker tag "$IMAGE_NAME" "${IMAGE_NAME}:${git_sha}-develop"
deploy:
  provider: script
  script: docker push "${IMAGE_NAME}:latest" && docker push "${IMAGE_NAME}:${git_sha}-develop"
  on:
    branch: master
