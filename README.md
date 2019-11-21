# docker-binaryninja

[![Build Status](https://travis-ci.com/devtty1er/docker-binaryninja.svg?branch=dev)](https://travis-ci.com/devtty1er/docker-binaryninja)
![Version](https://img.shields.io/docker/v/devtty1er/binaryninja-version?color=blue&sort=date)

<img align="right" height="195" width="300" src="logo.png" >

Private Docker image build chain

To replicate this build chain:

1. Create a Docker image with Binary Ninja in `/opt/binaryninja/`, `/root/.binaryninja/license.dat`, and a `binaryninja.pth` in a site-packages directory, e.g.
    ```
    echo "/opt/binaryninja/python" > \
      $(python3 -c 'import site; \
      print(site.getsitepackages()[0] \
      + "/binaryninja.pth")')
    ```

2. Upload the Docker image to a **private** Docker registry
3. Fork this repo
4. Configure Travis CI, setting the `$DOCKER_USER` and `$DOCKER_IMAGE`<sup>*</sup> [environment variables](https://docs.travis-ci.com/user/environment-variables/#defining-public-variables-in-travisyml), and a `$DOCKER_PASSWORD` [encrypted variable](https://docs.travis-ci.com/user/environment-variables/#defining-encrypted-variables-in-travisyml) in [`.travis.yml`](.travis.yml)
5. Enable Travis CI with [cron jobs](https://docs.travis-ci.com/user/cron-jobs/) for each branch

<i>* In `.travis.yml`, `ubuntu:latest` is tagged and pushed as `$DOCKER_IMAGE-version` to generate the public badge on this README, because `$DOCKER_IMAGE` is private.</i>
