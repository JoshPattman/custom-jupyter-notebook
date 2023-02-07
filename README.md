# custom-jupyter-notebook
My custom jupyter notebook and python environment for uni work
## Requirements
- Docker
## How to use
### Installing
If you have a GPU and nvidia-container-toolkit/nvidia-docker then run `env USE_GPU=true ./build.sh`. If you don't want GPU support run `./build.sh`. This will build the docker image and create a new directory `./bin`. Add this directory to your PATH.
### Password
Change ./bin/password.txt to change the notebook password
### Local files
Add absolute directories to ./bin/mounts.txt to see them in you environment
## Jupyter Notebook
Run `jupyter-nb`. This will start a notebook server in a docker image. Visit localhost:8888 to see your notebook.
## Terminal
Run `jupyter-nb`. Then in a new window run `jupyter-nb-sh` to connect to the terminal of your environment.