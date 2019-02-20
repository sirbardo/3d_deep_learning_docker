FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

WORKDIR /home
COPY . /home

RUN apt-get update 
RUN apt-get -y install software-properties-common 
RUN add-apt-repository ppa:deadsnakes/ppa -y 
RUN apt-get -y install python3.7-dev 
RUN apt-get -y install python3-pip
RUN apt-get -y install vim
RUN apt-get -y install htop
RUN apt-get -y install git
RUN echo "#!/bin/bash\npython3.7 -m pip \$@">/usr/bin/pip
RUN chmod +x /usr/bin/pip
RUN ln -s /usr/bin/python3.7 /usr/bin/python
RUN pip install --upgrade pip
RUN apt-get -y install nodejs npm
RUN cat requirements.txt | xargs -n 1 -L 1 pip install
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

EXPOSE 9999:9999
CMD ["jupyter", "lab", "--port", "9999"]

