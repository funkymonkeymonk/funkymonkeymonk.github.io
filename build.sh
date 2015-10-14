#!/bin/bash

function run_jekyll {
  docker run -it --rm --volume=$(pwd):/srv/jekyll \
    -p 4000:4000 jekyll/jekyll:pages jekyll serve --watch --baseurl ""
}

# For development
run_jekyll


# I feel like there has to be a way to get grunt to work wit/inside
# a docker container. I want to be able to make changes to the page, and have
# all tests run in the container, while also having the change reflected in
# my browser
